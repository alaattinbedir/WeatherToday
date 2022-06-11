//
//  JanusDefaultRequestHeaderInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

struct JanusDefaultRequestHeaderInterceptor: RequestInterceptor {
    let getReferer: () -> String?
    let getUniqueDeviceID: () -> String
    let getToken: () -> String?
    let getLanguageCode: () -> String

    init(getReferer: @escaping () -> String?,
         getUniqueDeviceID: @escaping () -> String,
         getToken: @escaping () -> String?,
         getLanguageCode: @escaping () -> String) {
        self.getReferer = getReferer
        self.getUniqueDeviceID = getUniqueDeviceID
        self.getToken = getToken
        self.getLanguageCode = getLanguageCode
    }

    func onRequest(_: Endpoint, _ request: URLRequest) -> URLRequest {
        var request = request
        request
            .setValue(UIAccessibility.isVoiceOverRunning ? "true" : "false",
                      forHTTPHeaderField: "X-Is-Voice-Over-Enabled")
        request.setValue(getUniqueDeviceID(), forHTTPHeaderField: HTTPHeaderKey.clientId.rawValue)
        request.setValue(getLanguageCode(), forHTTPHeaderField: HTTPHeaderKey.acceptLanguage.rawValue)

        if let referer = getReferer(), referer.count > 0 {
            request.setValue(referer, forHTTPHeaderField: "Referer")
        }

        if let token = getToken(), token.count > 0 {
            request.setValue(token, forHTTPHeaderField: HTTPHeaderKey.token.rawValue)
        }

        #if INTERNAL
            request.setValue(Self.isOnPhoneCall() ? "true" : "false", forHTTPHeaderField: "X-On-Phone-Call")
        #endif

        return request
    }
}
