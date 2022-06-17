//
//  UILabel+Format.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

extension UILabel {
    static func createModel1(text: String, font: UIFont? = nil, color: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.font = font ?? UIFont(name: AppFont.semibold, size: 13)
        label.textColor = color ?? .white
        label.numberOfLines = 0
        label.text = text
        return label
    }

    func amountAttributed(amount: Double,
                          currency: String?,
                          fractionDigits: Int,
                          removeZeroIfNeeded: Bool,
                          font: UIFont? = nil,
                          fractionalFont: UIFont? = nil) {
        text = ""
        attributedText = UILabel.createAmountAttributedText(amount: amount,
                                                            currency: currency,
                                                            fractionDigits: fractionDigits,
                                                            removeZeroIfNeeded: removeZeroIfNeeded,
                                                            font: font ?? self.font,
                                                            fractionalFont: fractionalFont)
    }

    static func createAmountAttributedText(amount: Double,
                                           currency: String?,
                                           fractionDigits: Int,
                                           removeZeroIfNeeded: Bool,
                                           font: UIFont,
                                           fractionalFont: UIFont? = nil) -> NSMutableAttributedString {
        var attrs = amount.amountAttrs(fractionDigits: fractionDigits)
        if removeZeroIfNeeded, attrs.fractional.trimmingCharacters(in: CharacterSet.whitespaces)
            .rangeOfCharacter(from: ["0"]) != nil {
            attrs.fractional = ""
        }

        if attrs.fractional.isEmpty {
            attrs.separator = ""
        }

        let amountAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let amountAttributedString = NSMutableAttributedString(string: attrs.decimal, attributes: amountAttributes)

        var currency = currency ?? ""

        if currency == "TRY" {
            currency = "TL"
        }

        if (attrs.separator.count + attrs.fractional.count + currency.count) > 0 {
            let fractionCurrencyFont = fractionalFont ?? font.withSize(font.pointSize * 0.8)
            let fractionCurrencyAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: fractionCurrencyFont,
                                                                             NSAttributedString.Key.baselineOffset: 0.5]
            let fractionString = NSMutableAttributedString(string: "\(attrs.separator)\(attrs.fractional)",
                                                           attributes: fractionCurrencyAttributes)
            amountAttributedString.append(fractionString)

            let spaceFont = font.withSize(font.pointSize * 0.5)
            let spaceAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: spaceFont,
                                                                  NSAttributedString.Key.baselineOffset: spaceFont.ascender + spaceFont.descender]
            let spaceString = NSMutableAttributedString(string: " ", attributes: spaceAttributes)
            amountAttributedString.append(spaceString)

            let currencyString = NSMutableAttributedString(string: "\(currency)", attributes: fractionCurrencyAttributes)
            amountAttributedString.append(currencyString)
        }

        return amountAttributedString
    }

    func attributedString(splitString: [String], color: UIColor) {
        text = ""
        attributedText = UILabel.createAttributedString(splitString: splitString,
                                                        color: color)
    }

    static func createAttributedString(splitString: [String], color: UIColor) -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: splitString[0],
                                                                attributes:
                                                                [NSAttributedString.Key.foregroundColor:
                                                                    color,
                                                                    NSAttributedString.Key.font:
                                                                        UIFont(name: AppFont.extraBold, size: 18) ?? UIFont.systemFont(ofSize: 12)])

        let attributedString = NSAttributedString(string: ",\(splitString[1])",
                                                  attributes:
                                                  [NSAttributedString.Key.foregroundColor: color,
                                                   NSAttributedString.Key.font: UIFont(name: AppFont.regular, size: 12) ??
                                                       UIFont.systemFont(ofSize: 12)])

        mutableAttributedString.append(attributedString)
        return mutableAttributedString
    }

    func setHTMLFromString(htmlText: String, useFont: Bool = true) {
        var html = htmlText
        if let font = font, useFont {
            html = String(format: "<span style=\"font-family: \(font.fontName);" +
                "font-size: \(font.pointSize)\">%@</span>", htmlText)
        }
        guard let htmlData = html.data(using: .unicode, allowLossyConversion: true) else { return }
        let attributedString = try? NSMutableAttributedString(
            data: htmlData,
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue,
                      .defaultAttributes: [NSAttributedString.Key.foregroundColor: textColor]],
            documentAttributes: nil
        )
        attributedText = attributedString
    }

    func addAsterisk(putAtFirstCharacter: Bool, textToPut: String) {
        let attributed = NSMutableAttributedString()
        let string1 = NSAttributedString(string: textToPut)
        let string2 = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.pinkOne])

        if putAtFirstCharacter {
            attributed.append(string2)
            attributed.append(NSAttributedString(string: " "))
            attributed.append(string1)
        } else {
            attributed.append(string1)
            attributed.append(NSAttributedString(string: " "))
            attributed.append(string2)
        }

        attributedText = attributed
    }
}
