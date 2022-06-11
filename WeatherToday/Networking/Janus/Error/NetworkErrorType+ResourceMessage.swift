//
//  NetworkErrorType+ResourceMessage.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

extension NetworkErrorType {
    var presentableMessage: String {
        switch self {
        case .cannotFindHost:
            return "CommonWarningMessageNoNetwork".resource()
        case .notConnectedToInternet:
            return "CommonWarningMessageNoNetwork".resource()
        case .timedOut:
            return "CommonWarningMessageNetworkTimeout".resource()
        case .invalidChecksum:
            return "CommonWarningMessageCheckSum".resource()
        default:
            return "CommonWarningMessage".resource()
        }
    }
}
