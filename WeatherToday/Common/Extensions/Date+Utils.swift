//
//  Date+Utils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import SwiftDate

extension Date {
    var current: DateInRegion {
        let region = Region(calendar: Calendars.gregorian, zone: Zones.europeIstanbul, locale: Locales.turkishTurkey)
        return DateInRegion(self, region: region)
    }

    func formatted(format: String, yearLimit: Int? = nil) -> String {
        if yearLimit != nil, year <= yearLimit~ {
            return "-"
        } else {
            return current.toFormat(format)
        }
    }

    func getYearStrFromDate() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return "\(year)"
    }

    func getCurrentMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "tr")
        return dateFormatter.string(from: self)
    }

    static func getDateFromServiceDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.serviceResponseFormat.rawValue
        dateFormatter.locale = Locale(identifier: "tr")
        guard let dateObject = dateFormatter.date(from: date) else { return date }
        dateFormatter.dateFormat = DateFormat.ddMMyyyy.rawValue
        return dateFormatter.string(from: dateObject)
    }

    static func getDetailedDateFromServiceDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.serviceResponseFormat.rawValue
        dateFormatter.locale = Locale(identifier: "tr")
        guard let dateObject = dateFormatter.date(from: date) else { return date }
        dateFormatter.dateFormat = DateFormat.ddMMyyyyHHmm.rawValue
        return dateFormatter.string(from: dateObject)
    }

    func subtract(_ interval: TimeInterval) -> Date {
        return Date(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate - interval)
    }

    func diff(from date: Date) -> TimeInterval {
        return timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
    }
}

extension DateComponents {
    func toSeconds() -> Int {
        return timeInterval.toUnit(.second)~
    }

    func toMinutes() -> Int {
        return timeInterval.toUnit(.minute)~
    }

    func toHours() -> Int {
        return timeInterval.toUnit(.hour)~
    }

    func toDays() -> Int {
        return timeInterval.toUnit(.day)~
    }

    func toWeeks() -> Int {
        return timeInterval.toUnit(.weekOfMonth)~
    }

    func toMonths() -> Int {
        return timeInterval.toUnit(.month)~
    }

    func toYears() -> Int {
        return timeInterval.toUnit(.year)~
    }
}
