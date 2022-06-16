//
//  ObjectConverter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import SwiftyJSON

class ObjectConverter {
    static func convert<T: Codable>(toDict obj: T?) -> [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(obj), let json = try? JSON(data: data) else { return nil }
        return ObjectConverter.convertIntsToBooleans(dict: json.dictionaryObject ?? [:])
    }

    static func convertIntsToBooleans(dict: [String: Any]?) -> [String: Any]? {
        guard var dict = dict else { return nil }
        dict.forEach { key, value in
            if let value = value as? [String: Any] {
                dict[key] = ObjectConverter.convertIntsToBooleans(dict: value)
            } else if type(of: value) == type(of: NSNumber(value: true)) {
                dict[key] = value as? Int == 1
            }
        }
        return dict
    }
}
