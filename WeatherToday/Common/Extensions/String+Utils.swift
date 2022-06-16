//
//  String+Utils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import CryptoSwift
import Foundation
import UIKit

extension String {
    var isHtml: Bool {
        let pattern = "<([a-z][a-z0-9]*)\\b[^>]*>(.*?)</\\1>"
        let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil)

        guard range != nil else {
            return false
        }
        return true
    }

    init?(_ character: Character?) {
        guard let character = character else { return nil }
        self.init(character)
    }

    var numericRegex: String {
        return "[^0-9]"
    }

    var numeric: String {
        return replacingOccurrences(of: numericRegex, with: "", options: .regularExpression)
    }

    var alphaNumeric: String {
        return replacingOccurrences(of: "[^a-zA-Z0-9]", with: "", options: .regularExpression)
    }

    var uppercased: String? {
        return uppercased(with: Locale(identifier: "tr-TR"))
    }

    var lowercased: String? {
        return lowercased(with: Locale(identifier: "tr-TR"))
    }

    var capitalized: String? {
        return capitalized(with: Locale(identifier: "tr-TR"))
    }

    func lowercaseFirstLetter() -> String {
        return !isEmpty ? prefix(1).lowercased() + dropFirst() : self
    }

    var eventFormat: String {
        return replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "-", with: "_")
            .replacingOccurrences(of: "/", with: "_")
            .lowercased(with: Locale(identifier: "tr"))
            .replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ı", with: "i")
            .replacingOccurrences(of: "ş", with: "s")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "ü", with: "u")
            .removeSpecialCharsFromString
            .replacingOccurrences(of: "__", with: "_")
            .replacingOccurrences(of: "__", with: "_")
    }

    var removeSpecialCharsFromString: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return filter { okayChars.contains($0) }
    }

    var url: URL? {
        return URL(string: self)
    }

    var urlEncoded: String {
        let url = trimmingWhitespace()
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    var empty: String {
        return ""
    }

    func urlVerified() -> String {
        if canOpenUrl() {
            return self
        } else { return empty }
    }

    func canOpenUrl() -> Bool {
        guard let url = URL(string: self), UIApplication.shared.canOpenURL(url) else { return false }
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }

    var isNumeric: Bool {
        return Int(self) != nil
    }

    func hexString() -> String {
        guard let data = data(using: .utf8) else { return "" }
        return data.map { String(format: "%02x", $0) }.joined()
    }

    func hexToString(uppercase _: Bool = false, prefix _: String = "", separator _: String = "") -> String? {
        guard let regex = try? NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive) else {
            return nil
        }
        let textNS = self as NSString
        let matchesArray = regex
            .matches(in: textNS as String, options: [], range: NSRange(location: 0, length: textNS.length))
        let characters = matchesArray.compactMap { match -> Character? in
            if let intVal = UInt32(textNS.substring(with: match.range(at: 2)), radix: 16),
               let uniCode = UnicodeScalar(intVal) {
                return Character(uniCode)
            }
            return nil
        }
        return String(characters).replacingOccurrences(of: "\0", with: "")
    }

    func cardFormatted(separator: String = " ") -> String {
        return group(by: 4, separator: separator)
    }

    func currencyFormatted() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "tr-TR")
        return currencyFormatter.string(from: NSNumber(value: Double(self)~))~
    }

    func afterCommaCountFormatted(value: Int) -> Double {
        if contains(".") {
            let partOfNumber = split(separator: ".")
            if partOfNumber[1].count > 2 {
                let afterComma = String(partOfNumber[1])[0 ... (value - 1)]
                return Double(partOfNumber[0] + "." + afterComma)~
            }
        }
        return Double(self)~
    }

    func group(by groupSize: Int, separator: String) -> String {
        if count <= groupSize {
            return self
        }

        let splitSize = min(max(2, count - 1), groupSize)
        let splitIndex = index(startIndex, offsetBy: splitSize)

        return "\(String(self[..<splitIndex]))\(separator)" +
            "\(String(suffix(from: splitIndex)).group(by: groupSize, separator: separator))"
    }

    func hideMidChars(_ value: String) -> String {
        return String(value.enumerated().map { index, char in
            [0, 1].contains(index) ? char : "*"
        })
    }

    func firstCharacterOfText() -> String {
        if contains(" ") {
            let partOfText = split(separator: " ")
            let first = String(partOfText[0]).first
            let second = String(partOfText[(partOfText.count) - 1]).first
            return "\(first ?? " ")\(second ?? " ")"
        } else {
            return String(first)~
        }
    }

    func amountToDouble() -> Double {
        return Double(self~.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
            .replacingOccurrences(of: " TL", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: " TRY", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: " USD", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: " EUR", with: "", options: .literal, range: nil))~
    }

    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }

    func trimmingWhitespace() -> String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)~
    }

    var dictionary: [String: Any]? {
        if let data = data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    subscript(i: Int) -> Character? {
        guard i < count else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }

    subscript(bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }

    subscript(bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }

    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var appliedNumber = ""
        var pureNumberIndex = 0
        let pureNumber = replacingOccurrences(of: numericRegex, with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard pureNumberIndex < pureNumber.count else {
                return appliedNumber
            }
            let patternCharacter = Character(pattern.charAt(int: index))
            if patternCharacter != replacmentCharacter {
                appliedNumber.append(patternCharacter)
            } else {
                appliedNumber.append(pureNumber.charAt(int: pureNumberIndex))
                pureNumberIndex += 1
            }
        }
        return appliedNumber
    }

    func charAt(int: Int) -> String {
        let index = self.index(startIndex, offsetBy: int)
        return String(self[index])
    }

    func width(font: UIFont, extra: CGFloat = 0) -> CGFloat {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 1
        label.text = self
        label.sizeToFit()
        return label.frame.width + extra
    }

    func height(font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }

    static func random(length: Int, from charset: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        return String((0 ..< length).map { _ in charset.randomElement() ?? "a" })
    }

    static func generateUUID() -> String {
        return NSUUID().uuidString
    }

    func trimCurrency() -> String {
        return self~.replacingOccurrences(of: " TRY", with: "")
            .replacingOccurrences(of: " TL", with: "")
            .replacingOccurrences(of: " USD", with: "")
            .replacingOccurrences(of: " EUR", with: "")
            .replacingOccurrences(of: " XAU", with: "")
    }

    func convertBool() -> Bool {
        if lowercased(with: Locale(identifier: "tr")) == "true" {
            return true
        }
        return false
    }
}

protocol PhoneNumberFormattable {
    var formatted: String { get }
    var unformatted: String { get }
}

enum Format: String {
    case twoPart = "%@ %@"
    case threePart = "%@ %@ %@"
    case fourPart = "%@ %@ %@ %@"
    case fivePart = "%@ %@ %@ %@ %@"
    case sixPart = "%@ %@ %@ %@ %@ %@"
    case sevenPart = "%@ %@ %@ %@ %@ %@ %@"
}

extension String: PhoneNumberFormattable {
    var formatted: String {
        let unformattedNumber = unformatted
        if unformattedNumber.count < 4 {
            return unformattedNumber
        } else if unformattedNumber.count < 7 {
            return String(format: Format.twoPart.rawValue,
                          String(unformattedNumber[0 ... 2]),
                          String(unformattedNumber[3 ... unformattedNumber.count - 1]))
        } else if unformattedNumber.count < 9 {
            return String(format: Format.threePart.rawValue,
                          String(unformattedNumber[0 ... 2]),
                          String(unformattedNumber[3 ... 5]),
                          String(unformattedNumber[6 ... unformattedNumber.count - 1]))
        }
        return String(format: Format.fourPart.rawValue,
                      String(unformattedNumber[0 ... 2]),
                      String(unformattedNumber[3 ... 5]),
                      String(unformattedNumber[6 ... 7]),
                      String(unformattedNumber[8 ... unformattedNumber.count - 1]))
    }

    var unformatted: String {
        var unformattedNumber = numeric
        let startIndex = unformattedNumber.index(unformattedNumber.endIndex, offsetBy: -min(unformattedNumber.count, 10))
        unformattedNumber = String(unformattedNumber[startIndex...])
        return unformattedNumber
    }
}

protocol TransportationCardFormattable {
    var formattedTransportationCardNumber: String { get }
}

extension String: TransportationCardFormattable {
    var formattedTransportationCardNumber: String {
        let unformattedTransportationCardNumber = alphaNumeric
        if unformattedTransportationCardNumber.count < 5 {
            return unformattedTransportationCardNumber
        } else if unformattedTransportationCardNumber.count < 9 {
            return String(format: Format.twoPart.rawValue,
                          String(unformattedTransportationCardNumber[0 ... 3]),
                          String(unformattedTransportationCardNumber[4 ... unformattedTransportationCardNumber.count - 1]))
        } else if unformattedTransportationCardNumber.count < 13 {
            return String(format: Format.threePart.rawValue,
                          String(unformattedTransportationCardNumber[0 ... 3]),
                          String(unformattedTransportationCardNumber[4 ... 7]),
                          String(unformattedTransportationCardNumber[8 ... unformattedTransportationCardNumber.count - 1]))
        }
        return String(format: Format.fourPart.rawValue,
                      String(unformattedTransportationCardNumber[0 ... 3]),
                      String(unformattedTransportationCardNumber[4 ... 7]),
                      String(unformattedTransportationCardNumber[8 ... 11]),
                      String(unformattedTransportationCardNumber[12 ... unformattedTransportationCardNumber.count - 1]))
    }
}

protocol AmountFormattable {
    func formattedAmount(maxDecimalDigit: Int, maxFractionalDigit: Int) -> String
}

extension String: AmountFormattable {
    // swiftlint:disable function_body_length
    func formattedAmount(maxDecimalDigit: Int = 5,
                         maxFractionalDigit: Int = 2) -> String {
        if isEmpty {
            return self
        }
        if last == "." {
            var str = self
            str.removeLast()
            return str + ","
        }
        if contains(","), count != 1 {
            var doubleFormattedText = replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                .replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
            var twoPartAmount = doubleFormattedText.split(separator: ".")
            let beforeCommaCount = twoPartAmount[0].count
            var afterCommaCount: Int
            if beforeCommaCount > maxDecimalDigit {
                twoPartAmount[0] = String(twoPartAmount[0])[0 ... maxDecimalDigit - 1]
            }
            if twoPartAmount.count > 1 {
                afterCommaCount = twoPartAmount[1].count
                if afterCommaCount > maxFractionalDigit {
                    afterCommaCount = maxFractionalDigit
                    twoPartAmount[1] = String(twoPartAmount[1])[0 ... maxFractionalDigit - 1]
                }
            } else {
                afterCommaCount = 0
            }
            if afterCommaCount > 0 {
                doubleFormattedText = String(twoPartAmount[0]) + "." + String(twoPartAmount[1])
            } else {
                doubleFormattedText = String(twoPartAmount[0]) + "."
            }

            doubleFormattedText = doubleFormattedText.currencyFormatted()
            let range = (doubleFormattedText.count - (3 - afterCommaCount))
            let raw = String(doubleFormattedText[0 ... range]).replacingOccurrences(of: "₺", with: "")
            return raw
        } else {
            var doubleFormattedText = replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            var twoPartAmount = doubleFormattedText.split(separator: ".")
            let beforeCommaCount = twoPartAmount[0].count
            var afterCommaCount: Int
            if beforeCommaCount > maxDecimalDigit {
                twoPartAmount[0] = String(twoPartAmount[0])[0 ... maxDecimalDigit - 1]
            }
            if twoPartAmount.count > 1 {
                afterCommaCount = twoPartAmount[1].count
                if afterCommaCount > maxFractionalDigit {
                    twoPartAmount[1] = String(twoPartAmount[1])[0 ... maxFractionalDigit - 1]
                }
            } else {
                afterCommaCount = 0
            }
            if afterCommaCount > 0 {
                doubleFormattedText = String(twoPartAmount[0]) + "." + String(twoPartAmount[1])
            } else {
                doubleFormattedText = String(twoPartAmount[0]) + "."
            }
            doubleFormattedText = doubleFormattedText.currencyFormatted()
            let raw = String(doubleFormattedText.split(separator: ",")[0]).replacingOccurrences(of: "₺", with: "")
            return raw
        }
    }
    // swiftlint:enable function_body_length
}

extension String {
    func contains(turkishString searchString: String, caseSensitive: Bool) -> Bool {
        guard let regex = searchString.turkishRegex(caseSensitive: caseSensitive) else {
            return false
        }
        let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: count))
        return !results.isEmpty
    }

    private func turkishRegex(caseSensitive: Bool) -> NSRegularExpression? {
        do {
            var regexPattern = ""
            var regexCharacter = ""
            for character in self {
                regexCharacter = ""
                if character == "I" || character == "İ" || character == "ı" || character == "i" {
                    regexCharacter = "[Iİıi]"
                } else if character == "S" || character == "Ş" || character == "s" || character == "ş" {
                    regexCharacter = "[SŞsş]"
                } else if character == "O" || character == "Ö" || character == "o" || character == "ö" {
                    regexCharacter = "[OÖoö]"
                } else if character == "C" || character == "Ç" || character == "c" || character == "ç" {
                    regexCharacter = "[CÇcç]"
                } else if character == "G" || character == "Ğ" || character == "g" || character == "ğ" {
                    regexCharacter = "[GĞgğ]"
                } else if character == "U" || character == "Ü" || character == "u" || character == "ü" {
                    regexCharacter = "[UÜuü]"
                } else {
                    regexCharacter = "\(character)"
                }
                regexPattern += regexCharacter
            }

            let options: NSRegularExpression.Options = caseSensitive ? [] : [.caseInsensitive]

            return try NSRegularExpression(pattern: regexPattern, options: options)
        } catch {
            return nil
        }
    }
}

extension String {
    var attr: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }

    func attr(_ color: UIColor, _ font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self,
                           attributes: [NSAttributedString.Key.foregroundColor: color,
                                        NSAttributedString.Key.font: font])
    }

    func color(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self,
                           attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

extension String {
    var emojiDecoder: String? {
        guard let data = ("\"" + self + "\"").data(using: .utf8) else { return self }
        do {
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? String {
                return result
            }
        } catch {
            print(error)
        }
        return self
    }
}

extension String {
    var convertToPrice: String? {
        guard let value = Double(self) else { return self }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = ""
        currencyFormatter.currencyDecimalSeparator = ","
        if let priceString = currencyFormatter.string(for: value) {
            return priceString
        }
        return self
    }
}
