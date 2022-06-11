//
//  Array+PrintExtension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
public extension Array {
    func toStringForPrint(seperator: String = " ") -> String {
        return reduce("") { "\($0.isEmpty ? "" : $0 + seperator)\($1)" }
    }
}
