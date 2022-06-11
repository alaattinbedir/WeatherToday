//
//  String+Phone.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension String {
    func clearPhoneNumber(containsCountry: Bool = false) -> String {
        var phoneNumberValue = normalizePhoneNumber()
        phoneNumberValue = phoneNumberValue.numeric

        let maxCount: Int
        if containsCountry {
            maxCount = PhoneNumberWithCountryValidator.findMaxCharCount(for: self)
        } else {
            maxCount = 10
        }

        if phoneNumberValue.count > maxCount {
            let startedIndex: Int = (phoneNumberValue.count - maxCount)
            phoneNumberValue = phoneNumberValue[startedIndex ..< phoneNumberValue.count]
        } else {
            phoneNumberValue = phoneNumberValue[0 ..< phoneNumberValue.count]
        }
        return phoneNumberValue
    }

    func normalizePhoneNumber() -> String {
        var normalizeNumber: String = ""
        normalizeNumber = replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
        normalizeNumber = normalizeNumber.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
        normalizeNumber = normalizeNumber.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        normalizeNumber = normalizeNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        return normalizeNumber
    }

    func phoneNumberFormatted(containsCountry: Bool = false) -> String {
        var formatedPhoneNumber = ""
        let unformattedPhoneNumber = clearPhoneNumber(containsCountry: containsCountry)
        let lenght: Int = unformattedPhoneNumber.count

        if containsCountry {
            if lenght < 3 {
                return unformattedPhoneNumber
            }

            if lenght < 6 {
                let first = String(unformattedPhoneNumber[0 ..< 2])
                let others = String(unformattedPhoneNumber[2 ..< lenght])
                formatedPhoneNumber = "\(first) \(others)"
            } else {
                let first = String(unformattedPhoneNumber[0 ..< 2])
                let second = String(unformattedPhoneNumber[2 ..< 5])
                let others = String(unformattedPhoneNumber[5 ..< lenght])
                formatedPhoneNumber = "\(first) \(second) \(others)"
            }
        } else {
            if lenght < 4 {
                return unformattedPhoneNumber
            }

            if lenght < 7 {
                let first = String(unformattedPhoneNumber[0 ..< 3])
                let others = String(unformattedPhoneNumber[3 ..< lenght])
                formatedPhoneNumber = "\(first) \(others)"
            } else if lenght < 9 {
                let first = String(unformattedPhoneNumber[0 ..< 3])
                let othersFirstGroup = String(unformattedPhoneNumber[3 ..< 6])
                let othersSecondGroup = String(unformattedPhoneNumber[6 ..< lenght])
                formatedPhoneNumber = "\(first) \(othersFirstGroup) \(othersSecondGroup)"
            } else {
                let first = String(unformattedPhoneNumber[0 ..< 3])
                let othersFirstGroup = String(unformattedPhoneNumber[3 ..< 6])
                let othersSecondGroup = String(unformattedPhoneNumber[6 ..< 8])
                let othersLastGroup = String(unformattedPhoneNumber[8 ..< (lenght > 10 ? 10 : lenght)])
                formatedPhoneNumber = "\(first) \(othersFirstGroup) \(othersSecondGroup) \(othersLastGroup)"
            }
        }
        return formatedPhoneNumber
    }

    func phoneFormatted() -> String {
        if count < 10 || count > 11 {
            return self
        }

        var formatted = self
        if formatted.count == 10 {
            formatted.insert("0", at: formatted.startIndex)
        }

        formatted.insert(" ", at: formatted.index(formatted.endIndex, offsetBy: -7))
        formatted.insert(" ", at: formatted.index(formatted.endIndex, offsetBy: -4))
        return formatted
    }
}
