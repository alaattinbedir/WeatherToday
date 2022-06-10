//
//  Error+Cancelled.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

extension Error {
    var isUrlCancelled: Bool {
        let error = self as NSError
        return error.code == NSURLErrorCancelled
    }
}
