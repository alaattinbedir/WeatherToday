//
//  BesApplyGetFundDistributionListEP.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

class BesApplyGetFundDistributionListEP: Endpoint, MappableEndpointExecuter, ObservableNetworkActivity {
    typealias SuccessType = BesApplyFundDistributionResponse
    typealias ErrorType = ErrorMessage

    let path: String = "/bes/2/fund-selection-list"
    let method: HTTPMethodEnum = .get

    let extraQueryParams: RequestParameters?

    init(productCode: String, includeBefas: Bool = false) {
        extraQueryParams = ["includeBefas": includeBefas.toString(),
                            "productCode": productCode]
    }

    enum CodingKeys: String, CodingKey {
        case extraQueryParams
    }
}
