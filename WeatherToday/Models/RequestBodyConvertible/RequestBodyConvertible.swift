//
//  RequestBodyConvertible.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
// All request body struct model must confirm 'RequestBodyConvertible' Protocol

protocol RequestBodyConvertible {
    func toDict() -> [String: Any]?
    func toJson() -> String?
}

extension RequestBodyConvertible {
    func toJson() -> String? {
        return nil
    }

    func toDict() -> [String: Any]? {
        return nil
    }
}
