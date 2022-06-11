//
//  MicrophonePermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

import AVFoundation

public class MicrophonePermission: PermissionManager {
    public private(set) var currentStatus = PermissionAuthStatus.notDetermined

    public init() {
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        updateCurrentMicrophonePermission(AVAudioSession.sharedInstance().recordPermission)
    }

    private func updateCurrentMicrophonePermission(_ status: AVAudioSession.RecordPermission) {
        switch status {
        case .undetermined:
            currentStatus = .notDetermined
        case .denied:
            currentStatus = .gotoAppSettings
        case .granted:
            currentStatus = .authorized
        @unknown default:
            currentStatus = .denied
        }
    }

    public func request(_ listener: @escaping PermissionAuthListener) {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] accessGranted in
            guard let self = self else { return }
            if accessGranted {
                self.updateCurrentMicrophonePermission(.granted)
            } else {
                self.updateCurrentMicrophonePermission(.denied)
            }
            listener(self.currentStatus)
        }
    }
}
