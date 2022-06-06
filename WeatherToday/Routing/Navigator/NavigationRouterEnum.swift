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
    case popPage(popCount: Int)
    case popToRoot(animated: Bool)
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
        case (.popPage, .popPage):
            return true
        case (.popToRoot, .popToRoot):
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
