//
//  AppLanguage.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public enum AppLanguage: String {
    case turkish = "TR"
    case english = "EN"

    public func getLocalize() -> String {
        switch self {
        case .turkish:
            return "tr-TR"
        case .english:
            return "en"
        }
    }

    public func getLocalizeIso639_2() -> String {
        switch self {
        case .turkish:
            return "tr"
        case .english:
            return "en"
        }
    }

    public func getLocale() -> Locale {
        switch self {
        case .turkish:
            return Locale.turkey
        case .english:
            return Locale(identifier: "en_GB")
        }
    }
}
