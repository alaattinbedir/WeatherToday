//
//  AmountValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class AmountValidator: Validator<Double?, AmountValidator.Result> {
    public var minAmount: Double?
    public var maxAmount: Double?

    public enum Result: String {
        case succeeded
        case minAmountExceed
        case maxAmountExceed
        case empty
    }

    override public init() {
        // empty
    }

    public init(minAmount: Double?, maxAmount: Double?) {
        self.minAmount = minAmount
        self.maxAmount = maxAmount
    }

    public func setMinAmount(_ minAmount: Double?) {
        self.minAmount = minAmount
    }

    public func setMaxAmount(_ maxAmount: Double?) {
        self.maxAmount = maxAmount
    }

    override public func validate(_ amount: Double?) -> Result {
        guard let amount = amount else {
            return .empty
        }

        if let minAmount = minAmount, amount < minAmount {
            return .minAmountExceed
        }

        if let maxAmount = maxAmount, amount > maxAmount {
            return .maxAmountExceed
        }

        return .succeeded
    }
}

// MARK: - Result message extension

public extension AmountValidator.Result {
    func toResultMessage(resources: [AmountValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
    var isEmpty: Bool { self == .empty }
}
