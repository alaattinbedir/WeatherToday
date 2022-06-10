//
//  Endpoint+BuildRequest.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public extension Endpoint {
    var absoluteURL: URL {
        #if INTERNAL
            return baseUrl.appendingPathComponent(path)
        #else
            let url = baseUrl.appendingPathComponent(path)
            if url.isHTTPsScheme {
                return url
            } else {
                let comp = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
                comp?.scheme = "https"
                return (comp?.url).required()
            }
        #endif
    }

    func buildRequest() throws -> URLRequest {
        var request = URLRequest(url: absoluteURL,
                                 cachePolicy: cachePolicy,
                                 timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue

        // Body
        request = try parameterEncoding.encode(urlRequest: request, with: parameters)

        // Extra Query Param
        if let extraQueryParams = extraQueryParams, extraQueryParams.count > 0 {
            request = try URLParameterEncoder().encode(urlRequest: request, with: extraQueryParams)
        }

        // Header
        request = prepareHeader(for: request)

        return request
    }
}
