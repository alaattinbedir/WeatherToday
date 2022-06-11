//
//  URLSessionSSLPinningDelegate.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public class URLSessionSSLPinnigDelegate: NSObject, URLSessionDelegate {
    public let manager: SSLPinnigServerTrustPolicyManager

    public init(manager: SSLPinnigServerTrustPolicyManager) {
        self.manager = manager
    }

    public func urlSession(
        _: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
        var credential: URLCredential?

        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            completionHandler(disposition, credential)
            return
        }

        let host = challenge.protectionSpace.host

        if
            let serverTrustPolicy = manager.serverTrustPolicy(forHost: host),
            let serverTrust = challenge.protectionSpace.serverTrust {
            if serverTrustPolicy.evaluate(serverTrust, forHost: host) {
                disposition = .useCredential
                credential = URLCredential(trust: serverTrust)
            } else {
                disposition = .cancelAuthenticationChallenge
            }
        }

        completionHandler(disposition, credential)
    }
}
