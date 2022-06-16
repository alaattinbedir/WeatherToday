//
//  EmptyResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import ObjectMapper

@objc
class EmptyResponse: NSObject, Mappable {
    @objc var statusCode: Int = 0

    override init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        statusCode <- map["statusCode"]
    }
}
