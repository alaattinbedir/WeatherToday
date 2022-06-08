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

class NetworkError: Error {
    var errorCode: String?
    var errorMessage: String?
    
    init() {
    }
    
    init(errorCode: String?, errorMessage: String?) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}

class BaseAPI: NSObject {
    static let sharedInstance = BaseAPI()
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
    
    func formatedErrorMessage(errorCode: String) -> NetworkError {
        var error: NetworkError
        
        switch errorCode {
        case "MAP_ERROR":
            error = NetworkError(errorCode: errorCode, errorMessage: NSLocalizedString("Error mapping response", comment: "comment"))
        case "BAD_RESPONSE":
            error = NetworkError(errorCode: errorCode, errorMessage: NSLocalizedString("Error bad response", comment: "comment"))
        default:
            error = NetworkError(errorCode: errorCode, errorMessage: NSLocalizedString("An unknown error has occurred", comment: "comment"))
        }
        
        return error
    }

    func request(methotType: HTTPMethod,
                 endPoint: String,
                 params: ([String: Any])?,
                 baseURL: String = Keeper.shared.currentEnvironment.domainUrl,
                 contentType: String = MimeType.applicationJson.rawValue,
                 headerParams: ([String: String])? = nil,
                 success:@escaping (JSON) -> Void,
                 failure:@escaping (NetworkError) -> Void) {

        guard networkIsReachable() else {
            let myError = NetworkError(errorCode: "NO_CONNECTION_ERROR", errorMessage: NSLocalizedString("No Internet connection", comment: "comment"))
            failure(myError)
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

        let headerParams = self.prepareHeaderForSession(endPoint, methotType, bodyParams, headerParams, contentType)

        self.printRequest(url: url, methodType: methotType, body: bodyParams, headerParams: headerParams)

        self.sessionManager.request(url,
                                    method: methotType,
                                    parameters: bodyParams,
                                    headers: headerParams)
                            .validate(contentType: [contentType])
                            .validate(statusCode: 200 ..< 600)
                            .responseJSON { (response) -> Void in

            self.printResponse(response: response.result.value,
                               statusCode: response.response?.statusCode,
                               url: response.request?.description)

            if response.result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    let (result, errorCode) = self.validateResponse(json: json)
                    if result {
                        success(json)
                    } else {
                        let error = self.formatedErrorMessage(errorCode: errorCode)
                        failure(error)
                    }
                }
            }

            if response.result.isFailure {
                if let error = response.result.error {
                    let myError = NetworkError(errorCode: "NETWORK_ERROR", errorMessage: error.localizedDescription)
                    failure(myError)
                }
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



