//
//  JanusTransactions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import RxCocoa

protocol JanusTransaction: Encodable, MappableEndpointExecuter, Endpoint where
                                            /*Self.SuccessType: ConfirmResponse,*/
                                            Self.ErrorType == ErrorMessage {
    var token: String? { get }
    var eTag: String? { get }
    var otp: String? { get }
    var approvedContracts: [String]? { get }
}

extension JanusTransaction {
    var method: HTTPMethodEnum { HTTPMethodEnum.post }

    var headers: RequestHTTPHeaders? {
        var headers: RequestHTTPHeaders = [:]

        if let eTag = eTag, eTag.count > 0 {
            headers["if-Match"] = eTag
        }

        if let token = token, token.count > 0 {
            headers["X-Transaction-Token"] = token
        }

        guard headers.count > 0 else { return nil }
        return headers
    }
}

extension JanusTransaction {
    func executeTransaction(clearTokeWhenError: Bool = true, _ observer: BehaviorRelay<SuccessType?>, _ completion: @escaping (ErrorType?) -> Void) {
        execute()
            .onSucceeded { [weak observer] response in
                observer?.accept(response)
                completion(nil)
            }
            .onError { [weak observer] error in
                if clearTokeWhenError {
                    observer?.accept(nil)
                }
                completion(error)
            }
    }
}
