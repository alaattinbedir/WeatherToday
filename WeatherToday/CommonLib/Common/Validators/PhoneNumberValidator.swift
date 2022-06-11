//
//  PhoneNumberValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class PhoneNumberValidator: Validator<String?, PhoneNumberValidator.Result> {
    public static let charSet = CharacterSet(charactersIn: "0123456789")
    public static let maxCharCount = 11
    public static let minCharCount = 10

    public enum Result: String {
        case succeeded
        case empty
        case invalidChar
        case tooShort
        case exceeded
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let number = data?.replacingOccurrences(of: " ", with: ""), number.count > 0 else { return .empty }
        guard number.rangeOfCharacter(from: PhoneNumberValidator.charSet.inverted) == nil else { return .invalidChar }
        guard number.count >= PhoneNumberValidator.minCharCount else { return .tooShort }
        guard number.count <= PhoneNumberValidator.maxCharCount else { return .exceeded }
        return .succeeded
    }
}
