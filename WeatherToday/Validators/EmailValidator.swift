//
//  EmailValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

enum EmailValidationResult: String {
    case succeeded
    case empty
    case maxLengthExceeded
    case invalidEmailSchema
}

class EmailValidator: Validatable {
    typealias Input = String?
    typealias Result = EmailValidationResult

    private static let maxLength = 50

    func validate(_ input: String?) -> EmailValidationResult {
        guard let name = input, !name.isEmpty else {
            return .empty
        }

        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return .empty
        }

        if trimmed.count > EmailValidator.maxLength {
            return .maxLengthExceeded
        }

        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)

        if !emailPredicate.evaluate(with: trimmed) {
            return .invalidEmailSchema
        }

        return .succeeded
    }
}
