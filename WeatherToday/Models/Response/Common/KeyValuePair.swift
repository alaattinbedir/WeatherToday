//
//  KeyValuePair.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import ObjectMapper

class KeyValuePair: Mappable, Codable, RequestBodyConvertible {
    var key: String = ""
    var value: String = ""

    init() {
        // Intentionally unimplemented
    }

    convenience init(key: String, value: String) {
        self.init()
        self.key = key
        self.value = value
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        key <- map["key"]
        value <- map["value"]
    }

    static func == (lhs: KeyValuePair, rhs: KeyValuePair) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }

    func toDict() -> [String: Any]? {
        return ObjectConverter.convert(toDict: self)
    }
}

class KeyValuePairWithToolTip: KeyValuePair {
    var tooltipData: String?

    convenience init(key: String, value: String, tooltipData: String? = nil) {
        self.init()
        self.key = key
        self.value = value
        self.tooltipData = tooltipData
    }
}
