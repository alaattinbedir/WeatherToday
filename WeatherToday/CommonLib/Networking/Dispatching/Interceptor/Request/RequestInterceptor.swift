//
//  RequestInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public protocol RequestInterceptor {
    func onRequest(_ endpoint: Endpoint, _ request: URLRequest) -> URLRequest
}
