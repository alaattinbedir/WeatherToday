//
//  TaxTicketNumberValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class TaxTicketNumberValidator: Validator<String?, TaxTicketNumberValidator.Result> {
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPRSTUVYZabcdefghijklmnoprstuvyz")
    public static let maxCharCount = 20

    public enum Result: String {
        case succeeded
        case empty
        case invalidChar
        case tooShort
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else { return .empty }
        guard data.rangeOfCharacter(from: TaxTicketNumberValidator.acceptedCharSet.inverted) == nil else { return .invalidChar }
        guard data.count == TaxTicketNumberValidator.maxCharCount else { return .tooShort }
        return .succeeded
    }
}

// MARK: - Result message extension

public extension TaxTicketNumberValidator.Result {
    func toResultMessage(resources: [TaxTicketNumberValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
