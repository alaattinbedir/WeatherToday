//
//  RoutingEnum+Configuration.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

extension RoutingEnum {
    func transitionStyle(for routingEnum: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle)? {
        guard let routingConfiguration = (getClassType() as? RoutingConfiguration.Type) else { return nil }
        return routingConfiguration.transitionStyle(for: routingEnum)
    }
}

protocol RoutingConfiguration {
    static func transitionStyle(for routingEnum: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle)
    static func getNavigationInfo() -> NavigationRouterEnum
}

extension RoutingConfiguration {
    static func transitionStyle(for _: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle) {
        return (false, RoutingTransitionStyle.none)
    }
}

extension RoutingConfiguration where Self: BaseViewController {
    static func getNavigationInfo() -> NavigationRouterEnum {
        return NavigationRouterEnum.toViewController(toVCType: Self.self, hidesBottomBarWhenPushed: false)
    }
}

