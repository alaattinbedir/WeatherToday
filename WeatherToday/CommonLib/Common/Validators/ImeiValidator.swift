//
//  ImeiValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class ImeiValidator: Validator<String?, ImeiValidator.Result> {
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789")
    public static let maxCharCount = 15

    public enum Result: String {
        case succeeded
        case empty
        case invalidChar
        case tooShort
        case exceeded
        case invalid
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else { return .empty }
        guard data.rangeOfCharacter(from: ImeiValidator.acceptedCharSet.inverted) == nil else { return .invalidChar }
        guard data.count == ImeiValidator.maxCharCount else { return .tooShort }
        guard data.count <= ImeiValidator.maxCharCount else { return .exceeded }
        guard isValid(imeiNumber: data) else { return .invalid }
        return .succeeded
    }

    private func isValid(imeiNumber: String) -> Bool {
        guard var intImeiNumber = Int64(imeiNumber) else { return false }

        var sum = 0

        for index in stride(from: imeiNumber.count, through: 0, by: -1) {
            var digit = intImeiNumber % 10

            if index % 2 == 0 {
                digit = 2 * digit
            }

            sum += sumDig(n: Int(digit))
            intImeiNumber = intImeiNumber / 10
        }
        return sum % 10 == 0
    }

    private func sumDig(n: Int) -> Int {
        var tempN = n
        var a = 0
        while tempN > 0 {
            a = a + tempN % 10
            tempN = tempN / 10
        }
        return a
    }
}

// MARK: - Result message extension

public extension ImeiValidator.Result {
    func toResultMessage(resources: [ImeiValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }
}
