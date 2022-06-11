//
//  NavigationRouter+Device.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

extension NavigationRouter {
    static func openDeviceSettingsPage() {
        if #available(iOS 10.0, *) {
            UIApplication.shared
                .open(URL(string: UIApplication.openSettingsURLString).required(), options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString).required())
        }
    }
}
