//
//  MerchantNameValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class MerchantNameValidator: Validator<String?, MerchantNameValidator.Result> {
    public static let minLength = 6
    public static let maxLength = 25
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWXabcçdefgğhıijklmnoöprsştuüvyzqwx|/\\-():., ")

    public enum Result: String {
        case succeeded
        case tooShort
        case tooLong
        case invalidChar
        case allNumeric
        case empty
    }

    override public init() {
        // empty
    }

    override public func validate(_ name: String?) -> Result {
        guard let name = name else {
            return .empty
        }

        guard name.rangeOfCharacter(from: MerchantNameValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        if name.count < MerchantNameValidator.minLength {
            return .tooShort
        }

        if name.count > MerchantNameValidator.maxLength {
            return .tooLong
        }

        if name.isNumber() {
            return .allNumeric
        }

        return .succeeded
    }
}
