//
//  RoutingEnum+Navigation.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

extension RoutingEnum: EnumCaseName {

    func getNavigationInfo(fromVC _: UIViewController?) -> NavigationRouterEnum {
        switch self {
        case .weather:
            return WeatherVC.getNavigationInfo()
        case .landingWelcome:
            return LandingWelcomeVC.getNavigationInfo()
        case .landing:
            return LandingVC.getNavigationInfo()
        case .securityQuestionInfoPopUp:
            return SecurityQuestionInfoPopUpVC.getNavigationInfo()        
        case let .popup(title: title, message: message, type: type, buttonActions: actions):
            return NavigationRouterEnum.popup(
                        title: title,
                        message: message,
                        type: type,
                        buttonActions: actions)
        default:
            return NavigationRouterEnum.none
        }
    }

    func navigate(pageNavigator: PageNavigator = UiPageNavigator(),
                  fromVC: UIViewController? = nil,
                  clearNavigationStack: Bool? = nil,
                  openOwnTab: Bool? = nil,
                  tabIndex: Int? = nil,
                  replace: Bool = false,
                  animated: Bool = true,
                  isPopup: Bool? = nil,
                  popupCompletion: (() -> Void)? = nil,
                  transitionStyle: RoutingTransitionStyle? = nil) {
        pageNavigator.navigate(fromVC: fromVC,
                               to: self,
                               clearNavigationStack: clearNavigationStack,
                               openOwnTab: openOwnTab,
                               tabIndex: tabIndex,
                               replace: replace,
                               animated: animated,
                               isPopup: isPopup,
                               popupCompletion: popupCompletion,
                               transitionStyle: transitionStyle)
    }

}
