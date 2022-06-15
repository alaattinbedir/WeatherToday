//
//  URLQueryBuilder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
struct URLQueryBuilder {
    let params: [String: Any]

    func build() -> String {
        guard !params.keys.isEmpty else { return "" }

        var query = ""
        query = params
            .compactMap { item in
                if let doubleValue = item.value as? Double {
                    return "\(item.key)=\(doubleValue.string(usesGroupingSeparator: false))"
                } else {
                    return "\(item.key)=\(item.value)"
                }
            }
            .joined(separator: "&")

        return "?\(query)"
    }
}
