//
//  NSAttributedString+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

infix operator +
extension NSAttributedString {
    static func + (attrString: NSAttributedString,
                   attrString2: NSAttributedString) -> NSAttributedString {
        plus(attrString: attrString, attrString2: attrString2)
    }

    static func plus(attrString: NSAttributedString,
                     attrString2: NSAttributedString) -> NSAttributedString {
        let attrStringAll = NSMutableAttributedString(attributedString: attrString)
        attrStringAll.append(attrString2)
        return attrStringAll
    }

    func attributedDic() -> [NSAttributedString.Key: Any] {
        var attrDic: [NSAttributedString.Key: Any] = [:]
        for attr in attributes(at: 0,
                               effectiveRange: nil) {
            attrDic[attr.key] = attr.value
        }
        return attrDic
    }

    func strike() -> NSAttributedString {
        var attrDic = attributedDic()
        attrDic[NSAttributedString.Key.strikethroughStyle] = 2
        return NSAttributedString(string: string,
                                  attributes: attrDic)
    }

    func font(font: UIFont) -> NSAttributedString {
        var attrDic = attributedDic()
        attrDic[NSAttributedString.Key.font] = font
        return NSAttributedString(string: string,
                                  attributes: attrDic)
    }

    func color(_ color: UIColor) -> NSAttributedString {
        var attrDic = attributedDic()
        attrDic[NSAttributedString.Key.foregroundColor] = color
        return NSAttributedString(string: string,
                                  attributes: attrDic)
    }

    func backG(_ color: UIColor) -> NSAttributedString {
        var attrDic = attributedDic()
        attrDic[NSAttributedString.Key.backgroundColor] = color
        return NSAttributedString(string: string,
                                  attributes: attrDic)
    }

    func baseline(small: Int, large: Int) -> NSAttributedString {
        var attrDic = attributedDic()
        attrDic[NSAttributedString.Key.backgroundColor] = (large - small) / 2
        return NSAttributedString(string: string,
                                  attributes: attrDic)
    }

    func underLine(_ font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: string,
                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                               NSAttributedString.Key.font: font])
    }

    func underLine() -> NSAttributedString {
        return NSAttributedString(string: string,
                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func lineSpaced(_ spacing: CGFloat) -> NSAttributedString {
        var attrDic = attributedDic()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attrDic[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        let attributedString = NSAttributedString(string: string,
                                                  attributes: attrDic)
        return attributedString
    }
}
