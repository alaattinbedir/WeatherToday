//
//  TimeZone+Turkey.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension TimeZone {
    static var turkey: TimeZone {
        if let timeZoneIdentifier = TimeZone.knownTimeZoneIdentifiers
            .first(where: { $0.lowercased(with: Locale(identifier: "en_GB")).contains("istanbul") }),
            let timeZone = TimeZone(identifier: timeZoneIdentifier) {
            return timeZone
        }
        return TimeZone(identifier: "Europe/Istanbul") ?? TimeZone(abbreviation: "UTC+3") ?? TimeZone.current
    }
}
