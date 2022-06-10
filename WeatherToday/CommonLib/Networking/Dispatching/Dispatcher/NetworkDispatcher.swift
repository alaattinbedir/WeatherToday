//
//  NetworkDispatcher.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public typealias NetworkDispatchCompletion = (NetworkDispatchResult) -> Void

/** Request dispatcher protocol */
public protocol NetworkDispatcher {
    var requestInterceptors: [RequestInterceptor]? { get set }
    var responseInterceptors: [ResponseInterceptor]? { get set }

    func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask?
}
