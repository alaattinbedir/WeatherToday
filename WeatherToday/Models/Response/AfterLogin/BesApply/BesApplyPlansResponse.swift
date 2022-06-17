//
//  BesApplyPlansResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import ObjectMapper

class BesApplyPlansResponse: Mappable {
    var info: String?
    var products: [Product] = []
    var pageQuestionInfos: [BesApplyPageQuestion] = []
    var fundSelectionPreferences: [BesPreference] = []

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        info <- map["info"]
        products <- map["products"]
        pageQuestionInfos <- map["pageQuestionInfos"]
        fundSelectionPreferences <- map["fundSelectionPrefrences"]
    }
}

public class Product: Mappable {
    var requestText = ""
    var minimumEstimatedSavings = ""
    var amountInfo = ""
    var code = ""
    var name = ""
    var minAmount: Double?
    var maxAmount: Double?

    init() {
        // Empty function body
    }

    public required init?(map _: Map) {
        // Empty function body
    }

    public func mapping(map: Map) {
        requestText <- map["requestText"]
        minimumEstimatedSavings <- map["minimumEstimatedSavings"]
        amountInfo <- map["amountInfo"]
        code <- map["code"]
        name <- map["name"]
        minAmount <- map["minAmount"]
        maxAmount <- map["maxAmount"]
    }
}

public class BesApplyPageQuestion: Mappable {
    var answer = ""
    var question = ""
    var isExpanded = false

    init() {
        // Empty function body
    }

    public required init?(map _: Map) {
        // Empty function body
    }

    public func mapping(map: Map) {
        answer <- map["answer"]
        question <- map["question"]
    }
}

public class BesPreference: Mappable {
    var code: Int = 0
    var name = ""
    var description = ""

    init() {
        // Empty function body
    }

    public required init?(map _: Map) {
        // Empty function body
    }

    public func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        description <- map["description"]
    }
}

enum BesPlanTypes: String {
    case denizPlan = "0067_D"
    case afilliPlan = "0070"
    case emeklilikPlus = "0071_D"

    var planTitle: String {
        switch self {
        case .denizPlan:
            return "Deniz Plan-"
        case .afilliPlan:
            return "Afilli Plan-"
        case .emeklilikPlus:
            return "Emeklilik Plus-"
        }
    }
}
