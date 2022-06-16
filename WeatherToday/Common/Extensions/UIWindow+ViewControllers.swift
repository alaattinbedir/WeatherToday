//
//  UIWindow+ViewControllers.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

extension UIWindow {
    func topMostViewController() -> UIViewController? {
        guard let rootViewController = rootViewController else { return nil }
        return topViewController(for: rootViewController)
    }

    func topViewController(for rootViewController: UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else { return nil }

        guard let presentedViewController = rootViewController.presentedViewController else {
            if let childViewController = rootViewController.children.last {
                return topViewController(for: childViewController)
            }
            return rootViewController
        }

        if let navigationController = presentedViewController as? UINavigationController {
            return topViewController(for: navigationController.viewControllers.last)
        } else if let tabBarController = presentedViewController as? UITabBarController {
            return topViewController(for: tabBarController.selectedViewController)
        } else {
            return topViewController(for: presentedViewController)
        }
    }
}
