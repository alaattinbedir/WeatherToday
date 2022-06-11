//
//  AddressValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class AddressValidator: Validator<String?, AddressValidator.Result> {
    var minCount: Int = 5
    var minWordCount: Int = 2

    public enum Result: String {
        case succeeded
        case empty
        case tooShort
    }

    override public init() {
        // empty
    }

    public init(minCount: Int, minWordCount: Int) {
        self.minCount = minCount
        self.minWordCount = minWordCount
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else {
            return .empty
        }

        if data.count < minCount {
            return .tooShort
        }

        let words = data.split(separator: " ")
        if words.count < minWordCount {
            return .tooShort
        }

        return .succeeded
    }
}

// MARK: - Result message extension

public extension AddressValidator.Result {
    func toResultMessage(resources: [AddressValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
