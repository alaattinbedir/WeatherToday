//
//  NavigationRouter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

class NavigationRouter {
    // MARK: Push View Controller

    static func push(fromVC: UIViewController,
                     toStoryboard: StoryboardID,
                     toVC: ViewControllerId,
                     animated: Bool = true,
                     data: Any? = nil,
                     routingEnum: RoutingEnum? = nil,
                     replace: Bool = false) {
        navigate(fromVC: fromVC,
                 destination: .storyboard(toStoryboard, toVC),
                 routingEnum: routingEnum,
                 animated: animated,
                 present: false,
                 replace: replace,
                 data: data,
                 completion: nil)
    }

    static func push(fromVC: UIViewController,
                     toVC: BaseViewController,
                     animated: Bool = true,
                     data: Any? = nil,
                     routingEnum: RoutingEnum? = nil,
                     replace: Bool = false) {
        navigate(fromVC: fromVC,
                 destination: .vc(toVC),
                 routingEnum: routingEnum,
                 animated: animated,
                 present: false,
                 replace: replace,
                 data: data,
                 completion: nil)
    }

    // MARK: Present

    static func present(fromVC: UIViewController,
                        toStoryboard: StoryboardID,
                        toVC: ViewControllerId,
                        animated: Bool = true,
                        data: Any? = nil,
                        routingEnum: RoutingEnum? = nil,
                        completion: (() -> Void)? = nil) {
        navigate(fromVC: fromVC,
                 destination: .storyboard(toStoryboard, toVC),
                 routingEnum: routingEnum,
                 animated: animated,
                 present: true,
                 replace: false,
                 data: data,
                 completion: completion)
    }

    static func present(fromVC: UIViewController,
                        toVC: BaseViewController,
                        animated: Bool = true,
                        data: Any? = nil,
                        routingEnum: RoutingEnum? = nil,
                        completion: (() -> Void)? = nil) {
        navigate(fromVC: fromVC,
                 destination: .vc(toVC),
                 routingEnum: routingEnum,
                 animated: animated,
                 present: true,
                 replace: false,
                 data: data,
                 completion: completion)
    }

    // MARK: Set Root Navigation Controller

    static func go(toStoryboard: StoryboardID,
                   ncID: NavigationControllerID,
                   data: Any? = nil,
                   transitionOptions: UIWindow.TransitionOptions? = nil,
                   routingEnum: RoutingEnum? = nil) {
        if let navigationController = UIStoryboard(name: toStoryboard.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: ncID.rawValue) as? BaseNC {
            let destinationVC = navigationController.topViewController as? BaseViewController
            destinationVC?.data = data
            destinationVC?.routingEnum = routingEnum
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.makeKeyAndVisible()
            var options = UIWindow.TransitionOptions(direction: .fade, style: .easeOut)
            options.duration = 0.4
            if let transitionOptions = transitionOptions {
                options = transitionOptions
            }
            appDelegate?.window?.setRootViewController(navigationController, options: options)
        } else {
            assertionFailure("Something wrong with IDs or Base Classes")
        }
    }

    // MARK: Pop

    static func pop(fromVC: UIViewController, animated: Bool) {
        fromVC.navigationController?.popViewController(animated: animated)
    }

    static func pop(fromVC: UIViewController, count: Int, animated: Bool) {
        if count <= 1 {
            pop(fromVC: fromVC, animated: animated)
        } else if let viewControllers = fromVC.navigationController?.viewControllers {
            let droppedViewControllers = Array(viewControllers.dropLast(count))
            fromVC.navigationController?.setViewControllers(droppedViewControllers, animated: animated)
        }
    }

    @discardableResult
    static func pop<T: UIViewController>(to _: T.Type, fromVC: UIViewController, animated: Bool) -> T? {
        guard let vc = fromVC.navigationController?.viewControllers.first(where: { item in item is T }) as? T else { return nil }
        fromVC.navigationController?.popToViewController(vc, animated: animated)
        return vc
    }

    static func popToRoot(fromVC: UIViewController, animated: Bool) {
        fromVC.navigationController?.popToRootViewController(animated: animated)
    }

    static func setRootVC(viewController: UIViewController) {
        guard let destinationVC = viewController as? BaseViewController else { return }
        destinationVC.data = ""
        guard let window = UIApplication.shared.keyWindow else { return }
        var options = UIWindow.TransitionOptions(direction: .toRight, style: .easeOut)
        options.duration = 0.5
        let navC = UINavigationController(rootViewController: viewController)

        window.setRootViewController(navC, options: options)
    }

    static func navigate(fromVC: UIViewController,
                         destination: Destination,
                         routingEnum: RoutingEnum? = nil,
                         wrapWithNavigationController: Bool = false,
                         animated: Bool = true,
                         present: Bool = false,
                         replace: Bool = false,
                         data: Any? = nil,
                         completion: (() -> Void)? = nil) {
        guard let destinationViewController = destination.getDestinationViewController() as? BaseViewController else { return }
        destinationViewController.routingEnum = routingEnum
        destinationViewController.data = data

        if present {
            if destinationViewController.modalPresentationStyle == .pageSheet ||
                destinationViewController.modalPresentationStyle == .formSheet {
                destinationViewController.modalPresentationStyle = .fullScreen
            }

            if #available(iOS 13.0, *), destinationViewController.modalPresentationStyle == .automatic {
                destinationViewController.modalPresentationStyle = .fullScreen
            }

            if wrapWithNavigationController {
                let navigationController = BaseNC(rootViewController: destinationViewController)
                destinationViewController.isPresentedModally = true
                if navigationController.viewControllers.count > 0 {
                    navigationController.modalPresentationStyle = .fullScreen
                    fromVC.present(navigationController, animated: animated, completion: completion)
                }
            } else {
                destinationViewController.isPresentedModally = true
                fromVC.present(destinationViewController, animated: animated, completion: completion)
            }
        } else if let navigationController = (fromVC as? UINavigationController) ?? fromVC.navigationController {
            if replace, navigationController.viewControllers.count > 0 {
                var controllers = navigationController.viewControllers
                controllers[controllers.count - 1] = destinationViewController
                navigationController.setViewControllers(controllers, animated: animated)
                return
            }
            navigationController.pushViewController(destinationViewController, animated: animated)
        }
    }

    enum Destination {
        case storyboard(StoryboardID, ViewControllerId)
        case vc(UIViewController)

        func getDestinationViewController() -> UIViewController? {
            if case let .vc(destinationVC) = self {
                return destinationVC
            }

            if case let .storyboard(storyboardID, viewControllerId) = self,
               let destinationVC = UIStoryboard(name: storyboardID.rawValue, bundle: nil)
               .instantiateViewController(withIdentifier: viewControllerId.rawValue) as? BaseViewController {
                return destinationVC
            }

            return nil
        }
    }
}

enum ViewControllerId: String {
    case splash = "SplashVC"
    case weather = "WeatherVC"
    case landingWelcomeVC = "LandingWelcomeVC"
    case landingWelcomeVC2 = "LandingWelcomeVC2"

}

enum StoryboardID: String {
    case splash = "Splash"
    case landingWelcome = "LandingWelcome"
    case landingWelcome2 = "LandingWelcome2"

}

enum NavigationControllerID: String {
    case splash = "SplashNC"
    case landing = "LandingNC"
    case environmentConfig = "ConfigurationNC"
    case login = "LoginNC"
    case welcome = "WelcomeNC"
}

enum TabBarControllerID: String {
    case mainTabbar = "BaseTC"
}
