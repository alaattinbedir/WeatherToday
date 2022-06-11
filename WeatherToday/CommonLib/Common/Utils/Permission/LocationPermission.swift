//
//  LocationPermission.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

import CoreLocation

@objc public class LocationPermission: NSObject, CLLocationManagerDelegate, PermissionManager {
    private var locationManager: CLLocationManager?
    private var listener: (PermissionAuthListener)?
    public private(set) var currentStatus = PermissionAuthStatus.notDetermined

    override public init() {
        super.init()
        updateCurrentStatus()
    }

    public func updateCurrentStatus() {
        updateCurrentLocationStatus(CLLocationManager.authorizationStatus())
    }

    public func request(_ listener: @escaping (PermissionAuthStatus) -> Void) {
        self.listener = listener
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }

    public func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updateCurrentLocationStatus(status)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.listener?(self.currentStatus)
        }
    }

    private func updateCurrentLocationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            currentStatus = .notDetermined
        case .restricted:
            currentStatus = .notSupported
        case .denied:
            if CLLocationManager.locationServicesEnabled() {
                currentStatus = .gotoAppSettings
            } else {
                currentStatus = .gotoDeviceSettings
            }
        case .authorizedAlways, .authorizedWhenInUse:
            currentStatus = .authorized
        @unknown default:
            currentStatus = .denied
        }
    }
}
