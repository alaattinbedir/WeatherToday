//
//  MappableEndpointExecuter+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public extension MappableEndpointExecuter where ErrorType: NetworkError {
    func map(_ data: Data?, _ error: Error?, _ httpStatus: HTTPStatusCode?) -> ResponseMappingResult<SuccessType, ErrorType> {
        if error != nil || (httpStatus?.responseType.isErrorType ?? false) {
            return .error(mapError(data, error, httpStatus))
        }

        do {
            let successObj = try successDecoder().decode(data: data, httpStatus: httpStatus)
            return .success(successObj)
        } catch {
            let errorObj = mapError(data, error, httpStatus)
            return .error(errorObj)
        }
    }

    func mapError(_ data: Data?, _ error: Error?, _ httpStatus: HTTPStatusCode?) -> ErrorType {
        do {
            return try errorDecoder().decode(data: data, httpStatus: httpStatus)
        } catch let decodindError {
            if let error = error, data == nil {
                return ErrorType(with: NetworkErrorType(error), httpStatus: httpStatus)
            }
            return ErrorType(with: NetworkErrorType(decodindError), httpStatus: httpStatus)
        }
    }
}

public extension MappableEndpointExecuter where SuccessType: Decodable, ErrorType: Decodable & NetworkError {
    func successDecoder() -> AnyVulcanDecoder<SuccessType> {
        return AnyVulcanDecoder<SuccessType>(DecodableDecoder<SuccessType>())
    }

    func errorDecoder() -> AnyVulcanDecoder<ErrorType> {
        return AnyVulcanDecoder<ErrorType>(DecodableDecoder<ErrorType>())
    }
}
