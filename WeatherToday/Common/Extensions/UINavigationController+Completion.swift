//
//  UINavigationController+Completion.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import UIKit

extension UINavigationController {
    func pushViewController(viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
