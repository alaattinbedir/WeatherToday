//
//  NetworkErrorType.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

/** Network error types. We can extend later. */
public enum NetworkErrorType: Int, Error, Codable {
    case undefined
    case notConnectedToInternet
    case cancelled
    case timedOut
    case invalidContentType
    case noAcceptableMethod
    case badParamater
    case encodingFailed
    case missingURL
    case mappingError
    case nilResponse
    case nilData
    case unknownHttpStatus
    case taskNotCreated
    case invalidChecksum
    case unsupportedURL
    case cannotFindHost
    case invalidSecurity
}

public extension NetworkErrorType {
    init(_ error: Error?) {
        guard let error = error else {
            self = NetworkErrorType.undefined
            return
        }

        if let mdError = error as? NetworkErrorType {
            self = mdError
        } else if let urlError = error as? URLError {
            self.init(urlError)
        } else if let cfNetworkError = CFNetworkErrors(error) {
            self.init(cfNetworkError)
        } else {
            self = NetworkErrorType.undefined
        }
    }

    init(_ cfNetworkError: CFNetworkErrors?) {
        guard let cfNetworkError = cfNetworkError else {
            self = .undefined
            return
        }
        switch cfNetworkError {
        case .cfurlErrorCancelled:
            self = NetworkErrorType.cancelled
        case .cfurlErrorTimedOut:
            self = NetworkErrorType.timedOut
        default:
            self = NetworkErrorType.undefined
        }
    }

    init(_ urlError: URLError?) {
        guard let urlError = urlError else {
            self = .undefined
            return
        }
        switch urlError {
        case URLError.cancelled:
            self = NetworkErrorType.cancelled
        case URLError.notConnectedToInternet:
            self = NetworkErrorType.notConnectedToInternet
        case URLError.timedOut:
            self = NetworkErrorType.timedOut
        case URLError.unsupportedURL:
            self = NetworkErrorType.unsupportedURL
        case URLError.cannotFindHost:
            self = NetworkErrorType.cannotFindHost
        default:
            self = NetworkErrorType.undefined
        }
    }
}

extension NetworkErrorType: Equatable {
    public static func == (lhs: NetworkErrorType, rhs: NetworkErrorType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
