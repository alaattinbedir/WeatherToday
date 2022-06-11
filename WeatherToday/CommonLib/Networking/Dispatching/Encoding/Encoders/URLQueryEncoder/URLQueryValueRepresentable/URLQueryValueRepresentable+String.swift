//
//  URLQueryValueRepresentable+String.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

extension String: URLQueryValueRepresentable {
    public var urlQueryValue: String? {
        return self
    }
}
