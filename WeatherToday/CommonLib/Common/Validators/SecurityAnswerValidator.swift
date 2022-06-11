//
//  SecurityAnswerValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class SecurityAnswerValidator: Validator<String?, SecurityAnswerValidator.Result> {
    public static let minCount = 3
    public static let maxCount = 15
    public static let acceptedCharSet =
        CharacterSet(charactersIn: "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx?!")

    public enum Result: String {
        case idle // at start
        case succeeded
        case tooShort
        case invalidChar
        case empty
        case answersNotEqual // Used when creation.
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else {
            return .empty
        }

        guard data.rangeOfCharacter(from: SecurityAnswerValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        if data.count < SecurityAnswerValidator.minCount {
            return .tooShort
        }

        return .succeeded
    }
}
