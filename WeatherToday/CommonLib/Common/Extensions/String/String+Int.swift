//
//  String+Int.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension Optional where Wrapped == String {
    func toInt() -> Int? {
        guard let self = self else { return nil }
        return Int(self)
    }
}

public extension String {
    func toInt(defaultValue: Int) -> Int {
        return Int(self) ?? defaultValue
    }
}
