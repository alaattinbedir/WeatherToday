//
//  PhotoLibraryPermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import Photos

public class PhotoLibraryPermission: PermissionManager {
    public private(set) var currentStatus: PermissionAuthStatus = .notDetermined

    public init() {
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        updateCurrentStatus(PHPhotoLibrary.authorizationStatus())
    }

    public func updateCurrentStatus(_ status: PHAuthorizationStatus) {
        switch status {
        case .notDetermined:
            currentStatus = .notDetermined
        case .restricted:
            currentStatus = .notSupported
        case .denied:
            currentStatus = .gotoAppSettings
        case .authorized:
            currentStatus = .authorized
        default:
            currentStatus = .denied
        }
    }

    public func request(_ listener: @escaping PermissionAuthListener) {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            self.updateCurrentStatus(status)
            listener(self.currentStatus)
        }
    }
}
