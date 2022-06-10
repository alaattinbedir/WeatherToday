//
//  Endpoint+BuildHeader.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public extension Endpoint {
    func prepareHeader(for request: URLRequest) -> URLRequest {
        var request = request
        insertHeaders(headers: headers, request: &request)

        if request.value(forHTTPHeaderField: HTTPHeaderKey.contentType.rawValue) == nil {
            request.setValue(contentType.rawValue, forHTTPHeaderField: HTTPHeaderKey.contentType.rawValue)
        }

        if request.value(forHTTPHeaderField: HTTPHeaderKey.acceptType.rawValue) == nil, acceptType != .empty {
            request.setValue(acceptType.rawValue, forHTTPHeaderField: HTTPHeaderKey.acceptType.rawValue)
        }

        return request
    }

    func insertHeaders(headers: RequestHTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
