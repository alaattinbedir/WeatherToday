//
//  NavigationRouterEnum.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation

enum NavigationRouterEnum {
    case none
    case toStoryBoard(toStoryboard: StoryboardID, toVC: ViewControllerId, toVCType: MDViewController.Type)
    case toViewController(toVCType: MDViewController.Type, hidesBottomBarWhenPushed: Bool = false)
    case toTab(tabIndex: Int, toVCType: MDViewController.Type)
    case safari(url: String)
    case popPage(popCount: Int)
    case popToRoot(animated: Bool)
    case openUrl(url: String, params: [String: String]?)
    case openApp(url: String, params: [String: String]?, appstoreUrl: String)
    case popup(title: String, message: String, type: WarningType, buttonActions: [(title: String, action: () -> Void)])
}

extension NavigationRouterEnum: Equatable {
    static func == (lhs: NavigationRouterEnum, rhs: NavigationRouterEnum) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case let (.toStoryBoard(lhstoStoryboard, lhstoVC, lhstoVCType),
                  .toStoryBoard(rhstoStoryboard, rhstoVC, rhstoVCType)):
            return lhstoStoryboard == rhstoStoryboard && lhstoVC == rhstoVC && lhstoVCType == rhstoVCType        
        case let (toViewController(lhstoVCType, lhshidesBottomBarWhenPushed),
                  toViewController(rhstoVCType, rhshidesBottomBarWhenPushed)):
            return lhstoVCType == rhstoVCType && lhshidesBottomBarWhenPushed == rhshidesBottomBarWhenPushed
        case let (.toTab(lhstabIndex, lhstoVCType), .toTab(rhstabIndex, rhstoVCType)):
            return lhstabIndex == rhstabIndex && lhstoVCType == rhstoVCType
        case (.safari, .safari):
            return true
        case (.popPage, .popPage):
            return true
        case (.popToRoot, .popToRoot):
            return true
        case (.openUrl, .openUrl):
            return true
        case (.openApp, .openApp):
            return true
        case (.popup, .popup):
            return true
        default:
            return false
        }
    }

    func isHidesBottomBarWhenPushed() -> Bool {
        switch self {
        case let .toViewController(toVCType: _, hidesBottomBarWhenPushed):
            return hidesBottomBarWhenPushed
        default:
            return false
        }
    }
}
