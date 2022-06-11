//
//  SpeechPermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import Speech

public class SpeechPermission: PermissionManager {
    public private(set) var currentStatus = PermissionAuthStatus.notDetermined

    public init() {
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        updateCurrentSpeechPermission(SFSpeechRecognizer.authorizationStatus())
    }

    private func updateCurrentSpeechPermission(_ status: SFSpeechRecognizerAuthorizationStatus) {
        switch status {
        case .notDetermined:
            currentStatus = .notDetermined
        case .denied:
            currentStatus = .gotoAppSettings
        case .authorized:
            currentStatus = .authorized
        case .restricted:
            // TODO:
            currentStatus = .denied
        @unknown default:
            currentStatus = .denied
        }
    }

    public func request(_ listener: @escaping PermissionAuthListener) {
        SFSpeechRecognizer.requestAuthorization { [weak self] accessGranted in
            guard let self = self else { return }
            self.updateCurrentSpeechPermission(accessGranted)
            listener(self.currentStatus)
        }
    }
}
