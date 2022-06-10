//
//  ResponseInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public protocol ResponseInterceptor {
    func onResponse(_ endpoint: Endpoint, _ request: URLRequest, _ result: NetworkDispatchResult)
        -> NetworkDispatchResult
}
