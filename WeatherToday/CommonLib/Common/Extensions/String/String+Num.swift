//
//  String+Num.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension String {
    var numeric: String {
        return replacingOccurrences(of: "[^0-9-]", with: "", options: .regularExpression)
    }

    func toDouble(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        return formatter.number(from: self)?.doubleValue
    }
}
