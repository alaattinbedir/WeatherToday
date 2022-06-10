//
//  MappableEndpointExecuter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public protocol MappableEndpointExecuter {
    associatedtype SuccessType
    associatedtype ErrorType

    func execute(dispatcher: NetworkDispatcher, endpoint: Endpoint) -> NetworkResponseFuture<SuccessType, ErrorType>
    func map(_ data: Data?, _ error: Error?, _ httpStatus: HTTPStatusCode?)
        -> ResponseMappingResult<SuccessType, ErrorType>
    func successDecoder() -> AnyVulcanDecoder<SuccessType>
    func errorDecoder() -> AnyVulcanDecoder<ErrorType>
}

public extension MappableEndpointExecuter {
    func execute(dispatcher: NetworkDispatcher, endpoint: Endpoint) -> NetworkResponseFuture<SuccessType, ErrorType> {
        let promise = NetworkResponsePromise<SuccessType, ErrorType>()

        DispatchQueue.getCurrentQueue().async {
            dispatcher.execute(endpoint: endpoint) { status in
                switch status {
                case let .initialized(request):
                    promise.prepared(request: request)
                case let .dispatched(task):
                    promise.started(task: task)
                case .cancelled:
                    promise.cancelled()
                case let .response(data, _, httpStatus):
                    self.notifyResponse(data, nil, httpStatus, promise)
                case let .error(error, httpStatus):
                    self.notifyResponse(nil, error, httpStatus, promise)
                }
            }
        }

        return promise
    }

    private func notifyResponse(_ data: Data?,
                                _ error: Error?,
                                _ httpStatus: HTTPStatusCode?,
                                _ promise: NetworkResponsePromise<SuccessType, ErrorType>) {
        let state = map(data, error, httpStatus)
        switch state {
        case let .success(successObj):
            promise.succeeded(success: successObj)
        case let .error(errorObj):
            promise.failed(error: errorObj)
        }
    }
}

public enum ResponseMappingResult<SuccessType, ErrorType> {
    case success(SuccessType)
    case error(ErrorType)
}
