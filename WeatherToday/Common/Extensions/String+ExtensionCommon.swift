//
//  String+ExtensionCommon.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit
import CryptoSwift

extension String {
    func date(with format: DateFormat) -> Date? {
        let formatter = DateFormatter(withFormat: format.rawValue, locale: Locale.current.identifier)
        return formatter.date(from: self)
    }

    func stripHtmlTags() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    func base64ToData() -> Data? {
        if let nsdata = Data(base64Encoded: self) {
            return nsdata
        }
        return nil
    }
}
