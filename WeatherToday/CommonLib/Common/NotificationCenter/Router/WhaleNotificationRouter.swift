//
//  WhaleNotificationRouter.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public protocol WhaleNotificationRouter: AnyObject {
    var isTargetAlive: () -> Bool { get }
    func onNotificationHandled(_ notification: Notification)

    init<T>(disposeBag: WhaleNotificationDisposeBagManager, target: AnyObject, decoder: @escaping (Notification) -> T?,
            actionWithPrm: ((T) -> Void)?, actionWithoutPrm: (() -> Void)?)
}
