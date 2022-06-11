//
//  URLQueryValueRepresentable+Int.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

extension Int: URLQueryValueRepresentable {
    public var urlQueryValue: String? {
        return String(self)
    }
}
