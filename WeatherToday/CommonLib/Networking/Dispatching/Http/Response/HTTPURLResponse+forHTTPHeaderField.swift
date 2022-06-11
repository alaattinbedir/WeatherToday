//
//  HTTPURLResponse+forHTTPHeaderField.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension HTTPURLResponse {
    func value(forHeaderKey: String) -> Any? {
        if #available(iOS 13.0, *) {
            return value(forHTTPHeaderField: forHeaderKey)
        } else {
            return allHeaderFields.first {
                if let key = ($0.key as? String)?.lowercased() {
                    return key == forHeaderKey.lowercased()
                }
                return $0.key == (forHeaderKey as AnyHashable)
            }?.value
        }
    }
}
