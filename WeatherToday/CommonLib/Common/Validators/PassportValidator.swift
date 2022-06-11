//
//  PassportValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class PassportValidator: Validator<String?, PassportValidator.Result> {
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOQPRSTUVWXYZabcdefghijklmnoqprstuvwxyz")
    public static let maxCharCount = 9
    public static let minCharCount = 7

    public static let passportRegex: [NSRegularExpression] = {
        var passportRegex = [NSRegularExpression]()
        if let regex1 = try? NSRegularExpression(pattern: "^(?!^0+$)[a-zA-Z0-9]{3,20}$") {
            passportRegex.append(regex1)
        }
        if let regex2 = try? NSRegularExpression(pattern: "^(?!0{3,20})[a-zA-Z0-9]{3,20}$") {
            passportRegex.append(regex2)
        }
        if let regex3 = try? NSRegularExpression(pattern: "^[A-Z0-9<]{9}[0-9]{1}[A-Z]{3}[0-9]{7}[A-Z]{1}[0-9]{7}[A-Z0-9<]{14}[0-9]{2}$") {
            passportRegex.append(regex3)
        }

        return passportRegex
    }()

    public enum Result: String {
        case succeeded
        case empty
        case invalidChar
        case tooShort
        case exceeded
    }

    override public init() {
        // empty
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else { return .empty }
        guard data.rangeOfCharacter(from: PassportValidator.acceptedCharSet.inverted) == nil else { return .invalidChar }
        guard data.count >= PassportValidator.minCharCount else { return .tooShort }
        guard data.count <= PassportValidator.maxCharCount else { return .exceeded }
        return .succeeded
    }
}

// MARK: - Result message extension

public extension PassportValidator.Result {
    func toResultMessage(resources: [PassportValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
