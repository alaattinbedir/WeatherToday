//
//  Double+Utils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

struct Amount {
    var decimal: String
    var fractional: String
    var separator: String
}

extension Double {
    func currencyString(fractionDigits: Int,
                        currencyCode: String? = nil,
                        roundingMode: NumberFormatter.RoundingMode = .halfEven) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.numberStyle = .decimal
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        formatter.roundingMode = roundingMode
        var formattedString = safeUnwrap(formatter.string(from: NSNumber(value: self)), default: "\(self)")

        if let currencyCode = currencyCode {
            formattedString = "\(formattedString) \(currencyCode)"
        }

        return formattedString
    }

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

    func amountAttrs(fractionDigits: Int) -> Amount {
        let formattedString = currencyString(fractionDigits: fractionDigits)
        let decimalSeparator: Character = ","
        var parts = formattedString.split(separator: decimalSeparator)
        if parts.count == 1 {
            parts.append("")
        }
        let amount = Amount(decimal: "\(String(parts[0]))",
                            fractional: String(parts[1]),
                            separator: String(decimalSeparator))
        return amount
    }

    func formattedAmountString() -> String {
        if floor(self) == self {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }

    func toRequestAmount(fractionDigits: Int = 2) -> String {
        let formattedString = String(format: "%.\(fractionDigits)lf", self)
        return formattedString
    }
}
