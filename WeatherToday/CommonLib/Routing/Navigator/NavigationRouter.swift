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
                     toVC: MDViewController,
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
                        toVC: MDViewController,
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

    static func navigate(fromVC: UIViewController,
                         destination: Destination,
                         routingEnum: RoutingEnum? = nil,
                         wrapWithNavigationController: Bool = false,
                         animated: Bool = true,
                         present: Bool = false,
                         replace: Bool = false,
                         data: Any? = nil,
                         completion: (() -> Void)? = nil) {
        guard let destinationViewController = destination.getDestinationViewController() as? MDViewController else { return }
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
               .instantiateViewController(withIdentifier: viewControllerId.rawValue) as? MDViewController {
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
