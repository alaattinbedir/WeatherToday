//
//  CitizenshipIDValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//
import Foundation

enum CitizenshipIDValidationResult: String {
    case succeeded
    case empty
    case invalidCitizenshipID
}

class CitizenshipIDValidator: Validatable {
    typealias Input = String?
    typealias Result = CitizenshipIDValidationResult

    func validate(_ input: String?) -> CitizenshipIDValidationResult {
        guard let citizenshipID = input, !citizenshipID.isEmpty else {
            return .empty
        }

        let trimmed = citizenshipID.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return .empty
        }

        if !isValid(citizenshipID: trimmed) {
            return .invalidCitizenshipID
        }

        return .succeeded
    }

    private func isValid(citizenshipID: String) -> Bool {
        let digits = citizenshipID.map { Int(String($0))~ }

        if digits.count == 11, digits.first != 0 {
            let first = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
            let second = digits[1] + digits[3] + digits[5] + digits[7]

            let digit10 = (first - second) % 10
            let digit11 = digits[0 ... 9].reduce(0, +) % 10

            if digits[10] == digit11, digits[9] == digit10 {
                return true
            }
        }
        return false
    }
}
