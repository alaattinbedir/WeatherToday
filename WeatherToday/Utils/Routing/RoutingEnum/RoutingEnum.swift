//
//  RoutingEnum.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation

enum RoutingEnum {
    case none
    case splash
    case landing
    case weather
    case landingWelcome
    case securityQuestionInfoPopUp
    case popup(title: String, message: String, type: WarningType, buttonActions: [(title: String, action: () -> Void)])
}
