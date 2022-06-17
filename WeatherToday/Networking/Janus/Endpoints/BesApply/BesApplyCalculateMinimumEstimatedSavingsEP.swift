//
//  BesApplyCalculateMinimumEstimatedSavingsEP.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

class BesApplyCalculateMinimumEstimatedSavingsEP: Endpoint, MappableEndpointExecuter, Encodable {
    typealias SuccessType = BesApplyMinimumEstimatedSavingsResponse
    typealias ErrorType = ErrorMessage

    let path: String = "/bes/calculate-estimated-saving"
    let method: HTTPMethodEnum = .post

    let productCode: String
    let amount: Double

    init(_ productCode: String, _ amount: Double) {
        self.productCode = productCode
        self.amount = amount
    }

    enum CodingKeys: String, CodingKey {
        case productCode
        case amount
    }
}
