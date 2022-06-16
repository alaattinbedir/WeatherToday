//
//  ErrorMessage.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import ObjectMapper
import Foundation

public enum ResponseTypeEnum: Int {
    case none = 0
    case popup = 1
    case returnStartPopup = 2
    case smsPopup = 3
    case smsException = 4
    case sessionExpire = 5
    case securityError = 6
    case otherDeviceLogin = 7
    case logOffSession = 8
    case requestLimit = 9
    case noAuthorization = 10
    case noInternetConnection = 10000
    case timeout = 10001
    case cancelled = 10002
}

public enum BreakFlowTypeEnum: Int {
    case info = 0
    case warning = 1
    case error = 2
}

@objc
class ErrorMessage: NSObject, Mappable {
    @objc var responseType: Int = 0
    @objc var message: String = ""
    @objc var title: String = ""

    var breakFlowType: BreakFlowTypeEnum = BreakFlowTypeEnum.warning
    var httpStatus: Int?
    var errorCode: Int? = 0

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    override init() {
        // Intentionally unimplemented
    }

    convenience init(errorCode: Int? = 0,
                     message: String) {
        self.init()
        self.errorCode = errorCode
        self.message = message
        self.httpStatus = httpStatus
    }

    convenience init(message: String,
                     title: String,
                     responseType: Int = ResponseTypeEnum.popup.rawValue,
                     httpStatus: Int? = nil,
                     errorCode: Int? = 0) {
        self.init()
        self.message = message
        self.title = title
        self.responseType = responseType
        self.httpStatus = httpStatus
        self.errorCode = errorCode
    }    

    func mapping(map: Map) {
        responseType <- map["ResponseType"]
        message <- map["Message"]
        title <- map["Title"]
        breakFlowType <- (map["ErrorType"], EnumTransform<BreakFlowTypeEnum>())
        errorCode <- map["ErrorCode"]
    }
}
