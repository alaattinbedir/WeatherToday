//
//  CvvValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

enum CvvValidationResult: String {
    case succeeded
    case empty
    case invalidCvv
}

class CvvValidator: Validatable {
    typealias Input = String?
    typealias Result = CvvValidationResult

    static let maxLength: UInt = 3

    func validate(_ input: String?) -> CvvValidationResult {
        guard let formatted = input, !formatted.isEmpty else {
            return .empty
        }

        let trimmed = formatted.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return .empty
        }

        if trimmed.count < CvvValidator.maxLength {
            return .invalidCvv
        }

        return .succeeded
    }
}
