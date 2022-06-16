//
//  VknValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

enum VknValidationResult: String {
    case succeeded
    case empty
    case invalidVkn
}

class VknValidator: Validatable {
    typealias Input = String?
    typealias Result = VknValidationResult

    func validate(_ input: String?) -> VknValidationResult {
        guard let vkn = input, !vkn.isEmpty else {
            return .empty
        }
        let trimmed = vkn.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return .empty
        }
        if !isValidVkn(trimmed) {
            return .invalidVkn
        }
        return .succeeded
    }

    private func isValidVkn(_ vkn: String) -> Bool {
        let digits = vkn.map { Int(String($0))~ }

        if digits.count == 10 {
            var index = 9
            let firstCalc = digits[0 ... 8].map { digit -> Int in
                let result = (digit + index) % 10
                index -= 1
                return result
            }
            index = 9
            var secondCalc = firstCalc.map { firstCalcResult -> Int in
                let result = (firstCalcResult * Int(pow(2, Double(index)))) % 9
                index -= 1
                return result
            }
            for (index, secondCalcResult) in secondCalc.enumerated() {
                if firstCalc[index] != 0, secondCalcResult == 0 {
                    secondCalc[index] = 9
                }
            }
            var secondCalcTotal = secondCalc.reduce(0, +)
            secondCalcTotal = (10 - (secondCalcTotal % 10)) % 10
            return secondCalcTotal == digits[9]
        }
        return false
    }
}
