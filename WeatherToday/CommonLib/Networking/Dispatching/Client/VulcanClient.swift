//
//  VulcanClient.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public protocol VulcanClient {
    var dispatcher: NetworkDispatcher { get }
    func createRequestInterceptors() -> [RequestInterceptor]?
    func createResponseInterceptors() -> [ResponseInterceptor]?
}
