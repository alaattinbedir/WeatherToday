//
//  HTTPHeaderKey.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public typealias RequestHTTPHeaders = [String: String]

public enum HTTPHeaderKey: String {
    case contentType = "Content-Type"
    case transferEncoding = "Transfer-Encoding"
    case setCookie = "Set-Cookie"
    case acceptLanguage = "Accept-Language"
    case autorization = "Authorization"
    case acceptType = "Accept"
    case geolocation = "Geolocation"
    case malware = "Malware"
    case checkSum = "X-CheckSum"
    case token = "X-Token"
    case clientId = "X-Client-Id"
}
