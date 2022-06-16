//
//  ChangePinRequest.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
class ChangePinRequest: Codable, RequestBodyConvertible {
    var cardGuid: String = ""
    var newPin: String = ""
    var cvv: String = ""

    init(cardGuid: String,
         newPin: String,
         cvv: String) {
        self.cardGuid = cardGuid
        self.newPin = newPin
        self.cvv = cvv
    }

    func toDict() -> [String: Any]? {
        return ObjectConverter.convert(toDict: self)
    }

    func clearData() {
        cardGuid = ""
        newPin = ""
        cvv = ""
    }
}
