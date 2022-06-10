//
//  NetworkDispatchResult.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public struct NetworkDispatchResult {
    public let data: Data?
    public let response: URLResponse?
    public let error: Error?

    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
