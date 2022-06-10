//
//  CFNetworkErrors.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public extension CFNetworkErrors {
    init?(_ error: Error) {
        let errorCode = (error as NSError).code
        if let cfNetworkError = CFNetworkErrors(rawValue: Int32(errorCode)) {
            self = cfNetworkError
        }
        return nil
    }
}
