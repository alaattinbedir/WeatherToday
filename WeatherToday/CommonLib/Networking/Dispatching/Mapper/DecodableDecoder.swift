//
//  DecodableDecoder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public class DecodableDecoder<O>: VulcanDecoder where O: Decodable {
    public func decode(data: Data?, httpStatus _: HTTPStatusCode?) throws -> O {
        if O.self == Data.self {
            if let data = data as? T {
                return data
            }
            throw NetworkErrorType.mappingError
        }

        if let data = data {
            let decoder = JSONDecoder()
            do {
                let instance = try decoder.decode(T.self, from: data)
                return instance
            } catch {
                throw error
            }
        }
        throw NetworkErrorType.mappingError
    }
}
