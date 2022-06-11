//
//  DateCommon.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation


public extension Date {
    func trimDate(dateFormat: DateFormat) -> Date {
        let dateFormater = DateFormatter.localizedFormatter(format: dateFormat)
        let trimmedDateString = dateFormater.string(from: self)
        let trimmedDate = dateFormater.date(from: trimmedDateString).required()
        return trimmedDate
    }

    func compareTo(_ otherDate: Date, dateFormat: DateFormat) -> ComparisonResult {
        let selfTrimmedDate = trimDate(dateFormat: dateFormat)
        let otherTrimmedDate = otherDate.trimDate(dateFormat: dateFormat)

        if selfTrimmedDate == otherTrimmedDate {
            return ComparisonResult.orderedSame
        } else if selfTrimmedDate < otherTrimmedDate {
            return ComparisonResult.orderedAscending
        } else {
            return ComparisonResult.orderedDescending
        }
    }

    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0,
             seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self).required()
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay).required()
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay).required()
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay).required()
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay).required()
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay).required()
        return targetDay
    }

    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0,
                  seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours,
                   minutes: inverseMinutes, seconds: inverseSeconds)
    }

    func getYearStrFromDate() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)

        return "\(year)"
    }

    func getYearFromDate() -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return year
    }

    func getMonthFromDate() -> Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return month
    }

    func getDayFromDate() -> Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        return day
    }

    func getHourFromDate() -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        return hour
    }

    func getDayNumberStrFromDate() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)

        return String(format: "%02d", day)
    }

    func diff(from date: Date) -> TimeInterval {
        return timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
    }

    func add(_ interval: TimeInterval) -> Date {
        return Date(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate + interval)
    }

    func subtract(_ interval: TimeInterval) -> Date {
        return Date(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate - interval)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.diff(from: rhs)
    }

    static func + (date: Date, interval: TimeInterval) -> Date {
        return date.add(interval)
    }

    static func - (date: Date, interval: TimeInterval) -> Date {
        return date.subtract(interval)
    }
}
