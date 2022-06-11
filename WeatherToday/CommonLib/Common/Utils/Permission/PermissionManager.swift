//
//  PermissionManager.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public protocol PermissionManager {
    var currentStatus: PermissionAuthStatus { get }
    func updateCurrentStatus()
    func request(_ listener: @escaping PermissionAuthListener)
}
