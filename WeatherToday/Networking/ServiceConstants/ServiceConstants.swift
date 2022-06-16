//
//  ServiceConstants.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

struct APPURL {
    static let interDev = "janusdenizkartimdev.intertech.com.tr"
    static let interUat = "janusdenizkartimuat.intertech.com.tr"
    static let denizUat = "janusdenizkartimuat.denizbank.com"
    static let interPre = "janusdenizkartimpre.intertech.com.tr"
    static let denizPre = "janusdenizkartimpre.denizbank.com"
    static let pilotDomainName = "janusdenizkartimpilot.denizbank.com"
    static let productionDomainName = "janusdenizkartim.denizbank.com"

    static var baseUrl: String {
        switch SessionKeeper.shared.currentEnvironment {
        case .customUrl:
            return KeychainKeeper.shared.customUrl~
        case .interDev:
            return Domains.interDev
        case .uat:
            return Domains.uat
        case .interUat:
            return Domains.interUat
        case .denizUat:
            return Domains.denizUat
        case .preprod:
            return Domains.preprod
        case .interPre:
            return Domains.interPre
        case .denizPre:
            return Domains.denizPre
        case .pilot:
            return Domains.pilot
        case .prod:
            return Domains.production
        }
    }
}

enum PazaryeriSdk {
    static var url: String {
        switch SessionKeeper.shared.currentEnvironment {
        case .uat:
            return "https://janusuat.denizbank.com"
        case .pilot:
            return "https://januspilot.denizbank.com"
        case .prod:
            return "https://janus.denizbank.com"
        default:
            return "https://janus.denizbank.com"
        }
    }
}

enum AppEnvironment: String {
    case customUrl = "CUSTOM URL"
    case interDev = "INTER-DEV"
    case uat = "UAT"
    case interUat = "INTER-UAT"
    case denizUat = "DENIZ-UAT"
    case preprod = "PREPROD"
    case interPre = "INTER-PRE"
    case denizPre = "DENIZ-PRE"
    case pilot = "PILOT"
    case prod = "PROD"
}

