//
//  ResponseLoggerInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public struct ResponseLoggerInterceptor: ResponseInterceptor {
    private let logger: Logger
    public init(logger: Logger) {
        self.logger = logger
    }

    public func onResponse(_: Endpoint, _ request: URLRequest,
                           _ result: NetworkDispatchResult) -> NetworkDispatchResult {
        var logs = [String]()

        logs.append("url: \(request.url?.absoluteString ?? "-")")
        logs.append("method: \(request.httpMethod ?? "-")")
        logs.append("Referer: \(request.allHTTPHeaderFields?["Referer"] ?? "-")")

        if let status = (result.response as? HTTPURLResponse)?.statusEnum {
            logs.append("status: \(status.rawValue)")
        } else {
            logs.append("status: unknown")
        }

        if let error = result.error {
            logs.append("error: \(error.localizedDescription)")
        }

        if let json = result.data?.toPrettyPrintedJsonText(), json.count > 0 {
            logs.append("data(json): \(json)")
        } else if let data = result.data, let base64 = result.data?.base64EncodedString(), base64.count > 0 {
            logs.append("data(base64): \(base64)")
            logs.append("data(String): \(String(data: data, encoding: .utf8) ?? "-")")
        } else if let data = result.data {
            logs.append("data(data byte count): \(data.count)")
        } else {
            logs.append("data: empty")
        }

        logger.i(tag: "Network Response", logs)
        return result
    }
}
