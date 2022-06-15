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

class MyError: Error {
    
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
    let baseURL = "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/"
    
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
    
    func isValidResponse(json: JSON) -> (Bool, String)  {
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
    
    func formatedErrorMessage(errorCode: String) -> MyError {
        var error: MyError
        
        switch errorCode {
        case "MAP_ERROR":
            error = MyError(errorCode: errorCode, errorMessage: NSLocalizedString("Error mapping response", comment: "comment"))
        case "BAD_RESPONSE":
            error = MyError(errorCode: errorCode, errorMessage: NSLocalizedString("Error bad response", comment: "comment"))
        default:
            error = MyError(errorCode: errorCode, errorMessage: NSLocalizedString("An unknown error has occurred", comment: "comment"))
        }
        
        return error
    }

    func request<S: Mappable, F: MyError>(methotType: HTTPMethod,
                                          endPoint: String,
                                          succeed: @escaping (S) -> Void,
                                          failed: @escaping (F) -> Void) {
        guard networkIsReachable() else {
            let myError = MyError(errorCode: "NO_CONNECTION_ERROR", errorMessage: NSLocalizedString("No Internet connection", comment: "comment"))
            failed(myError)
            return
        }

        let url = baseURL + endPoint
        printRequest(url: url)

        self.sessionManager.request(url, method: methotType, headers: nil).responseJSON { (response) -> Void in

            self.printResponse(response: response.result.value,
                               statusCode: response.response?.statusCode,
                               url: response.request?.description)

            if response.result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    let (result, errorCode) = self.isValidResponse(json: json)
                    if result {
                        succeed(json)
                    } else {
                        let error = self.formatedErrorMessage(errorCode: errorCode)
                        failed(error)
                    }
                }
            }

            if response.result.isFailure {
                if let error = response.result.error {
                    let myError = MyError(errorCode: "NETWORK_ERROR", errorMessage: error.localizedDescription)
                    failed(myError)
                }
            }
        }
    }

    public func networkIsReachable() -> Bool {
        let networkManager = NetworkReachabilityManager()
        let result = networkManager?.isReachable
        return result~
    }

    private func printRequest(url: String?) {
        print("""
        --------------------------------------------------
        Request Url: \(String(describing: url))
        """)
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



