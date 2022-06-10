//
//  NetworkDispatcher+ExecuteEndpoint.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

extension NetworkDispatcher {
    public func execute(endpoint: Endpoint, statusCallBack: @escaping (NetworkRequestStatus) -> Void) {
        do {
            var urlRequest = try endpoint.buildRequest()
            for interceptor in requestInterceptors ?? [] {
                urlRequest = interceptor.onRequest(endpoint, urlRequest)
            }

            statusCallBack(.initialized(urlRequest))

            let task = execute(urlRequest: urlRequest) { result in
                var result = result
                for interceptor in self.responseInterceptors ?? [] {
                    result = interceptor.onResponse(endpoint, urlRequest, result)
                }

                self.handleResponse(endpoint, result, statusCallBack)
            }

            if let task = task {
                statusCallBack(.dispatched(task))
                task.resume()
            } else {
                statusCallBack(.error(NetworkErrorType.taskNotCreated, nil))
            }
        } catch {
            statusCallBack(.error(NetworkErrorType(error), nil))
        }
    }

    private func handleResponse(_: Endpoint,
                                _ result: NetworkDispatchResult,
                                _ statusCallBack: @escaping (NetworkRequestStatus) -> Void) {
        let httpStatusEnum = (result.response as? HTTPURLResponse)?.statusEnum

        if let error = result.error {
            if error.isUrlCancelled || NetworkErrorType(error) == NetworkErrorType.cancelled {
                statusCallBack(NetworkRequestStatus.cancelled)
            } else {
                statusCallBack(NetworkRequestStatus.error(NetworkErrorType(error), httpStatusEnum))
            }
            return
        }

        guard let response = result.response else {
            statusCallBack(NetworkRequestStatus.error(NetworkErrorType.nilResponse, httpStatusEnum))
            return
        }

        statusCallBack(NetworkRequestStatus.response(result.data, response, httpStatusEnum))
    }
}
