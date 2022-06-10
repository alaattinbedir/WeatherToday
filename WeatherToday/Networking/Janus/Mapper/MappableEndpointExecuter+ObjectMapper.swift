//
//  MappableEndpointExecuter+ObjectMapper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import ObjectMapper

public class MappableDecoder<O>: VulcanDecoder where O: Mappable {
    public func decode(data: Data?, httpStatus: HTTPStatusCode?) throws -> O {
        if O.self == Data.self {
            if let data = data as? T {
                return data
            }
            throw NetworkErrorType.mappingError
        }

        guard O.self != EmptyResponse.self else { return EmptyResponse() ==> O.self }

        if httpStatus == .noContent, data?.count ?? 0 == 0, let empyObj = O(JSON: [:]) {
            return empyObj
        }

        let mapper = Mapper<O>()
        guard let jsonObject = data?.toJsonObject(),
              let instance = mapper.map(JSONObject: jsonObject) else {
            throw NetworkErrorType.mappingError
        }
        return instance
    }
}

public extension MappableEndpointExecuter where SuccessType: Mappable, ErrorType: Mappable & NetworkError {
    func successDecoder() -> AnyVulcanDecoder<SuccessType> {
        return AnyVulcanDecoder<SuccessType>(MappableDecoder<SuccessType>())
    }

    func errorDecoder() -> AnyVulcanDecoder<ErrorType> {
        return AnyVulcanDecoder<ErrorType>(MappableDecoder<ErrorType>())
    }
}
