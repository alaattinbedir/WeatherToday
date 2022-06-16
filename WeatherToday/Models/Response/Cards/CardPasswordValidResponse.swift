//
//  CardPasswordValidResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import ObjectMapper

class CardPasswordValidResponse: Mappable {
    var isValid: Bool = false
    var message: String = ""

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        isValid <- map["isValid"]
        message <- map["message"]
    }
}
