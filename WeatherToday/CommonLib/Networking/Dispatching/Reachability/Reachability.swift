//
//  Reachability.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public protocol Reachability {
    var isEnabled: Bool { get }
    var isReachable: Bool { get }
    var isReachableOnWWAN: Bool { get }
    var isReachableOnEthernetOrWiFi: Bool { get }

    @discardableResult
    func startListening(_ listener: @escaping (ReachabilityStatus) -> Void) -> Bool

    func stopListening()
}

public enum ReachabilityStatus {
    case unknown
    case notReachable
    case reachable(ReachabilityConnectionType)
}

public enum ReachabilityConnectionType {
    case ethernetOrWiFi
    case wwan
}
