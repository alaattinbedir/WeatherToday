//
//  JanusClient.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

class JanusClient: VulcanClient {
    static var shared = JanusClient()

    static let timeoutIntervalForRequest: Double = 60

#if APP_STORE
    static let sslPinnigDelegate = URLSessionSSLPinnigDelegate(manager: SSLPinnigServerTrustPolicyManager(policies: [Keeper.shared.currentEnvironment
            .domainName: SSLPinnigServerTrustPolicy
            .pinPublicKeys(publicKeys: SSLPinnigServerTrustPolicy.publicKeys(),
                           validateCertificateChain: true,
                           validateHost: true)]))
#else
    static let sslPinnigDelegate: URLSessionSSLPinnigDelegate? = nil
#endif
    
    static var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default

        if #available(iOS 13.0, *) {
            configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
        } else {
            configuration.tlsMinimumSupportedProtocol = .tlsProtocol12
        }

        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        let session = URLSession(configuration: configuration,
                                 delegate: sslPinnigDelegate,
                                 delegateQueue: nil)
        return session
    }()

    let locationDataHeaderInterceptor = JanusLocationDataHeaderInterceptor()

    private(set) var dispatcher: NetworkDispatcher

    func createRequestInterceptors() -> [RequestInterceptor]? {
        return [
            locationDataHeaderInterceptor,
            RequestLoggerInterceptor(logger: Logger.shared)
        ]
    }

    func createResponseInterceptors() -> [ResponseInterceptor]? {
        return [
            ResponseLoggerInterceptor(logger: Logger.shared),
        ]
    }

    private init() {
        dispatcher = UrlSessionNetworkDispatcher(session: Self.urlSession)
        dispatcher.requestInterceptors = createRequestInterceptors()
        dispatcher.responseInterceptors = createResponseInterceptors()
    }

    func cancelAllTasks() {
        JanusClient.urlSession.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }

    static func clearUrlSessionCache() {
        urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
}
