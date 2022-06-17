//
//  Dictionary+Json.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

extension Dictionary {
    func toJsonStr(option: JSONSerialization.WritingOptions = []) -> String {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: option) else { return "" }
        let theJSONText = String(data: theJSONData, encoding: .utf8)
        return theJSONText~
    }

    func toJsonText(option: JSONSerialization.WritingOptions = []) throws -> String? {
        let theJSONData = try JSONSerialization.data(withJSONObject: self, options: option)
        return String(data: theJSONData, encoding: .utf8)
    }
}

extension Dictionary where Key == String {
    subscript(caseInsensitive key: Key) -> Value? {
        get {
            if let k = keys.first(where: { $0.caseInsensitiveCompare(key) == .orderedSame }) {
                return self[k]
            }
            return nil
        }
        set {
            if let k = keys.first(where: { $0.caseInsensitiveCompare(key) == .orderedSame }) {
                self[k] = newValue
            } else {
                self[key] = newValue
            }
        }
    }
}
