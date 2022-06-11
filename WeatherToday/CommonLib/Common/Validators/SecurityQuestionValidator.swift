//
//  SecurityQuestionValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class SecurityQuestionValidator: Validator<String?, SecurityQuestionValidator.Result> {
    public static let minCount = 5
    public static let maxCount = 25
    public static let acceptedCharSet =
        CharacterSet(charactersIn: "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx ")

    public enum Result: String {
        case idle // at start
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

        guard data.rangeOfCharacter(from: SecurityQuestionValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        if data.count < SecurityQuestionValidator.minCount {
            return .tooShort
        }

        return .succeeded
    }
}