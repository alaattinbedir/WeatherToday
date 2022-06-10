//
//  MDLocationManager.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import CoreLocation
import AVFoundation

@objc class MDLocationManager: NSObject, CLLocationManagerDelegate {
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()

    var locationListener: ((MDLocation) -> Void)?

    func start(desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest,
               locationListener: @escaping (MDLocation) -> Void) {
        locationManager.desiredAccuracy = desiredAccuracy
        self.locationListener = locationListener
        locationManager.startUpdatingLocation()
    }

    func stop() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        let mdLocation = MDLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude,
                                    alt: location.altitude,
                                    accr: sqrt(pow(location.verticalAccuracy, 2) + pow(location.horizontalAccuracy, 2)))
        locationListener?(mdLocation)
    }

    func locationManager(_: CLLocationManager, didFailWithError _: Error) {
        // Empty function body
    }

    deinit {
        stop()
    }
}

struct MDLocation: Encodable {
    let lat: Double
    let lon: Double
    let alt: Double
    let accr: Double
}
