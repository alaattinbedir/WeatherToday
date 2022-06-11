//
//  DateFormatter+Localization.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension DateFormatter {
    static func localizedFormatter(format: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = AppLocalization.shared.appSelectedLocale
        formatter.timeZone = AppLocalization.shared.timeZone
        return formatter
    }
}
