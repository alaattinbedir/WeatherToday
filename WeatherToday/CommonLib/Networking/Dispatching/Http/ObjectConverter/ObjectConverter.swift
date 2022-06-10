//
//  ObjectConverter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import SwiftyJSON

class ObjectConverter {
    static func convert<T: Encodable>(toDict obj: T?) -> [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(obj) else { return nil }
        let json = try? JSON(data: data)
        let dict = json?.dictionaryObject
        return dict
    }

    static func convertV2<T: Encodable>(toDict obj: T?) -> [String: Any]? {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(obj),
           let dict =
           ((try? JSONSerialization
                   .jsonObject(with: data, options: [.allowFragments]) as? [String: Any]) as [String: Any]??) {
            return dict
        }
        return convert(toDict: obj)
    }
}
