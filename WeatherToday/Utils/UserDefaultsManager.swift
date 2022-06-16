//
//  UserDefaultsManager.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
class UserDefaultsManager {
    // MARK: Setters

    static func set(_ value: String?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }

    static func set(_ value: Bool, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }

    static func set(_ value: Int, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }

    static func set(_ value: Double, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }

    static func set(_ value: Float, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }

    static func set<T>(_ value: T, forKey: String) where T: Encodable {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(String(data: encoded, encoding: .utf8)~, forKey: forKey)
        }
    }

    // MARK: Getters

    static func string(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }

    static func bool(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }

    static func integer(forKey: String) -> Int {
        return UserDefaults.standard.integer(forKey: forKey)
    }

    static func double(forKey: String) -> Double {
        return UserDefaults.standard.double(forKey: forKey)
    }

    static func float(forKey: String) -> Float {
        return UserDefaults.standard.float(forKey: forKey)
    }

    static func data(forKey: String) -> Data? {
        return UserDefaults.standard.data(forKey: forKey)
    }

    static func object<T>(_ type: T.Type, forKey: String) -> T? where T: Decodable {
        guard let jsonString = UserDefaults.standard.string(forKey: forKey),
              let jsonData = jsonString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(type, from: jsonData)
    }

    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
