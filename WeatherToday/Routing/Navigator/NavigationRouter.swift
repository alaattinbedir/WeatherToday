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
}

enum StoryboardID: String {
    case splash = "Splash"
    case main = "Main"
}
