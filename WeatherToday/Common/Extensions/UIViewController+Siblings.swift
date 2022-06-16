//
//  UIViewController+Siblings.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

extension UIViewController {
    var currentViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.viewControllers.last
        }
        return self
    }

    var previousViewController: UIViewController? {
        guard let navigationController = navigationController else { return nil }
        if let index = navigationController.viewControllers.firstIndex(where: { $0 === self }), index > 0 {
            return navigationController.viewControllers[index - 1]
        }
        return nil
    }

    var nextViewController: UIViewController? {
        guard let navigationController = navigationController else { return nil }
        if let index = navigationController.viewControllers.firstIndex(where: { $0 === self }),
           index < navigationController.viewControllers.count - 1 {
            return navigationController.viewControllers[index + 1]
        }
        return nil
    }

    var lastPresentedViewController: UIViewController? {
        var viewController: UIViewController? = self
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }

    func removeFromNavigationController() {
        if let index = navigationController?.viewControllers.firstIndex(where: { $0 === self }) {
            navigationController?.viewControllers.remove(at: index)
        }
    }
}
