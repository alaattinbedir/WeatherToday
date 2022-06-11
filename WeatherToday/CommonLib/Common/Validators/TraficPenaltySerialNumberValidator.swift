//
//  TraficPenaltySerialNumberValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class TraficPenaltySerialNumberValidator: Validator<String?, TraficPenaltySerialNumberValidator.Result> {
    public static let minCount = 2
    public static let maxCount = 2
    public static let acceptedCharSet =
        CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

    public enum Result: String {
        case succeeded
        case tooShort
        case invalidChar
        case empty
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else {
            return .empty
        }

        guard data.rangeOfCharacter(from: TraficPenaltySerialNumberValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        if data.count < TraficPenaltySerialNumberValidator.minCount {
            return .tooShort
        }

        return .succeeded
    }
}
