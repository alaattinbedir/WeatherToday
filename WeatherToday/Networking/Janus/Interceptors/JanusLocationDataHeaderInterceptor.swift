//
//  JanusLocationDataHeaderInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import CoreLocation

class JanusLocationDataHeaderInterceptor: RequestInterceptor {
    private(set) var lastKnownLocation: MDLocation?
    private let locationManager = MDLocationManager()

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.locationManager.start(desiredAccuracy: kCLLocationAccuracyThreeKilometers) { [weak self] location in
                self?.lastKnownLocation = location
            }
        }
    }

    func onRequest(_: Endpoint, _ request: URLRequest) -> URLRequest {
        var request = request
        if let location = lastKnownLocation {
            request.setValue("geo:\(location.lat),\(location.lon),\(location.alt),u=\(location.accr)",
                             forHTTPHeaderField: HTTPHeaderKey.geolocation.rawValue)
        }
        return request
    }
}
