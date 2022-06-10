//
//  Endpoint.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

/** Endpoint protocol it contains edpoint releated stuffs */
public protocol Endpoint {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethodEnum { get }
    var contentType: MimeType { get }
    var acceptType: MimeType { get }
    var parameters: RequestParameters? { get }
    var extraQueryParams: RequestParameters? { get }
    var headers: RequestHTTPHeaders? { get }
    var parameterEncoding: ParameterEncoding { get }
    var timeoutInterval: TimeInterval { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
}
