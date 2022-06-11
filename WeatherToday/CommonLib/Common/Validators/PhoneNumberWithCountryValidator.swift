//
//  PhoneNumberWithCountryValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class PhoneNumberWithCountryValidator: Validator<String?, PhoneNumberWithCountryValidator.Result> {
    public static let turkeyAreaCode = "90"
    public static let turkeyMaxCharCount = 12
    public static let otherCountryMaxCharCount = 15
    public static let charSet = CharacterSet(charactersIn: "0123456789")
    public static let minCharCount = 10

    public enum Result: String {
        case succeeded
        case empty
        case invalid
        case invalidCharCount
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let number = data?.replacingOccurrences(of: " ", with: ""), number.count > 0 else { return .empty }
        guard number.rangeOfCharacter(from: PhoneNumberWithCountryValidator.charSet.inverted) == nil else { return .invalid }
        guard number.count >= Self.minCharCount else { return .invalidCharCount }

        let maxCharCount = Self.findMaxCharCount(for: data)
        let isTurkey = Self.isTurkeyAreaCode(for: data)
        guard (isTurkey && number.count == maxCharCount) || (!isTurkey && number.count <= maxCharCount) else { return .invalidCharCount }

        return .succeeded
    }

    public static func findMaxCharCount(for phone: String?) -> Int {
        if phone?.hasPrefix(Self.turkeyAreaCode) ?? false {
            return turkeyMaxCharCount
        } else {
            return otherCountryMaxCharCount
        }
    }

    public static func isTurkeyAreaCode(for phone: String?) -> Bool {
        if phone?.hasPrefix(Self.turkeyAreaCode) ?? false {
            return true
        } else {
            return false
        }
    }
}
