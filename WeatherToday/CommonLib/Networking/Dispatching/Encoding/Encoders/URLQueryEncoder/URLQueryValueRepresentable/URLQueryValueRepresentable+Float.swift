//
//  URLQueryValueRepresentable+Float.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

extension Float: URLQueryValueRepresentable {
    public var urlQueryValue: String? {
        return String(format: "%0lf", self)
    }
}
