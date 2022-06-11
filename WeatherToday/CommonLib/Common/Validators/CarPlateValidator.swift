//
//  CarPlateValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class CarPlateValidator: Validator<String?, CarPlateValidator.ResultEnum> {
    public static let acceptedCharSet =
        CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPRSTUVYZabcdefghijklmnoprstuvyz")
    public static let maxCharCount = 10

    public static let plateRegex: [NSRegularExpression] = {
        var plateRegex = [NSRegularExpression]()
        if let regex1 = try? NSRegularExpression(pattern: "\\d{2}[A-PR-VY-Z]{1}\\d{3,5}") {
            plateRegex.append(regex1)
        }
        if let regex2 = try? NSRegularExpression(pattern: "\\d{2}[A-PR-VY-Z]{2}\\d{3,4}") {
            plateRegex.append(regex2)
        }
        if let regex3 = try? NSRegularExpression(pattern: "\\d{2}[A-PR-VY-Z]{3}\\d{2}") {
            plateRegex.append(regex3)
        }
        if let regex4 = try? NSRegularExpression(pattern: "\\d{2}[A-PR-VY-Z]{3}\\d{2,3}") {
            plateRegex.append(regex4)
        }
        return plateRegex
    }()

    public enum ResultEnum: String, Equatable {
        case succeeded
        case empty
        case invalidChar
        case invalid
        case charCountExceed
    }

    override public init() {
        // empty
    }

    override public func validate(_ plate: String?) -> ResultEnum {
        guard let plate = plate, plate.count > 0 else {
            return .empty
        }

        guard plate.rangeOfCharacter(from: CarPlateValidator.acceptedCharSet.inverted) == nil else {
            return .invalidChar
        }

        guard plate.count <= CarPlateValidator.maxCharCount else {
            return .charCountExceed
        }

        let range = NSRange(location: 0, length: plate.utf16.count)
        let isValidPlate = CarPlateValidator.plateRegex.contains { regex in
            guard let match = regex.firstMatch(in: plate, options: [], range: range) else { return false }
            return (match.range.location != NSNotFound)
        }

        guard isValidPlate else { return .invalid }

        return .succeeded
    }
}

// MARK: - Result message extension

public extension CarPlateValidator.ResultEnum {
    func toResultMessage(resources: [CarPlateValidator.ResultEnum: String]) -> String? {
        guard let message = resources[self] else { return nil }
        return message
    }

    var isSucceeded: Bool { self == .succeeded }
}
