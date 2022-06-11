//
//  SiriPermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import Intents

public class SiriPermission: PermissionManager {
    public static let shared = SiriPermission()

    public private(set) var currentStatus: PermissionAuthStatus = .notDetermined

    public init() {
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        updateCurrentStatus(INPreferences.siriAuthorizationStatus())
    }

    private func updateCurrentStatus(_ status: INSiriAuthorizationStatus) {
        switch status {
        case .notDetermined:
            currentStatus = .notDetermined
        case .restricted:
            currentStatus = .notSupported
        case .denied:
            currentStatus = .gotoAppSettings
        case .authorized:
            currentStatus = .authorized
        @unknown default:
            currentStatus = .denied
        }
    }

    public func request(_ listener: @escaping PermissionAuthListener) {
        guard currentStatus == .notDetermined || currentStatus == .denied else {
            listener(currentStatus)
            return
        }
        INPreferences.requestSiriAuthorization { [weak self] status in
            guard let self = self else { return }
            self.updateCurrentStatus(status)
            listener(self.currentStatus)
        }
    }
}
