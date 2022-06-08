//
//  ParameterEncoder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 7.06.2022.
//

import Foundation
public typealias RequestParameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest
}
