//
//  URLQueryValueRepresentable+RawRepresentable.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

extension URLQueryValueRepresentable where Self: RawRepresentable, Self.RawValue == String {
    var urlQueryValue: String? {
        return rawValue.urlQueryValue
    }
}

