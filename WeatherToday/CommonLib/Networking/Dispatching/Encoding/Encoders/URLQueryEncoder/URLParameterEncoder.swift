//
//  URLParameterEncoder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest {
        guard let url = urlRequest.url else {
            throw NetworkErrorType.missingURL
        }

        var urlRequest = urlRequest

        guard let parameters = parameters else {
            return urlRequest
        }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                var encodedParam: String?
                if let queryRepresentable = value as? URLQueryValueRepresentable {
                    encodedParam = queryRepresentable.urlQueryValue
                } else {
                    encodedParam = "\(value)"
                }
                let queryItem = URLQueryItem(name: key, value: encodedParam)
                urlComponents.queryItems?.append(queryItem)
            }

            urlRequest.url = urlComponents.url
        }

        return urlRequest
    }
}
