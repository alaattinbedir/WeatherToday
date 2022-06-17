//
//  BesApplyRiskSurveyResultResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import ObjectMapper

class BesApplyRiskSurveyResultResponse: Mappable {
    var riskProfileName: String?
    var riskProfileInfo: String?
    var fundMix: BesApplyFundDistribution?
    var alternativeRiskPlan: BesApplyRiskPlan?

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        riskProfileName <- map["riskProfileName"]
        riskProfileInfo <- map["riskProfileInfo"]
        fundMix <- map["fundMix"]
        alternativeRiskPlan <- map["alternativeAssurancePlan"]
    }
}

class BesApplyFundDistribution: Mappable, Encodable {
    var name: String?
    var id: String?
    var riskInfo: String?
    var annualReturn: String?
    var funds: [BesFund]?
    var monthlyReturn: BesApplyMonthlyReturn?

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        riskInfo <- map["riskInfo"]
        annualReturn <- map["annualReturn"]
        funds <- map["funds"]
        monthlyReturn <- map["monthlyReturn"]
    }
}

class BesApplyMonthlyReturn: Mappable, Encodable {
    var oneMonthReturn: String?
    var twelveMonthsReturn: String?
    var threeMonthsReturn: String?
    var sixMonthsReturn: String?

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        oneMonthReturn <- map["oneMonthReturn"]
        twelveMonthsReturn <- map["twelveMonthsReturn"]
        threeMonthsReturn <- map["threeMonthsReturn"]
        sixMonthsReturn <- map["sixMonthsReturn"]
    }
}

class BesApplyRiskPlan: Mappable {
    var name: String?
    var code: String?
    var minimumEstimatedSavingsWithCurrency: String?
    var description: String?

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        name <- map["name"]
        code <- map["code"]
        minimumEstimatedSavingsWithCurrency <- map["minimumEstimatedSavingsWithCurrency"]
        description <- map["description"]
    }
}
