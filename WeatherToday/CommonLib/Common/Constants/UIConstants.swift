//
//  UIConstants.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public enum UIConstants {
    public static let mainWindowWidth = { () -> CGFloat in
        UIScreen.main.bounds.size.width
    }()

    public static let mainWindowHeight = { () -> CGFloat in
        UIScreen.main.bounds.size.height
    }()

    public static let statusBarHeight = { () -> CGFloat in
        let application = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as? UIApplication
        return application?.statusBarFrame.height ?? 0
    }()

    public static let navigationBarHeight = { () -> CGFloat in
        let nav = UINavigationController()
        return nav.navigationBar.frame.height
    }()

    public static let navigationBarInset = { () -> UIEdgeInsets in
        UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
    }()

    public static let navigationBarButtonSize = { () -> CGFloat in
        UIConstants.navigationBarHeight - (UIConstants.navigationBarInset.top * UIConstants.navigationBarInset.bottom)
    }()

    public static let spotlightIconSize = { () -> CGRect in
        CGRect(x: 0, y: 0, width: 120, height: 120)
    }()

    public static func safeAreaInsets() -> UIEdgeInsets {
        let window = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared.keyWindow)) as? UIWindow
        if #available(iOS 11.0, *), let inset = window?.safeAreaInsets {
            return inset
        }

        return UIEdgeInsets.zero
    }
}
