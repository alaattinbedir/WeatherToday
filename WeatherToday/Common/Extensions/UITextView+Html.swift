//
//  UITextView+Html.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit

extension UITextView {
    func setHTMLFromString(htmlText: String) {
        var htmlString = htmlText
        if let font = font {
            htmlString = String(format: "<span style=\"font-family: \(font.fontName);" +
                "font-size: \(font.pointSize)\">%@</span>", htmlText)
        }
        guard let htmlData = htmlString.data(using: .unicode, allowLossyConversion: true) else { return }
        let attrStr = try? NSMutableAttributedString(
            data: htmlData,
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue,
                      .defaultAttributes: [NSAttributedString.Key.foregroundColor: textColor]],
            documentAttributes: nil
        )
        attributedText = attrStr
    }

    func setHTMLFromStringWithoutFont(htmlText: String) {
        var htmlString = htmlText
        if let font = font {
            htmlString = String(format: "<span style=\"font-family: Muli;" +
                "font-size: \(font.pointSize)\">%@</span>", htmlText)
        }
        guard let htmlData = htmlString.data(using: .unicode, allowLossyConversion: true) else { return }
        let attrStr = try? NSMutableAttributedString(
            data: htmlData,
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue,
                      .defaultAttributes: [NSAttributedString.Key.foregroundColor: textColor]],
            documentAttributes: nil
        )
        attributedText = attrStr
    }
}
