//
//  DefaultWhaleNotificationDisposeBagManager.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public final class DefaultWhaleNotificationDisposeBagManager: WhaleNotificationDisposeBagManager {
    public static var shared: DefaultWhaleNotificationDisposeBagManager = DefaultWhaleNotificationDisposeBagManager()

    private let serialQueue = DispatchQueue(label: "DefaultWhaleNotificationDisposeBagManagerSerialQueue")
    private var disposeBag = [WhaleNotificationRouter]()

    public init() { /* Empty */ }

    public func addToDisposeBag(_ router: WhaleNotificationRouter) {
        serialQueue.async { [weak self] in
            self?.disposeBag.append(router)
        }
    }

    public func dispose() {
        serialQueue.async { [weak self] in
            self?.disposeBag.removeAll { handler in
                !handler.isTargetAlive()
            }
        }
    }

    public func getAliveTargetCount() -> Int {
        return disposeBag.filter { $0.isTargetAlive() }.count
    }
}
