//
//  EmptyResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import ObjectMapper

@objc class EmptyResponse: NSObject, Mappable {
    @objc var statusCode: Int = 0
    override init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        statusCode <- map["statusCode"]
    }

    static func checkStatusType(_ statusCode: Int) -> StatusCodeType {
        switch statusCode {
        case 200 ..< 300:
            return .successStatus
        case 300 ..< 400:
            return .warningStatus
        case 400 ..< 600:
            return .errorStatus
        default:
            return .unknownStatus
        }
    }
}
