//
//  String+Html.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension String {
    var isHtml: Bool {
        let pattern = "<[^>]+>"
        let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil)

        guard range != nil else {
            return false
        }
        return true
    }

    func stripHtmlTags() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
