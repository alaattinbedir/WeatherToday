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
import ObjectMapper

class ErrorMessage: NSObject, NetworkError, Mappable {
    var errorCode: String?
    var message: String?
    var httpStatus: Int?
    
    required init?(map _: Map) {
        // Empty function body
    }

    override init() {
        // Empty function body
    }

    convenience init(errorCode: String?, errorMessage: String?) {
        self.init()
        self.errorCode = errorCode
        self.message = errorMessage
    }

    required init(with error: NetworkErrorType, httpStatus: HTTPStatusCode?) {
        super.init()
        message = error.localizedDescription
        self.httpStatus = httpStatus?.rawValue
    }

    func mapping(map: Map) {
        message <- map["Message"]
        errorCode <- map["ErrorCode"]
    }
}

class BaseAPI: NSObject {
    static let shared = BaseAPI()
    private var sessionManager: SessionManager

    private override init() {
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 280
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        
        self.sessionManager = manager
    }
    
    func validateResponse(json: JSON) -> (Bool, String)  {
        var response = (result: false, errorCode: "")
        
        if !json.isEmpty  {
            response.result = true
            response.errorCode = ""
        } else {
            response.result = false
            response.errorCode = "BAD_RESPONSE"
        }
        
        return response
    }
    
    func request<S: BaseMappable, F: ErrorMessage>(methotType: HTTPMethod,
                                                   endPoint: String,
                                                   params: ([String: Any])?,
                                                   baseURL: String = Keeper.shared.currentEnvironment.domainUrl,
                                                   contentType: String = MimeType.applicationJson.rawValue,
                                                   headerParams: ([String: String])? = nil,
                                                   succeed:@escaping (S) -> Void,
                                                   failed:@escaping (F) -> Void) {

        guard networkIsReachable() else {
            if let myError = ErrorMessage(errorCode: "NO_CONNECTION_ERROR", errorMessage: NSLocalizedString("No Internet connection", comment: "comment")) as? F {
                failed(myError)
            }
            return
        }

        var url = baseURL + endPoint
        var bodyParams: ([String: Any])?
        if let params = params {
            if methotType == .get {
                url.append(URLQueryBuilder(params: params).build())
            } else {
                bodyParams = params
            }
        }

        let headerParams = prepareHeaderForSession(endPoint, methotType, bodyParams, headerParams, contentType)

        printRequest(url: url, methodType: methotType, body: bodyParams, headerParams: headerParams)

        let networkRequest = sessionManager.request(url,
                                    method: methotType,
                                    parameters: bodyParams,
                                    headers: headerParams)
                            .validate(contentType: [contentType])
                            .validate(statusCode: 200 ..< 600)

        handleJsonResponse(dataRequest: networkRequest,
                                 succeed: succeed,
                                 failed: failed)
    }

    // MARK: Handle Default Json Response

    // swiftlint:disable cyclomatic_complexity
    private func handleJsonResponse<S: BaseMappable, F: ErrorMessage>(dataRequest: DataRequest,
                                                                      succeed: @escaping (S) -> Void,
                                                                      failed: @escaping (F) -> Void) {
        dataRequest.responseJSON { [weak self] response in
            guard let self = self else { return }

            self.printResponse(response: response.result.value,
                               statusCode: response.response?.statusCode,
                               url: response.request?.description)

            if response.result.isSuccess {
                switch StatusCodeType.toStatusType(httpStatusCode: response.response?.statusCode) {
                    case .successStatus:
                        self.handleSuccessfullResponseObject(dataRequest: dataRequest, jsonResponse: response, succeed: succeed)
                    case .errorStatus:
                        self.handleFailureResponseObject(dataRequest: dataRequest, jsonResponse: response, failed: failed)
                    default:
                        print("default")
                }
            }

            if response.result.isFailure {
                if let error = response.result.error {
                    if let myError = ErrorMessage(errorCode: "NETWORK_ERROR", errorMessage: error.localizedDescription) as? F {
                        failed(myError)
                    }
                }
            }
        }
    }

    private func handleSuccessfullResponseObject<S: BaseMappable>(dataRequest: DataRequest,
                                                                 jsonResponse: DataResponse<Any>,
                                                                 succeed: @escaping (S) -> Void) {
        let urlString = dataRequest.request?.urlRequest?.url?.absoluteString ?? "noUrl"

        guard jsonResponse.result.isSuccess else {
            Logger.shared.w(tag: "handleSuccessfullResponseObject", "not success", urlString, error: jsonResponse.result.error)
            return
        }

        guard let jsonValue = jsonResponse.result.value else {
            Logger.shared.w(tag: "handleSuccessfullResponseObject", "nil jsonValue", urlString, error: jsonResponse.result.error)
            return
        }

        guard let jsonDict = jsonValue as? [String: Any] else {
            Logger.shared.w(tag: "handleSuccessfullResponseObject", "not dict jsonValue", urlString, error: jsonResponse.result.error)
            return
        }

        if let obj = Mapper<S>().map(JSON: jsonDict) {
            succeed(obj)
            return
        }

        Logger.shared.w(tag: "handleSuccessfullResponseObject", "Mapper problem", urlString, error: jsonResponse.result.error)
    }

    private func handleFailureResponseObject<F: ErrorMessage>(dataRequest: DataRequest,
                                                             jsonResponse: DataResponse<Any>,
                                                             failed: @escaping (F) -> Void) {
        let urlString = dataRequest.request?.urlRequest?.url?.absoluteString ?? "noUrl"

        let defaultError = ErrorMessage(errorCode: "NETWORK_ERROR", errorMessage: jsonResponse.result.error?.localizedDescription) as? F

        guard jsonResponse.result.isSuccess else {
            Logger.shared.w(tag: "handleFailureResponseObject", "not success", urlString, error: jsonResponse.result.error)
            if F.self == ErrorMessage.self, let error = defaultError {
                failed(error)
            }
            return
        }

        guard let jsonValue = jsonResponse.result.value else {
            Logger.shared.w(tag: "handleFailureResponseObject", "nil jsonValue", urlString, error: jsonResponse.result.error)
            if F.self == ErrorMessage.self, let error = defaultError {
                failed(error)
            }
            return
        }

        guard let jsonDict = jsonValue as? [String: Any] else {
            Logger.shared.w(tag: "handleFailureResponseObject", "not dict jsonValue", urlString, error: jsonResponse.result.error)
            if F.self == ErrorMessage.self, let error = defaultError {
                failed(error)
            }
            return
        }

//        if let obj = Mapper<F>().map(JSON: jsonDict) {
//            if let errorMessage = obj as? ErrorMessage {
//                errorMessage.httpStatus = response.response?.statusCode
//                GAEvent(screenName: MDLoggerEventStorage.lastSentScreenName, serviceErrorMessage: errorMessage, serviceError: nil)?.send()
//            }
//            failed(obj)
//            return
//        }

        if F.self == ErrorMessage.self, let error = defaultError {
            failed(error)
        }

        Logger.shared.w(tag: "handleFailureResponseObject", "Mapper problem", urlString, error: jsonResponse.result.error)
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

    // MARK: Reachability for connection

    public func networkIsReachable() -> Bool {
        let networkManager = NetworkReachabilityManager()
        let result = networkManager?.isReachable
        return result ?? false
    }

    public func hasCellularNetwork() -> Bool {
        let networkManager = NetworkReachabilityManager()
        return networkManager?.isReachableOnWWAN ?? false
    }

    func printRequest(url: String?, methodType: HTTPMethod?, body: ([String: Any])?, headerParams: [String: String]) {
        Logger.shared.i(tag: "Network Request",
                        "Request Url: \(url ?? "-")",
                        "Request Type: \(String(describing: methodType))",
                        "Request Parameters: \(String(describing: body))",
                        "Request Headers: ", headerParams.reduce("") { $0 + $1.key + ":" + $1.value + "\n " })
    }

    private func printResponse(response: Any?,
                               statusCode: Int?,
                               url: String?) {
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
    }
}

class CustomServerTrustPoliceManager: ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}



