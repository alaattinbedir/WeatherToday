//
//  PushPermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

import Intents

public class PushPermission: PermissionManager {
    public static let shared = PushPermission()
    public private(set) var currentStatus: PermissionAuthStatus = .notDetermined

    public init() {
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        request { _ in /*  handler */ }
    }

    private func updateCurrentStatus(_ status: UNAuthorizationStatus) {
        switch status {
        case .notDetermined:
            currentStatus = .notDetermined
        case .denied:
            currentStatus = .gotoAppSettings
        default:
            currentStatus = .authorized
        }
    }

    public func request(_ listener: @escaping PermissionAuthListener) {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            self.updateCurrentStatus(settings.authorizationStatus)
            listener(self.currentStatus)
        }
    }
}
