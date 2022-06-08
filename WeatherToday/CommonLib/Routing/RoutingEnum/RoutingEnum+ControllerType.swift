//
//  RoutingEnum+ControllerType.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation

extension RoutingEnum {
    func getClassType() -> MDViewController.Type? {
        let navigationInfo = getNavigationInfo(fromVC: nil)
        switch navigationInfo {
        case let .toStoryBoard(_, _, toVCType):
            return toVCType
        case let .toViewController(toVCType, _):
            return toVCType
        case let .toTab(_, toVCType):
            return toVCType
        default:
            return nil
        }
    }

    func toDestination() -> NavigationRouter.Destination? {
        let navigationInfo = getNavigationInfo(fromVC: nil)
        switch navigationInfo {
        case let .toStoryBoard(toStoryboard, toVC, _):
            return .storyboard(toStoryboard, toVC)
        case let .toViewController(toVCType, _):
            return .vc(toVCType.init())
        case let .toTab(_, toVCType):
            return .vc(toVCType.init())
        default:
            return nil
        }
    }
}
