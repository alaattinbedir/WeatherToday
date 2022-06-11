//
//  TraficPenaltyOrderNumberValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class TraficPenaltyOrderNumberValidator: Validator<String?, TraficPenaltyOrderNumberValidator.Result> {
    public static let minCount = 8
    public static let maxCount = 8
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789")

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

        guard data.rangeOfCharacter(from: TraficPenaltyOrderNumberValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        if data.count < TraficPenaltyOrderNumberValidator.minCount {
            return .tooShort
        }

        return .succeeded
    }
}
