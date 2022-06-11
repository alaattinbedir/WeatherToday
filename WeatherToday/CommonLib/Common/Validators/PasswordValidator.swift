//
//  PasswordValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class PasswordValidator: Validator<String?, PasswordValidator.ResultEnum> {
    public let acceptedCharSet: CharacterSet
    public let passwordCharCount: Int

    public enum ResultEnum: String {
        case succeeded
        case empty
        case passwordCharCountExceed
        case passwordCharCountShort
        case invalidStartChar
        case invalidChar
        case hasSequentialRepetitiveChars
        case hasSequentialChars
        case hasBirthDate
    }

    public init(acceptedCharSet: CharacterSet = CharacterSet.decimalDigits, passwordCharCount: Int) {
        self.passwordCharCount = passwordCharCount
        self.acceptedCharSet = acceptedCharSet
    }

    override public func validate(_ password: String?) -> ResultEnum {
        guard let password = password, password.count != 0 else {
            return ResultEnum.empty
        }

        guard !password.starts(with: "0") else {
            return ResultEnum.invalidStartChar
        }

        guard password.rangeOfCharacter(from: acceptedCharSet.inverted) == nil else {
            return ResultEnum.invalidChar
        }

        // Ardisik sayilardan olusmamalidir
        if checkRepetitiveChars(maxRepetitive: 3, password: password) {
            return ResultEnum.hasSequentialRepetitiveChars
        }

        // Ardisik azalan sayilardan olusmamalidir
        if checkSquentialDigit(maxSequential: 3, isIncreased: false, password: password) {
            return ResultEnum.hasSequentialChars
        }

        // Ardisik artan sayilardan olusmamalidir
        if checkSquentialDigit(maxSequential: 3, isIncreased: true, password: password) {
            return ResultEnum.hasSequentialChars
        }

        // 1900'den gunumuze kadar olan sayilardan icermemelidir
        if checkBirthDates(password: password) {
            return ResultEnum.hasBirthDate
        }

        if password.count < passwordCharCount {
            return ResultEnum.passwordCharCountShort
        }

        if password.count > passwordCharCount {
            return ResultEnum.passwordCharCountExceed
        }

        return ResultEnum.succeeded
    }

    private func checkRepetitiveChars(maxRepetitive: Int, password: String) -> Bool {
        guard password.count >= maxRepetitive else { return false }

        var counter = 0
        var lastChar: Character?
        for c in Array(password) {
            if lastChar == nil {
                lastChar = c
            }

            if lastChar == c {
                counter += 1
            } else {
                counter = 0
                lastChar = nil
            }

            if counter == maxRepetitive {
                return true
            }
        }
        return false
    }

    private func checkSquentialDigit(maxSequential: Int, isIncreased: Bool, password: String) -> Bool {
        guard password.count >= maxSequential else { return false }

        var counter = 0
        var lastNumber: Int?

        let sequentelControl: (_ number: Int, _ lastNumber: Int) -> Bool

        if isIncreased {
            sequentelControl = { $0 == ($1 + 1) }
        } else {
            sequentelControl = { $0 == ($1 - 1) }
        }

        for c in Array(password) {
            guard let number = Int("\(c)") else { return false }

            if lastNumber == nil {
                if isIncreased {
                    lastNumber = number - 1
                } else {
                    lastNumber = number + 1
                }
            }

            if sequentelControl(number, lastNumber.required()) {
                counter += 1
                lastNumber = number
            } else {
                counter = 0
                lastNumber = nil
            }

            if counter == maxSequential {
                return true
            }
        }
        return false
    }

    private func checkBirthDates(password: String) -> Bool {
        guard password.count >= 4 else { return false }

        let currentYear = Date().getYearFromDate()
        for index in 0 ..< (password.count - 3) {
            let start = index
            let end = index + 4
            let a = password[start ..< end]

            if let number = Int(a), number >= 1900, number <= currentYear {
                return true
            }
        }

        return false
    }

    func matchPassword(firstPassword: String, secondPassword: String) -> Bool {
        if firstPassword == secondPassword {
            return true
        }
        return false
    }

    func comparePasswords(firstPassword: String, secondPassword: String) -> Bool {
        if firstPassword.count == secondPassword.count {
            return true
        }
        return false
    }
}
