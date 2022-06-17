//
//  BesApplyMinimumEstimatedSavingsResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import ObjectMapper

class BesApplyMinimumEstimatedSavingsResponse: Mappable {
    var estimatedSavings: String = ""

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        estimatedSavings <- map["estimatedSavings"]
    }
}
