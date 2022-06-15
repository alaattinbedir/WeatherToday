//
//  Double+Utils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation

extension Double {
    func string(minimumFractionDigits: Int = 0,
                maximumFractionDigits: Int = 2,
                roundingMode: NumberFormatter.RoundingMode = .halfEven,
                separator: String = ",",
                usesGroupingSeparator: Bool = true) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = usesGroupingSeparator
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.decimalSeparator = separator
        formatter.roundingMode = roundingMode
        return safeUnwrap(formatter.string(from: NSNumber(value: self)), default: "\(self)")
    }
}
