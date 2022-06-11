//
//  CustomerSurnameValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class CustomerSurnameValidator: Validator<String?, CustomerSurnameValidator.Result> {
    public static let minCount = 2

    public enum Result: String {
        case succeeded
        case empty
        case tooShort
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else {
            return .empty
        }

        if data.count < CustomerSurnameValidator.minCount {
            return .tooShort
        }

        return .succeeded
    }
}
