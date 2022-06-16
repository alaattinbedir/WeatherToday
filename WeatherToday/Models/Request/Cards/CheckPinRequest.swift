//
//  CheckPinRequest.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

class CheckPinRequest: Codable, RequestBodyConvertible {
    var cardGuid: String = ""
    var newPin: String = ""

    init(cardGuid: String,
         newPin: String) {
        self.cardGuid = cardGuid
        self.newPin = newPin
    }

    func toDict() -> [String: Any]? {
        return ObjectConverter.convert(toDict: self)
    }

    func clearData() {
        cardGuid = ""
        newPin = ""
    }
}
