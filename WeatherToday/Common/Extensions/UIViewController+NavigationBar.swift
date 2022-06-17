//
//  UIViewController+NavigationBar.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

enum NavigationBarAppearance: Int {
    case `default`
    case transparent
    case background
}

extension UIViewController {
    func makeBackBarItemEmpty() {
        let barbuttonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        barbuttonItem.tintColor = .white
        barbuttonItem.isAccessibilityElement = true
        barbuttonItem.accessibilityIdentifier = "btnBack"
        navigationItem.backBarButtonItem = barbuttonItem
    }

    func makeBackBarItem(withAction action: Selector) {
        let barbuttonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: action)
        barbuttonItem.tintColor = .white
        barbuttonItem.accessibilityIdentifier = "back.btn"
        navigationItem.leftBarButtonItem = barbuttonItem
        navigationItem.accessibilityLabel = "pageTitle.lbl"
    }

    func addNavigationBarButton(navigationBarButton: NavigationBarButton,
                                position: NavigationBarButtonPosition,
                                willReset: Bool = true,
                                action: Selector) {
        let barButtonItem = UIBarButtonItem(image: navigationBarButton.icon,
                                            style: .plain,
                                            target: self,
                                            action: action)
        barButtonItem.tintColor = .white
        barButtonItem.accessibilityIdentifier = String(describing: navigationBarButton)
        if position == .left {
            if willReset {
                navigationItem.leftBarButtonItem = barButtonItem
            } else {
                if navigationItem.leftBarButtonItems == nil {
                    navigationItem.leftBarButtonItems = []
                }
                navigationItem.leftBarButtonItems?.append(barButtonItem)
            }
        } else {
            if willReset {
                navigationItem.rightBarButtonItems = nil
                navigationItem.rightBarButtonItem = barButtonItem
            } else {
                if navigationItem.rightBarButtonItems == nil {
                    navigationItem.rightBarButtonItems = []
                }
                navigationItem.rightBarButtonItems?.append(barButtonItem)
            }
        }
    }

    func makeNavigationBarHidden(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func makeNavigationBarAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func makeNavigationBarBackgroundImage(img: String) {
        if navigationController?.navigationBar.tag != NavigationBarAppearance.background.rawValue {
            let animation = CATransition()
            animation.duration = 0.35
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.type = .fade

            navigationController?.navigationBar.layer.add(animation, forKey: nil)
            navigationController?.navigationBar.tag = NavigationBarAppearance.background.rawValue
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                               self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: img), for: UIBarMetrics.default)
                               self.navigationController?.navigationBar.barTintColor = UIColor(hex: "#CBCBCB")
                           }, completion: nil)
        }
    }

    func presentTransparentNavigationBar(animated: Bool) {
        navigationController?.navigationBar.tag = NavigationBarAppearance.transparent.rawValue
        if animated {
            let animation = CATransition()
            animation.duration = 0.75
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.type = .fade

            navigationController?.navigationBar.layer.add(animation, forKey: nil)
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                               self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                               self.navigationController?.navigationBar.isTranslucent = true
                               self.navigationController?.navigationBar.shadowImage = UIImage()
                               self.navigationController?.view.backgroundColor = .clear

                           }, completion: nil)
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.view.backgroundColor = .clear
        }
    }

    func setBackgroundImage(imageName: String) {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: imageName)?.draw(in: view.bounds)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
    }

    func setNavBarTitleFont() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: AppFont.bold16]
    }
}
