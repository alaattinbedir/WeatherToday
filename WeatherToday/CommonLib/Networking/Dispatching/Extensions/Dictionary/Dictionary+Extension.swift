//
//  Dictionary+Extension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension Dictionary where Key == String {
    func toJsonText(option: JSONSerialization.WritingOptions = []) throws -> String? {
        let theJSONData = try JSONSerialization.data(withJSONObject: self, options: option)
        return String(data: theJSONData, encoding: .utf8)
    }

    func convertToObject<T: Decodable>(type _: T.Type) throws -> T? {
        guard let jsonStr = try toJsonText() else { return nil }
        let data = jsonStr.data(using: .utf8)
        return try DecodableDecoder<T>().decode(data: data, httpStatus: nil)
    }
}
