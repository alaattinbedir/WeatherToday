//
//  String+Base64.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension String {
    func base64ToData() -> Data? {
        if let nsdata = Data(base64Encoded: self) {
            return nsdata
        }
        return nil
    }

    func fromBase64() -> String? {
        guard let data = base64ToData() else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(utf8).base64EncodedString()
    }

    var withRequiredFillersForBase64: String {
        self + Array(repeating: "=", count: count % 4)
    }
}
