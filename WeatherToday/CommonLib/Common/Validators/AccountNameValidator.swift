//
//  AccountNameValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public enum AccountNameValidationResultEnum: String {
    case succeeded
    case empty
    case minLength
    case maxLengthExceeded
    case invalidChars
}

public struct AccountNameValidationResult {
    public var result: AccountNameValidationResultEnum
    public var message: String?
    public var trimmedAccountName: String?

    init(result: AccountNameValidationResultEnum, message: String?, trimmedAccountName: String? = nil) {
        self.result = result
        self.message = message
        self.trimmedAccountName = trimmedAccountName
    }
}

public class AccountNameValidator: Validator<String?, AccountNameValidationResult> {
    private static let minLength = 1
    private static let maxLength = 50
    private static var whiteList: CharacterSet = {
        var charSet = CharacterSet.alphanumerics
        charSet.insert(" ")
        return charSet
    }()

    private var validationMessages: [AccountNameValidationResultEnum: String] = [:]

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> AccountNameValidationResult {
        guard let name = data, name.count > 0 else {
            return AccountNameValidationResult(result: .empty, message: validationMessages[.empty])
        }

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmedName.count > 0 else {
            return AccountNameValidationResult(result: .empty, message: validationMessages[.empty])
        }

        if trimmedName.rangeOfCharacter(from: AccountNameValidator.whiteList.inverted) != nil {
            return AccountNameValidationResult(result: .invalidChars, message: validationMessages[.invalidChars])
        }

        if trimmedName.count < AccountNameValidator.minLength {
            return AccountNameValidationResult(result: .minLength, message: validationMessages[.minLength])
        }

        if trimmedName.count > AccountNameValidator.maxLength {
            return AccountNameValidationResult(result: .maxLengthExceeded,
                                               message: validationMessages[.maxLengthExceeded])
        }

        return AccountNameValidationResult(result: .succeeded, message: validationMessages[.succeeded],
                                           trimmedAccountName: trimmedName)
    }

    public func setMessage(result: AccountNameValidationResultEnum, message: String?) {
        validationMessages[result] = message
    }
}
