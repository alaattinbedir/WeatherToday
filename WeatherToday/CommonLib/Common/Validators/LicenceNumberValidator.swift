//
//  LicenceNumberValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class LicenceNumberValidator: Validator<String?, LicenceNumberValidator.ResultEnum> {
    public static let acceptedCharSet =
        CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPRSTUVYZabcdefghijklmnoprstuvyz")
    public static let maxCharCount = 8

    public enum ResultEnum: String, Equatable {
        case succeeded
        case empty
        case invalidChar
        case charCountExceed
    }

    override public init() {
        // empty
    }

    override public func validate(_ licenceNumber: String?) -> ResultEnum {
        guard let licenceNumber = licenceNumber, licenceNumber.count > 0 else {
            return .empty
        }

        guard licenceNumber.rangeOfCharacter(from: LicenceNumberValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        guard licenceNumber.count <= LicenceNumberValidator.maxCharCount else {
            return .charCountExceed
        }

        return .succeeded
    }
}
