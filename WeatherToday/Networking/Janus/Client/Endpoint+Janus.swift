//
//  Endpoint+Janus.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

extension Endpoint {
    var baseUrl: URL { URL(string: Keeper.shared.currentEnvironment.domainUrl).required() }
    var contentType: MimeType { MimeType.applicationJson }
    var acceptType: MimeType { MimeType.applicationJson }
    var headers: RequestHTTPHeaders? { nil }
    var timeoutInterval: TimeInterval { JanusClient.timeoutIntervalForRequest }
    var cachePolicy: NSURLRequest.CachePolicy { NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData }
    var extraQueryParams: RequestParameters? { nil }
    var parameters: RequestParameters? { nil }

    var parameterEncoding: ParameterEncoding {
        method == HTTPMethodEnum.get ? ParameterEncoding.urlEncoding : ParameterEncoding.jsonEncoding
    }
}

extension Endpoint where Self: Encodable {
    var parameters: RequestParameters? {
        return ObjectConverter.convertV2(toDict: self)
    }
}

extension Endpoint where Self: MappableEndpointExecuter {
    @discardableResult
    func execute() -> NetworkResponseFuture<SuccessType, ErrorType> {
        defer {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name.mdServiceRequestSent, object: nil)
            }
        }
        return execute(dispatcher: JanusClient.shared.dispatcher, endpoint: self)
    }

    @discardableResult
    func executeWithAsync<T: MappableEndpointExecuter & Endpoint>(to other: T) -> NetworkResponseFuture<(response: SuccessType, responseOther: T.SuccessType),
        (error: ErrorType, errorOther: T.ErrorType)> {
        let promise = NetworkResponsePromise<(response: SuccessType, responseOther: T.SuccessType), (error: ErrorType, errorOther: T.ErrorType)>()
        let group = DispatchGroup()
        var response: SuccessType?
        var responseOther: T.SuccessType?
        var error: ErrorType?
        var errorOther: T.ErrorType?

        group.enter()
        execute()
            .onSucceeded { response1 in
                response = response1
                group.leave()
            }
            .onError { error1 in
                error = error1
                group.leave()
            }
            .onCancelled {
                group.leave()
            }

        group.enter()
        other.execute()
            .onSucceeded { response2 in
                responseOther = response2
                group.leave()
            }
            .onError { error2 in
                errorOther = error2
                group.leave()
            }
            .onCancelled {
                group.leave()
            }

        group.notify(queue: .main) {
            promise.completed(success: (response, responseOther) as? (Self.SuccessType, T.SuccessType), error: (error, errorOther) as? (Self.ErrorType, T.ErrorType))
        }
        return promise
    }
}

extension ObservableNetworkActivity {
    var lockScreen: Bool { true }
}

