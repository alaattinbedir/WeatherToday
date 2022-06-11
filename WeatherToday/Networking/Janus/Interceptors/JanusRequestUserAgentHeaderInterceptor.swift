//
//  JanusRequestUserAgentHeaderInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

struct JanusRequestUserAgentHeaderInterceptor: RequestInterceptor {
    static var userAgent =
        "\(appNameAndVersion()) \(deviceName()) \(deviceVersion()) \(networkVersion()) \(darwinVersion())"

    func onRequest(_: Endpoint, _ request: URLRequest) -> URLRequest {
        var request = request
        request.setValue(JanusRequestUserAgentHeaderInterceptor.userAgent, forHTTPHeaderField: "User-Agent")
        return request
    }

    private static func darwinVersion() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii).required()
            .trimmingCharacters(in: .controlCharacters)
        return "Darwin/\(dv)"
    }

    private static func networkVersion() -> String {
        let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary.required()
        let version = dictionary?["CFBundleShortVersionString"] as? String
        return "CFNetwork/\(version ?? "")"
    }

    private static func deviceVersion() -> String {
        let currentDevice = UIDevice.current
        return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
    }

    private static func deviceName() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii).required()
            .trimmingCharacters(in: .controlCharacters)
    }

    private static func appNameAndVersion() -> String {
        let dictionary = Bundle.main.infoDictionary.required()
        var version = dictionary["CFBundleShortVersionString"] as? String

        #if !APP_STORE // Test
            // Check if saved test version exists.
            if let enteredTestVersion = String.fetchFromDefaults(key: PersistencyKey.enteredVersionNumberForTest, forUser: nil), !enteredTestVersion.isEmpty {
                version = enteredTestVersion
            }
        #endif

        let name = dictionary["CFBundleName"] as? String
        return "\(name ?? "")/\(version ?? "")"
    }
}
