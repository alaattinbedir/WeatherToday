//
//  CustomerTitleValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class CustomerTitleValidator: Validator<String?, CustomerTitleValidator.Result> {
    public static let minCount = 3

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

        if data.count < CustomerTitleValidator.minCount {
            return .tooShort
        }

        return .succeeded
    }
}
