//
//  TraficPenaltyDocumentDateValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class TraficPenaltyDocumentDateValidator: Validator<Date?, TraficPenaltyDocumentDateValidator.Result> {
    public let minDate: Date
    public let maxDate: Date

    public enum Result: String {
        case empty
        case mindDateExceed
        case maxDateExceed
        case succeeded
    }

    public init(currentDate: Date) {
        minDate = currentDate.subtract(years: 10)
        maxDate = currentDate
        super.init()
    }

    override public func validate(_ date: Date?) -> Result {
        guard let date = date else {
            return .empty
        }

        if date
            .compareTo(minDate, dateFormat: .ddMMyyWithSlash) == .orderedAscending {
            return .mindDateExceed
        }

        if date
            .compareTo(maxDate, dateFormat: .ddMMyyWithSlash) == .orderedDescending {
            return .maxDateExceed
        }

        return .succeeded
    }
}
