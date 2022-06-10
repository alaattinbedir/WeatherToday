//
//  ParameterEncoding+Default.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

extension ParameterEncoding: ParameterEncoder {
    public func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest {
        do {
            switch self {
            case .urlEncoding:
                return try URLParameterEncoder().encode(urlRequest: urlRequest, with: parameters)
            case .jsonEncoding:
                return try JSONParameterEncoder().encode(urlRequest: urlRequest, with: parameters)
            }
        } catch {
            throw error
        }
    }
}
