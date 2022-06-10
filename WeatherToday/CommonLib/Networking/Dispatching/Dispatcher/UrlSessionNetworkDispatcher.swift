//
//  UrlSessionNetworkDispatcher.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

/** UrlSession Request dispatcher */
public final class UrlSessionNetworkDispatcher: NetworkDispatcher {
    public var requestInterceptors: [RequestInterceptor]?
    public var responseInterceptors: [ResponseInterceptor]?

    private let session: URLSession

    public init(session: URLSession,
                requestInterceptors: [RequestInterceptor]? = nil,
                responseInterceptors: [ResponseInterceptor]? = nil) {
        self.session = session
        self.requestInterceptors = requestInterceptors
        self.responseInterceptors = responseInterceptors
    }

    public func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask? {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            completion(NetworkDispatchResult(data: data, response: response, error: error))
        }
        return task
    }
}
