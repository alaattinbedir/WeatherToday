//
//  CustomerFullNameValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class CustomerFullNameValidator: Validator<String?, CustomerFullNameValidator.Result> {
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
        if data.contains(" ") {
            let fullNameArr = data.split { $0 == " " }.map(String.init)
            if fullNameArr[0].count >= CustomerFullNameValidator.minCount,
               fullNameArr[fullNameArr.count - 1].count >= CustomerSurnameValidator.minCount {
                return .succeeded
            }
        }
        return .tooShort
    }
}

// MARK: - Result message extension

public extension CustomerFullNameValidator.Result {
    func toResultMessage(resources: [CustomerFullNameValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
