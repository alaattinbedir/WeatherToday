//
//  AppLocalization.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
public class AppLocalization {
    public static let shared = AppLocalization()

    public var language = AppLanguage.turkish
    public var timeZone = TimeZone.turkey
    public let locale = Locale.turkey
    public var appSelectedLocale: Locale {
        if language == .english {
            return Locale.english
        }
        return Locale.turkey
    }

    private var clientServerDiff: TimeInterval = 0
    public var serverDate: Date { Date().subtract(clientServerDiff) }

    public func setServerDate(serverDate: Date) {
        clientServerDiff = Date().diff(from: serverDate)
        debugPrint("AppLocalization", clientServerDiff, serverDate)
    }
}
