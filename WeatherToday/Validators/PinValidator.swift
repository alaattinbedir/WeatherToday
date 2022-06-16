//
//  PinValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

enum PinValidationResult: String {
    case allEqual
    case consecutive
    case iterant
    case symmetric
    case empty
    case maxLengthLess
    case invalidPrefix
    case succeeded
}

class PinValidator: Validatable {
    typealias Input = String?
    typealias Result = PinValidationResult

    private static let maxLength = 4

    func validate(_ input: String?) -> PinValidationResult {
        guard let pin = input, !pin.isEmpty else {
            return .empty
        }

        let trimmed = pin.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return .empty
        }

        if trimmed.hasPrefix("19") || trimmed.hasPrefix("20") {
            return .invalidPrefix
        }

        if trimmed.count != PinValidator.maxLength {
            return .maxLengthLess
        }

        if isAllEqual(pin: trimmed) {
            return .allEqual
        }

        if isConsecutive(pin: trimmed) {
            return .consecutive
        }

        if isDescendingConsecutive(pin: trimmed) {
            return .consecutive
        }

        if isIterant(pin: trimmed) {
            return .iterant
        }

        if isSymmetric(pin: trimmed) {
            return .symmetric
        }

        return .succeeded
    }

    func isAllEqual(pin: String) -> Bool {
        var array: [Int] = []
        for chr in pin {
            array.append(Int(String(chr))~)
        }
        if let firstElem = array.first {
            return !array.dropFirst().contains { $0 != firstElem }
        }
        return true
    }

    func isConsecutive(pin: String) -> Bool {
        var intArray: [Int] = []
        for chr in pin {
            intArray.append(Int(String(chr))~)
        }
        let consecutives = intArray.map { $0 - 1 }.dropFirst() == intArray.dropLast()
        return consecutives
    }

    func isDescendingConsecutive(pin: String) -> Bool {
        var intArray: [Int] = []
        for chr in pin {
            intArray.append(Int(String(chr))~)
        }
        let consecutives = intArray.map { $0 + 1 }.dropFirst() == intArray.dropLast()
        return consecutives
    }

    func isIterant(pin: String) -> Bool {
        var intArray: [Int] = []
        for chr in pin {
            intArray.append(Int(String(chr))~)
        }
        let iterant = intArray[0] == intArray[1] || intArray[2] == intArray[3]
        return iterant
    }

    func isSymmetric(pin: String) -> Bool {
        var intArray: [Int] = []
        for chr in pin {
            intArray.append(Int(String(chr))~)
        }
        let splitted = intArray.split()
        let symmetric = splitted.left == splitted.right.reversed()
        return symmetric
    }
}
