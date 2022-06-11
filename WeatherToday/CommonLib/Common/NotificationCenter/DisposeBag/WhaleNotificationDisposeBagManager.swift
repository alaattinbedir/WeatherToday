//
//  WhaleNotificationDisposeBagManager.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public protocol WhaleNotificationDisposeBagManager: AnyObject {
    func addToDisposeBag(_ router: WhaleNotificationRouter)
    func dispose()
}
