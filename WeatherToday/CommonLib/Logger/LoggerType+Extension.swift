//
//  LoggerType+Extension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension LoggerType {
    func i(tag _: String, _: Any...) {
        // empty implementation
    }

    func v(tag _: String, _: Any...) {
        // empty implementation
    }

    func w(tag _: String, _: Any..., error _: Error?) {
        // empty implementation
    }

    func e(tag _: String, _: Any..., error _: Error) {
        // empty implementation
    }

    func analytic(event _: LoggerEvent) {
        // empty implementation
    }
}
