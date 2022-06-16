//
//  PhoneValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

enum MobilePhoneValidationResult: String {
    case succeeded
    case empty
    case maxLengthExceeded
    case invalidPhoneSchema
}

class MobilePhoneValidator: Validatable {
    typealias Input = String?
    typealias Result = MobilePhoneValidationResult

    private static let maxLength = 10

    func validate(_ input: String?) -> MobilePhoneValidationResult {
        guard let formatted = input, !formatted.isEmpty else {
            return .empty
        }

        let trimmed = formatted.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return .empty
        }

        if trimmed.count > MobilePhoneValidator.maxLength {
            return .maxLengthExceeded
        }

        let regex = "[5]{1}+[0-9]{9}"
        let mobilePhonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)

        if !mobilePhonePredicate.evaluate(with: trimmed) {
            return .invalidPhoneSchema
        }

        return .succeeded
    }
}

