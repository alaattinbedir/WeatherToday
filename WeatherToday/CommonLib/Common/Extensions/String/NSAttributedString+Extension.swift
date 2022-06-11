//
//  NSAttributedString+Extension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}

public extension String {
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var underlined: NSMutableAttributedString {
        return NSMutableAttributedString(string: self,
                                         attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single
                                             .rawValue])
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data,
                                          options: [NSAttributedString.DocumentReadingOptionKey
                                              .documentType: NSAttributedString.DocumentType
                                              .html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
