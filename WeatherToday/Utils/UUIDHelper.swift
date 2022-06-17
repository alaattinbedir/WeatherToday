//
//  UUIDHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import KeychainAccess
import UIKit

class UUIDHelper {
    class func getUniqueDeviceID() -> String {
        guard let uniqueDeviceId = KeychainKeeper.shared.uniqueDeviceID else {
            let deviceId = (UIDevice.current.identifierForVendor?.uuidString)~
            KeychainKeeper.shared.uniqueDeviceID = deviceId

            if let appGroupUserDefault = UserDefaults(suiteName: Key.AppGroupId) {
                appGroupUserDefault.set(deviceId, forKey: Key.Keychain.uniqueDeviceId)
            }
            return deviceId
        }
        if let appGroupUserDefault = UserDefaults(suiteName: Key.AppGroupId) {
            appGroupUserDefault.set(uniqueDeviceId, forKey: Key.Keychain.uniqueDeviceId)
        }
        return uniqueDeviceId
    }

    class func removeUniqueDeviceID() {
        KeychainKeeper.shared.uniqueDeviceID = nil
    }
}
