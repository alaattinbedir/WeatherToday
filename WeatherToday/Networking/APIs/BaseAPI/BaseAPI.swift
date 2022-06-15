//
//  MySessionManager.swift
//  PhotoApp
//
//  Created by Alaattin Bedir on 2.03.2019.
//  Copyright © 2019 Alaattin Bedir. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
import ObjectMapper

enum ApiContentTypeEnum: String {
    case applicationJson = "application/json"
}

class ErrorMessage: NSObject, Mappable {
    
    var errorCode: String?
    var message: String?
    var httpStatus: Int?
    
    required init?(map _: Map) {
        // Empty function body
    }

    override init() {
        // Empty function body
    }

    convenience init(errorCode: String?, message: String?) {
        self.init()
        self.errorCode = errorCode
        self.message = message
        self.httpStatus = httpStatus
    }

    func mapping(map: Map) {
        message <- map["Message"]
        errorCode <- map["ErrorCode"]
    }

}

class BaseAPI: SessionDelegate {
    
    static let shared = BaseAPI()
    private var session: Session?
    let baseURL = "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/"
    private let timeoutIntervalForRequest: Double = 300

    private init() {
        super.init()
        // Create custom session
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        session = Session(configuration: configuration,
                          delegate: self,
                          startRequestsImmediately: true)
    }

    func clearUrlSessionCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    func request<S: Mappable, F: ErrorMessage>(methotType: HTTPMethod,
                                               params: [String: Any]?,
                                               endPoint: String,
                                               headerParams: ([String: String])? = nil,
                                               succeed: @escaping (S) -> Void,
                                               failed: @escaping (F) -> Void) {
        guard let session = session else { return }
        let contentType = ApiContentTypeEnum.applicationJson.rawValue

        guard networkIsReachable() else {
            if let myError = ErrorMessage(errorCode: "NO_CONNECTION_ERROR", message: NSLocalizedString("No Internet connection", comment: "comment")) as? F {
                failed(myError)
            }
            return
        }

        var url = baseURL + endPoint

        var bodyParams: [String: Any]?
        if let params = params {
            if methotType == .get {
                url.append(URLQueryBuilder(params: params).build())
            } else {
                bodyParams = params
            }
        }

        let headerParams = prepareHeaderForSession(endPoint, methotType, bodyParams, headerParams, contentType)

        printRequest(url: url, methodType: methotType, body: bodyParams, headerParams: headerParams)

        let networkRequest = session.request(url,
                                             method: methotType,
                                             parameters: bodyParams,
                                             encoding: JSONEncoding.default,
                                             headers: HTTPHeaders(headerParams))
                                   .validate(contentType: [contentType])
                                   .validate(statusCode: 200 ..< 600)

               handleJsonResponse(dataRequest: networkRequest,
                                        succeed: succeed,
                                        failed: failed)
    }

    // MARK: Handle Default Json Response

    private func handleJsonResponse<S: Mappable, F: ErrorMessage>(dataRequest: DataRequest,
                                                                      succeed: @escaping (S) -> Void,
                                                                      failed: @escaping (F) -> Void) {
        dataRequest.responseJSON { [weak self] response in
            guard let self = self else { return }

            self.printResponse(response: response.value,
                               statusCode: response.response?.statusCode,
                               url: response.request?.description)

            switch response.result {
            case .success:
                switch self.statusType((response.response?.statusCode)~) {
                case .success:
                    self.handleSuccessfulResponseObject(dataRequest: dataRequest, succeed: succeed)
                case .error:
                    self.handleFailureResponseObject(dataRequest: dataRequest, failed: failed)
                default:
                    break
                }
            case .failure(_):
                    self.handleFailureResponseObject(dataRequest: dataRequest, failed: failed)
                }
            }
    }

    private func handleSuccessfulResponseObject<S: Mappable>(dataRequest: DataRequest,
                                                             succeed: @escaping (S) -> Void) {
        dataRequest.responseObject { (response: DataResponse<S, AFError>) in
            if let responseObject = response.value {
                succeed(responseObject)
            } else {
                let emptyResponse = S(JSON: [:])
                if let emptyResponse = emptyResponse {
                    succeed(emptyResponse)
                }
            }
        }
    }

    private func handleFailureResponseObject<F: Mappable>(dataRequest: DataRequest,
                                                          failed: @escaping (F) -> Void) {
        dataRequest.responseObject { (response: DataResponse<F, AFError>) in
            if let responseObject = response.value {
                if let errorMessage = responseObject as? ErrorMessage {
                    errorMessage.httpStatus = response.response?.statusCode
                }
                failed(responseObject)
            }
        }
    }

    private func prepareHeaderForSession(_: String,
                                         _: HTTPMethod,
                                         _ bodyParams: ([String: Any])?,
                                         _ extraHeaderParams: ([String: String])?,
                                         _ contentType: String) -> [String: String] {
        var allHeaderFields: [String: String] = [:]

        allHeaderFields["Content-Type"] = contentType
        if let extraHeaderParams = extraHeaderParams, !extraHeaderParams.isEmpty {
            allHeaderFields.merge(extraHeaderParams) { _, new in new }
        }

        return allHeaderFields
    }

    private func statusType(_ statusCode: Int) -> StatusType {
        switch statusCode {
        case 200 ..< 300, 428:
            return .success
        case 300 ..< 400:
            return .warning
        case 400 ..< 600:
            return .error
        default:
            return .unknown
        }
    }

    public func networkIsReachable() -> Bool {
        let networkManager = NetworkReachabilityManager()
        let result = networkManager?.isReachable
        return result~
    }

    private func printRequest(url: String?,
                              methodType: HTTPMethod?,
                              body: [String: Any]?,
                              headerParams: [String: String]) {
    #if DEBUG
        let header = headerParams.reduce("\n   ") { $0 + $1.key + ":" + $1.value + "\n      " }
        print("""
        --------------------------------------------------
        Request Url: \(url~)
        Request Type: \(String(describing: methodType))
        Request Parameters: \(String(describing: body))
        Request Headers: \(header)
        """)
    #endif
    }

    private func printResponse(response: Any?,
                               statusCode: Int?,
                               url: String?) {
    #if DEBUG
        print("--------------------------------------------------")

        var options: JSONSerialization.WritingOptions
        if #available(iOS 13.0, *) {
            options = [.prettyPrinted, .withoutEscapingSlashes]
        } else {
            options = [.prettyPrinted]
        }
        if let prettyJson = (response as? [String: Any?])?.toJsonStr(option: options) {
            print(prettyJson)
        } else {
            print(String(describing: response))
        }

        print("""
        --------------------------------------------------
        Response Url: \(String(describing: url))
        Response StatusCode: \(String(describing: statusCode))
        Response Time: \(String(describing: time))
        """)
    #endif
    }

}
