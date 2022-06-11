//
//  CitizenshipIDValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class CitizenshipIDValidator: Validator<String?, CitizenshipIDValidator.Result> {
    public static let maxCharCount = 11
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789")

    public enum Result: String {
        case succeeded
        case empty
        case invalid
        case tooShort
        case exceeded
        case invalidChar
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> CitizenshipIDValidator.Result {
        guard let citizenshipID = data?.trimmingCharacters(in: .whitespacesAndNewlines),
              citizenshipID.count > 0 else { return .empty }
        guard citizenshipID.rangeOfCharacter(from: CitizenshipIDValidator.acceptedCharSet.inverted) == nil
        else { return .invalidChar }
        guard citizenshipID.count == CitizenshipIDValidator.maxCharCount else { return .tooShort }
        guard citizenshipID.count <= CitizenshipIDValidator.maxCharCount else { return .exceeded }
        guard isValid(citizenshipID: citizenshipID) else { return .invalid }

        return .succeeded
    }

    private func isValid(citizenshipID: String) -> Bool {
        let digits = citizenshipID.map { Int(String($0)) ?? 0 }

        if digits.count == 11, digits.first != 0 {
            let first = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
            let second = (digits[1] + digits[3] + digits[5] + digits[7])

            let digit10 = (first - second) % 10
            let digit11 = digits[0 ... 9].reduce(0, +) % 10

            if digits[10] == digit11, digits[9] == digit10 {
                return true
            }
        }
        return false
    }
}

// MARK: - Result message extension

public extension CitizenshipIDValidator.Result {
    func toResultMessage(resources: [CitizenshipIDValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
