//
//  NetworkRequestStatus.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

/** It is request status and has information parameters. */
public enum NetworkRequestStatus {
    case initialized(_ request: URLRequest)
    case dispatched(_ task: URLSessionTask)
    case response(_ data: Data?, _ response: URLResponse, _ httpStatus: HTTPStatusCode?)
    case error(_ error: NetworkErrorType, _ httpStatus: HTTPStatusCode?)
    case cancelled
}
