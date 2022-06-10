//
//  VulcanDecoder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation


public protocol VulcanDecoder {
    associatedtype T
    func decode(data: Data?, httpStatus: HTTPStatusCode?) throws -> T
}

public class AnyVulcanDecoder<O>: VulcanDecoder {
    private let _decode: (Data?, HTTPStatusCode?) throws -> O

    public init<D: VulcanDecoder>(_ decoder: D) where D.T == O {
        _decode = decoder.decode
    }

    public func decode(data: Data?, httpStatus: HTTPStatusCode?) throws -> O {
        return try _decode(data, httpStatus)
    }
}
