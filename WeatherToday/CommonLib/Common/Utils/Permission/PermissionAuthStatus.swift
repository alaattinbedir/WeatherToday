//
//  PermissionAuthStatus.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public typealias PermissionAuthListener = (PermissionAuthStatus) -> Void

public enum PermissionAuthStatus {
    case notDetermined
    case gotoAppSettings
    case gotoDeviceSettings
    case authorized
    case denied
    case notSupported
}
