//
//  WeatherEP.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

class WeatherEP: Endpoint, MappableEndpointExecuter {
    typealias SuccessType = WeatherResponse
    typealias ErrorType = ErrorMessage

    var path: String = "{0},{1}"
    let method: HTTPMethodEnum = .get

    init(latitude: Double, longitude: Double) {
        path = path.replaceParamsWithCurlyBrackets(String(latitude), String(longitude))
    }    
}
