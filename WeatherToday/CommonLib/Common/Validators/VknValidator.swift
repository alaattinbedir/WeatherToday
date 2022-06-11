//
//  VknValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class VknValidator: Validator<String?, VknValidator.Result> {
    public static let acceptedCharSet = CharacterSet(charactersIn: "0123456789")
    public let maxCharCount: Int
    public let minCharCount: Int

    public enum Result: String {
        case succeeded
        case empty
        case invalidChar
        case tooShort
        case exceeded
    }

    public init(maxCharCount: Int = 11, minCharCount: Int = 10) {
        self.maxCharCount = maxCharCount
        self.minCharCount = minCharCount
    }

    override public func validate(_ data: String?) -> Result {
        guard let data = data?.trimmingCharacters(in: .whitespacesAndNewlines), data.count > 0 else { return .empty }
        guard data.rangeOfCharacter(from: VknValidator.acceptedCharSet.inverted) == nil else { return .invalidChar }
        guard data.count >= minCharCount else { return .tooShort }
        guard data.count <= maxCharCount else { return .exceeded }
        return .succeeded
    }
}

// MARK: - Result message extension

public extension VknValidator.Result {
    func toResultMessage(resources: [VknValidator.Result: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
