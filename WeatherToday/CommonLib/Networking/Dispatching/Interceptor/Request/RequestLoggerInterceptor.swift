//
//  RequestLoggerInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public struct RequestLoggerInterceptor: RequestInterceptor {
    private let logger: Logger
    public init(logger: Logger) {
        self.logger = logger
    }

    public func onRequest(_: Endpoint, _ request: URLRequest) -> URLRequest {
        var logs = [String]()
        logs.append("url: \(request.url?.absoluteString ?? "-")")
        logs.append("method: \(request.httpMethod ?? "-")")

        let maxBodyCount = 1000
        if let json = request.httpBody?.toPrettyPrintedJsonText(), json.count > 0, json.count < maxBodyCount {
            logs.append("body(json): \(json)")
        } else if let base64 = request.httpBody?.base64EncodedString(), base64.count > 0, base64.count < maxBodyCount {
            logs.append("body(base64): \(base64)")
        } else if let data = request.httpBody {
            logs.append("body(data byte count): \(data.count)")
        } else {
            logs.append("body: empty")
        }

        if let headers = request.allHTTPHeaderFields, headers.count > 0 {
            logs.append(contentsOf: headers.map { "header: \($0.key) - \($0.value)" })
        } else {
            logs.append("header: empty")
        }

        logger.i(tag: "Network Request", logs)
        return request
    }
}
