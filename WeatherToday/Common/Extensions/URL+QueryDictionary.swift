//
//  URL+QueryDictionary.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
public extension URL {
    var queryDictionary: [String: String]? {
        guard let query = URLComponents(string: absoluteString)?.query else { return nil }

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {
            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .split(separator: "=", maxSplits: 1, omittingEmptySubsequences: true)[safe: 1]?
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }
}
