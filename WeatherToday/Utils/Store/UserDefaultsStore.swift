//
//  UserDefaultsStore.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class UserDefaultsStore: Storage {
    public static var shared = UserDefaultsStore()
    private let store: UserDefaults

    public init(appGroup: String? = nil) {
        if let appGroup = appGroup, let store = UserDefaults(suiteName: appGroup) {
            self.store = store
        } else {
            store = UserDefaults.standard
        }
    }

    public func get(key: String, forUser: String?, decryptionMethod: ((String) -> String?)?) -> Any? {
        if let decryptionMethod = decryptionMethod,
           let encrpyedContent = store.object(forKey: createKey(key, forUser)) as? String {
            return decryptionMethod(encrpyedContent)
        }
        return store.object(forKey: createKey(key, forUser))
    }

    @discardableResult
    public func set(_ value: Any, key: String, forUser: String?, encryptionMethod: ((String) -> String?)?) -> Bool {
        if let encryptionMethod = encryptionMethod,
           let content = value as? String {
            let encryptedContent = encryptionMethod(content)
            store.set(encryptedContent, forKey: createKey(key, forUser))
        } else {
            store.set(value, forKey: createKey(key, forUser))
        }
        return true
    }

    public func remove(key: String, forUser: String?) {
        store.removeObject(forKey: createKey(key, forUser))
    }

    private func createKey(_ key: String, _ user: String?) -> String {
        if let user = user {
            return "\(user)-\(key)"
        }
        return key
    }

    public func removeAll() {
        store.resetDefaults()
    }
}

// MARK: - Extensions

public extension String {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(key: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String?)? = nil) -> String? {
        return UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? String
    }

    static func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Int {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(key: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String?)? = nil) -> Int? {
        return UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? Int
    }

    func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Double {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(key: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String?)? = nil) -> Double? {
        return UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? Double
    }

    func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Float {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(key: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String?)? = nil) -> Float? {
        return UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? Float
    }

    func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Bool {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(key: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String?)? = nil) -> Bool? {
        return UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? Bool
    }

    func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Data {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(
        key: String,
        forUser: String?,
        decryptionMethod: ((String) -> String?)? = nil
    ) -> Data? {
        return UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? Data
    }

    func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Encodable {
    static func saveToDefaults(_ value: Self,
                               key: String,
                               forUser: String?,
                               encryptionMethod: ((String) -> String)? = nil) {
        guard let encoded = try? JSONEncoder().encode(value),
              let json = String(data: encoded, encoding: .utf8) else {
            return
        }
        json.saveToDefaults(key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }
}

public extension Decodable {
    static func fetchFromDefaults(forKey: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String)? = nil) -> Self? {
        guard let jsonString = String.fetchFromDefaults(key: forKey, forUser: forUser,
                                                        decryptionMethod: decryptionMethod) else { return nil }

        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            return try JSONDecoder().decode(self, from: jsonData)
        } catch {
            return nil
        }
    }
}

public extension UserDefaults {
    func resetDefaults() {
        let dictionary = dictionaryRepresentation()
        dictionary.keys.forEach { key in
            removeObject(forKey: key)
        }

        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}

public extension Date {
    func saveToDefaults(key: String,
                        forUser: String?,
                        encryptionMethod: ((String) -> String?)? = nil) {
        UserDefaultsStore.shared.set(timeIntervalSince1970, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromDefaults(key: String,
                                  forUser: String?,
                                  decryptionMethod: ((String) -> String?)? = nil) -> Date? {
        guard let timeInterval: TimeInterval = UserDefaultsStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? TimeInterval else {
            return nil
        }
        return Date(timeIntervalSince1970: timeInterval)
    }

    func removeFromDefaults(key: String, forUser: String?) {
        UserDefaultsStore.shared.remove(key: key, forUser: forUser)
    }
}
