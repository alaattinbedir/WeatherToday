//
//  BesApplyCombinedFundResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import ObjectMapper

class BesApplyCombinedFundResponse: Mappable {
    var fundSelectionType: Int?
    var fundMixes: [BesApplyFundDistribution] = []
    var companyFunds: [BesApplyCompanyFund] = []

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        fundSelectionType <- map["fundSelectionType"]
        fundMixes <- map["fundMixes"]
        companyFunds <- map["companyFunds"]
    }
}
