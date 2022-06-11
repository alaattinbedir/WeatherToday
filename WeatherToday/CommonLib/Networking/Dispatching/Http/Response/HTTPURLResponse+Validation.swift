//
//  HTTPURLResponse+Validation.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension HTTPURLResponse {
    var contentType: MimeType? {
        guard let contentTypeStr = allHeaderFields[HTTPHeaderKey.contentType.rawValue] as? String else {
            return nil
        }
        return MimeType(rawValue: String(contentTypeStr.split(separator: ";").first!))
    }

    var contentTypeStr: String? {
        guard let contentTypeStr = allHeaderFields[HTTPHeaderKey.contentType.rawValue] as? String else {
            return nil
        }
        return contentTypeStr
    }

    func isValidContentType(expected: MimeType) -> Bool {
        guard let contentTypeStr = self.contentTypeStr else {
            return false
        }
        return contentTypeStr.contains(expected.rawValue)
    }
}
