//
//  RoutingEnum+Configuration.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

protocol RoutingConfiguration {
    static var voiceOverDisabledPageMessage: String? { get }
    static func isRequireLogin(for routingEnum: RoutingEnum) -> Bool
    static func hasAuthentication(for routingEnum: RoutingEnum) -> (auth: Bool, message: String?)
    static func transitionStyle(for routingEnum: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle)
    static func getNavigationInfo() -> NavigationRouterEnum
}

extension RoutingConfiguration {
    static var voiceOverDisabledPageMessage: String? { nil }

    static func isRequireLogin(for _: RoutingEnum) -> Bool {
        return true
    }

    static func hasAuthentication(for _: RoutingEnum) -> (auth: Bool, message: String?) {
        return (true, nil)
    }

    static func transitionStyle(for _: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle) {
        return (false, RoutingTransitionStyle.none)
    }
}

extension RoutingConfiguration where Self: MDViewController {
    static func getNavigationInfo() -> NavigationRouterEnum {
        return NavigationRouterEnum.toViewController(toVCType: Self.self, hidesBottomBarWhenPushed: false)
    }
}

