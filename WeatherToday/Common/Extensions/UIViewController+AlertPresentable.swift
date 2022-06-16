//
//  UIViewController+AlertPresentable.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit

extension UIViewController {
    var alertPresentableViewController: UIViewController? {
        var viewController: UIViewController? = self
        while viewController?.presentedViewController != nil, viewController != viewController?.presentedViewController {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
}
