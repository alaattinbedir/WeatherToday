//
//  CameraPermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

import AVFoundation

@objc public class CameraPermission: NSObject, PermissionManager {
    private let cameraMediaType = AVMediaType.video
    public private(set) var currentStatus = PermissionAuthStatus.notDetermined

    override public init() {
        super.init()
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch status {
        case .notDetermined:
            currentStatus = .notDetermined
        case .authorized:
            currentStatus = .authorized
        case .restricted:
            currentStatus = .notSupported
        case .denied:
            currentStatus = .gotoAppSettings
        @unknown default:
            currentStatus = .denied
        }
    }

    public func request(_ listener: @escaping PermissionAuthListener) {
        updateCurrentStatus()
        if currentStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: cameraMediaType, completionHandler: { accessGranted in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if accessGranted {
                        self.currentStatus = .authorized
                    } else {
                        self.currentStatus = .gotoAppSettings
                    }
                    listener(self.currentStatus)
                }
            })
            return
        }
        listener(currentStatus)
    }
}
