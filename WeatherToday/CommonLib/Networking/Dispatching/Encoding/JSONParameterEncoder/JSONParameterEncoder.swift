//
//  JSONParameterEncoder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest {
        guard let parameters = parameters else {
            return urlRequest
        }
        do {
            var urlRequest = urlRequest
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            return urlRequest
        } catch {
            throw NetworkErrorType.encodingFailed
        }
    }
}
