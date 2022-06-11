//
//  EmailValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public enum EmailValidationResult: String {
    case succeeded
    case empty
    case maxLengthExceeded
    case invalidChars
    case invalidEmailSchema
}

public class EmailValidator: Validator<String?, EmailValidationResult> {
    public static let maxLength = 50
    public static let acceptanceCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOQPRSTUVWXYZabcdefghijklmnoqprstuvwxyz!#$%&'*+-/=?^_`{|}~.@(),:;<>[]")

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> EmailValidationResult {
        guard let name = data, name.count > 0 else {
            return .empty
        }

        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmed.count > 0 else {
            return .empty
        }

        if trimmed.count > EmailValidator.maxLength {
            return .maxLengthExceeded
        }

        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)

        if !emailPredicate.evaluate(with: trimmed) {
            return .invalidEmailSchema
        }

        return .succeeded
    }
}
