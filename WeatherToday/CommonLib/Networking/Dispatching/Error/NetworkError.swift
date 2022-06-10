//
//  NetworkError.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

/** base network error protocol. */
public protocol NetworkError {
    init(with error: NetworkErrorType, httpStatus: HTTPStatusCode?)
}
