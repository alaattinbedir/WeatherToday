//
//  BesApplyGetCombinedFundsEP.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

class BesApplyGetCombinedFundsEP: Endpoint, MappableEndpointExecuter, ObservableNetworkActivity, Encodable {
    typealias SuccessType = BesApplyCombinedFundResponse
    typealias ErrorType = ErrorMessage

    let path: String = "/bes/1/fund-selection-list"
    let method: HTTPMethodEnum = .get
    let productCode: String

    init(productCode: String) {
        self.productCode = productCode
    }

    enum CodingKeys: String, CodingKey {
        case productCode
    }
}
