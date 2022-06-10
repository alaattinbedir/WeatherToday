//
//  URL+Extension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public extension URL {
    var isHTTPsScheme: Bool {
        return scheme?.hasPrefix("https") == true
    }
}
