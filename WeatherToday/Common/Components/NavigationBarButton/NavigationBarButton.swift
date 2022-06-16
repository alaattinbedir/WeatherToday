//
//  NavigationBarButton.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

typealias NavigationBarButtonHandler = () -> Void

enum NavigationBarButton: Equatable {
    case back(NavigationBarButtonHandler?)
    case settings
    case close(NavigationBarButtonHandler?)
    case custom(NavigationBarButtonData)

    var title: String? {
        switch self {
        case let .custom(buttonData):
            return buttonData.title?.value
        default:
            return nil
        }
    }

    var titleColor: UIColor? {
        switch self {
        case let .custom(buttonData):
            return buttonData.titleColor
        default:
            return .warmGrey
        }
    }

    var icon: UIImage? {
        switch self {
        case .back:
            return #imageLiteral(resourceName: "backButton.png").with(size: 14)
        case .settings:
            return #imageLiteral(resourceName: "setting")
        case .close:
            return #imageLiteral(resourceName: "pinkClose")
        case let .custom(buttonData):
            return buttonData.image
        }
    }

    var accessibilityKey: AccessibilityKey {
        switch self {
        case .back:
            return .back
        case .settings:
            return .settings
        case .close:
            return .close
        case .custom:
            return .custom
        }
    }

    static func == (lhs: NavigationBarButton, rhs: NavigationBarButton) -> Bool {
        switch (lhs, rhs) {
        case (.back, .back):
            return true
        case (.settings, .settings):
            return true
        case (.close, .close):
            return true
        case (.custom, .custom):
            return true
        default:
            return false
        }
    }
}

enum NavigationBarButtonPosition: Int {
    case left = 1
    case right
}

class NavigationBarButtonData {
    var title: ResourceKey?
    var titleColor: UIColor?
    var image: UIImage?
    var handler: ((UIButton) -> Void)?

    init(title: ResourceKey? = nil,
         titleColor: UIColor? = nil,
         image: UIImage?,
         handler: ((UIButton) -> Void)?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
        self.handler = handler
    }
}
