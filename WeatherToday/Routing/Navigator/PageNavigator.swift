//
//  PageNavigator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

protocol PageNavigator {
    func navigate(fromVC: UIViewController?,
                  to: RoutingEnum,
                  clearNavigationStack: Bool?,
                  openOwnTab: Bool?,
                  tabIndex: Int?,
                  replace: Bool,
                  animated: Bool,
                  isPopup: Bool?,
                  popupCompletion: (() -> Void)?,
                  transitionStyle: RoutingTransitionStyle?)
}
