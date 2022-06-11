//
//  BaseTransactionRequest.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

class BaseTransactionRequest {
    let token: String?
    let eTag: String?
    let otp: String?
    let approvedContracts: [String]?

    var headerParams: [String: String]? {
        var params: [String: String] = [:]

        if let eTag = eTag {
            params["if-Match"] = eTag
        }

        if let token = token {
            params["X-Transaction-Token"] = token
        }

        guard params.count > 0 else { return nil }
        return params
    }

    init(eTag: String? = nil, token: String? = nil, otp: String? = nil, approvedContracts: [String]? = nil) {
        self.eTag = eTag
        self.token = token
        self.otp = otp
        self.approvedContracts = approvedContracts
    }

    func combineTransactionParams(_ params: [String: Any]?) -> [String: Any]? {
        var combinedParams: [String: Any] = params ?? [:]

        if let otp = otp {
            combinedParams["otp"] = otp
        }

        if let approvedContracts = approvedContracts {
            combinedParams["approvedContracts"] = approvedContracts
        }

        guard combinedParams.count > 0 else { return params }
        return combinedParams
    }
}
