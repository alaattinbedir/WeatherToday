//
//  WhaleNotifiable.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
public protocol WhaleNotifiable {
    associatedtype ObservedValueType

    static func decode(notification: Notification) -> ObservedValueType?

    static var notificationName: NSNotification.Name { get }

    static func observe(target: AnyObject, handler: @escaping (ObservedValueType) -> Void)
    static func observe(target: AnyObject, handler: @escaping () -> Void)

    func broadcast()
}
