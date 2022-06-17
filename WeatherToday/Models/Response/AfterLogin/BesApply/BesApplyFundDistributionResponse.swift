//
//  BesApplyFundDistributionResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import ObjectMapper

class BesApplyFundDistributionResponse: Mappable {
    var fundSelectionType: Int?
    var fundMixes: [BesApplyFundDistribution] = []
    var companyFunds: [BesFund] = []

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

class BesApplyCompanyFund: Mappable, Encodable {
    var name: String?
    var funds: [BesFund] = []

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        name <- map["name"]
        funds <- map["funds"]
    }
}

class BesFund: Mappable, Encodable {
    var code: String?
    var description: String?
    var annualReturn: String?
    var minDistributionRate: Double?
    var maxDistributionRate: Double?
    var distributionRate: Double?
    var monthlyReturn: BesApplyMonthlyReturn?
    var type: BesFundType?

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        code <- map["code"]
        description <- map["description"]
        annualReturn <- map["annualReturn"]
        minDistributionRate <- map["minDistributionRate"]
        maxDistributionRate <- map["maxDistributionRate"]
        distributionRate <- map["distributionRate"]
        monthlyReturn <- map["monthlyReturn"]
        type <- (map["type"], EnumTransform<BesFundType>())
    }
}

enum BesFundType: Int, Codable {
    case metlife = 0
    case befas = 1
}
