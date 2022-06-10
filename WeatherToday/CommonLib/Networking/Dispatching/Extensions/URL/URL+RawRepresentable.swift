//
//  URL+RawRepresentable.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

extension URL: RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: String) {
        if let url = URL(string: rawValue) {
            self = url
        } else {
            return nil
        }
    }

    public var rawValue: String {
        return absoluteString
    }
}
