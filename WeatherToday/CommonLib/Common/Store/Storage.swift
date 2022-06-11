//
//  Storage.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public protocol Storage {
    func get(key: String, forUser: String?, decryptionMethod: ((String) -> String?)?) -> Any?
    func set(_ value: Any, key: String, forUser: String?, encryptionMethod: ((String) -> String?)?) -> Bool
    func remove(key: String, forUser: String?)
    func removeAll()
}

public extension Encodable {
    @discardableResult
    static func saveToStore(store: Storage,
                            _ value: Self,
                            key: String,
                            forUser: String?,
                            encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        guard let encoded = try? JSONEncoder().encode(value),
              let json = String(data: encoded, encoding: .utf8) else {
            return false
        }
        return store.set(json, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }
}

public extension Decodable {
    static func fetchFromStore(store: Storage,
                               forKey: String,
                               forUser: String?,
                               decryptionMethod: ((String) -> String?)? = nil) -> Self? {
        guard let jsonString = store.get(key: forKey, forUser: forUser, decryptionMethod: decryptionMethod) as? String
        else { return nil }
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }

        do {
            return try JSONDecoder().decode(self, from: jsonData)
        } catch {
            return nil
        }
    }
}
