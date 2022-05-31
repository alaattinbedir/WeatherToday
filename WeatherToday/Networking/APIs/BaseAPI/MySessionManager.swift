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

class MySessionManager: NSObject {
    
    static let sharedInstance = MySessionManager()
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
    
    func requestGETURL(_ endPoint: String, success:@escaping (JSON) -> Void, failure:@escaping (MyError) -> Void) {
        guard Utilities.sharedInstance.isNetworkConnectivityAvailable() else {
            let myError = MyError(errorCode: "NO_CONNECTION_ERROR", errorMessage: NSLocalizedString("No Internet connection", comment: "comment"))
            failure(myError)
            return
        }
        
        self.sessionManager.request(baseURL + endPoint, method: .get, headers: nil).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                if let value = responseObject.result.value {
                    let json = JSON(value)
                    let (result, errorCode) = self.isValidResponse(json: json)
                    if result {
                        success(json)
                    } else {
                        let error = self.formatedErrorMessage(errorCode: errorCode)
                        failure(error)
                    }
                }
            }
            
            if responseObject.result.isFailure {
                if let error = responseObject.result.error {
                    let myError = MyError(errorCode: "NETWORK_ERROR", errorMessage: error.localizedDescription)
                    failure(myError)
                }
            }
        }
    }
    
    func requestPOSTURL(_ strURL: String, params: [String: AnyObject]?, headers: [String: String]?, success:@escaping (JSON) -> Void, failure: @escaping (MyError) -> Void) {
        
        guard Utilities.sharedInstance.isNetworkConnectivityAvailable() else {
            let myError = MyError(errorCode: "NO_CONNECTION_ERROR", errorMessage: NSLocalizedString("No Internet connection", comment: "comment"))
            failure(myError)
            return
        }
        
        self.sessionManager.request(baseURL + strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                if let value = responseObject.result.value {
                    let json = JSON(value)
                    let (result, errorCode) = self.isValidResponse(json: json)
                    if result {
                        success(json)
                    } else {
                        let error = self.formatedErrorMessage(errorCode: errorCode)
                        failure(error)
                    }
                }
            }
            
            if responseObject.result.isFailure {
                if let error = responseObject.result.error {
                    let myError = MyError(errorCode: "NETWORK_ERROR", errorMessage: error.localizedDescription)
                    failure(myError)
                }
            }
        }
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



