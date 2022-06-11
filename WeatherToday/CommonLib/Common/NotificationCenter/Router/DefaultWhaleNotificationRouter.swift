//
//  DefaultWhaleNotificationRouter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public final class DefaultWhaleNotificationRouter: WhaleNotificationRouter {
    private let action: (Notification) -> Void
    public let isTargetAlive: () -> Bool

    public init<T>(
        disposeBag: WhaleNotificationDisposeBagManager,
        target: AnyObject,
        decoder: @escaping (Notification) -> T?,
        actionWithPrm: ((T) -> Void)?,
        actionWithoutPrm: (() -> Void)?
    ) {
        action = { [weak target, weak disposeBag] notification in
            if target != nil {
                if let actionWithPrm = actionWithPrm, let observedValue = decoder(notification) {
                    actionWithPrm(observedValue)
                } else if let actionWithoutPrm = actionWithoutPrm {
                    actionWithoutPrm()
                }
            } else {
                disposeBag?.dispose()
            }
        }

        isTargetAlive = { [weak target] in
            target != nil
        }

        disposeBag.addToDisposeBag(self)
    }

    @objc public func onNotificationHandled(_ notification: Notification) {
        action(notification)
    }

    deinit { print("deinit WhaleNotificationRouter") }
}
