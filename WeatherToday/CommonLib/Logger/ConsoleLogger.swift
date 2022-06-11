//
//  ConsoleLogger.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class ConsoleLogger: LoggerType {
    public init() { /* Empty */ }

    public func w(tag: String, _ items: Any..., error _: Error?) {
        log("Warning:", tag, items.toStringForPrint())
    }

    public func e(tag: String, _ items: Any..., error _: Error) {
        log("Error:", tag, items.toStringForPrint())
    }

    public func i(tag: String, _ items: Any...) {
        log("Info:", tag, items.toStringForPrint())
    }

    public func v(tag: String, _ items: Any...) {
        log("Verbose:", tag, items.toStringForPrint())
    }

    public func analytic(event: LoggerEvent) {
        var paramStr = "no-param"
        if let params = event.params {
            paramStr = params.reduce("") { $0 + " " + $1.key + ": " + String(describing: $1.value) }
        }
        log("analytic", event.event, paramStr)
    }

    private func log(_ items: Any...) {
        print(items.toStringForPrint())
    }
}
