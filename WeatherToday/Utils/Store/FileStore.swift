//
//  FileStore.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class FileStore: Storage {
    public static var logger: Logger?
    private static let checkSum = "h2CVETQwaW3IvzxLw+c/AR4N+ZUAsQlwCzY0bvGODCA="
    public static let shared = FileStore()
    private let secureDir: AppDirectories
    private let writeOptions: Data.WritingOptions

    public init(secureDir: AppDirectories = AppDirectories.library, writeOptions: Data.WritingOptions = [.atomicWrite, .completeFileProtection]) {
        self.secureDir = secureDir
        self.writeOptions = writeOptions
    }

    public func get(key: String, forUser: String?, decryptionMethod: ((String) -> String?)?) -> Any? {
        let fileName = createFileName(key, forUser)
        guard let content = AppFileManipulation.readFile(at: secureDir, withName: fileName) else {
            return nil
        }
        return decryptionMethod?(content) ?? content
    }

    public func set(_ value: Any, key: String, forUser: String?, encryptionMethod: ((String) -> String?)?) -> Bool {
        let fileName = createFileName(key, forUser)
        let text = String(describing: value)

        var isSaved = false
        var logError: Error?
        for _ in stride(from: 0, to: 3, by: 1) {
            do {
                isSaved = try AppFileManipulation
                    .writeFile(text: encryptionMethod?(text) ?? text, to: secureDir, withName: fileName, options: writeOptions)
            } catch {
                logError = error
            }
            if isSaved {
                break
            }
        }

        if let error = logError {
            FileStore.logger?.e(tag: "FileStore",
                                key,
                                encryptionMethod == nil ? "not encrypted" : "encrypted",
                                error: error)
        }

        if isSaved, var url = secureDir.buildFullPath(forFileName: fileName) {
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            do {
                try url.setResourceValues(resourceValues)
            } catch {
                // empty
            }
        }

        return isSaved
    }

    public func remove(key: String, forUser: String?) {
        let fileName = createFileName(key, forUser)
        AppFileManipulation.deleteFile(at: secureDir, withName: fileName)
    }

    private func createFileName(_ key: String, _ user: String?) -> String {
        let fileName: String
        if let user = user {
            fileName = "\(user)\(key)"
        } else {
            fileName = key
        }
        return fileName.convertToValidFileName()
    }

    public func removeAll() {
        for dir in [AppDirectories.inbox, AppDirectories.library, AppDirectories.documents, AppDirectories.temp] {
            AppFileManipulation.deleteFiles(at: dir)
        }
    }
}

public extension String {
    @discardableResult
    func saveToFile(key: String, forUser: String?,
                    encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        return FileStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromFile(key: String,
                              forUser: String?,
                              store: FileStore = FileStore.shared,
                              decryptionMethod: ((String) -> String?)? = nil) -> String? {
        return store.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod) as? String
    }

    static func removeFromFile(key: String, forUser: String?) {
        FileStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Int {
    @discardableResult
    func saveToFile(key: String,
                    forUser: String?,
                    store: FileStore = FileStore.shared,
                    encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        return store.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromFile(
        key: String,
        forUser: String?,
        decryptionMethod: ((String) -> String?)? = nil
    ) -> Int? {
        return FileStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod).toInt()
    }

    func removeFromFile(key: String, forUser: String?) {
        FileStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Double {
    @discardableResult
    func saveToFile(key: String, forUser: String?,
                    encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        return FileStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromFile(
        key: String,
        forUser: String?,
        decryptionMethod: ((String) -> String?)? = nil
    ) -> Double? {
        return FileStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod).toDouble()
    }

    func removeFromFile(key: String, forUser: String?) {
        FileStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Float {
    @discardableResult
    func saveToFile(key: String, forUser: String?,
                    encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        return FileStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromFile(
        key: String,
        forUser: String?,
        decryptionMethod: ((String) -> String?)? = nil
    ) -> Float? {
        return FileStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod).toFloat()
    }

    func removeFromFile(key: String, forUser: String?) {
        FileStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Bool {
    @discardableResult
    func saveToFile(key: String, forUser: String?,
                    encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        return FileStore.shared.set(self, key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromFile(
        key: String,
        forUser: String?,
        decryptionMethod: ((String) -> String?)? = nil
    ) -> Bool? {
        return FileStore.shared.get(key: key, forUser: forUser, decryptionMethod: decryptionMethod).toBool()
    }

    func removeFromFile(key: String, forUser: String?) {
        FileStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Data {
    @discardableResult
    func saveToFile(key: String, forUser: String?,
                    encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        return FileStore.shared
            .set(base64EncodedString(), key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }

    static func fetchFromFile(
        key: String,
        forUser: String?,
        decryptionMethod: ((String) -> String?)? = nil
    ) -> Data? {
        guard let base64EncodedString = FileStore.shared.get(key: key, forUser: forUser,
                                                             decryptionMethod: decryptionMethod) as? String else {
            return nil
        }
        return Data(base64Encoded: base64EncodedString)
    }

    func removeFromFile(key: String, forUser: String?) {
        FileStore.shared.remove(key: key, forUser: forUser)
    }
}

public extension Encodable {
    @discardableResult
    static func saveToFile(_ value: Self,
                           key: String,
                           forUser: String?,
                           encryptionMethod: ((String) -> String?)? = nil) -> Bool {
        guard let encoded = try? JSONEncoder().encode(value),
              let json = String(data: encoded, encoding: .utf8) else {
            return false
        }
        return json.saveToFile(key: key, forUser: forUser, encryptionMethod: encryptionMethod)
    }
}

public extension Decodable {
    static func fetchFromFile(forKey: String,
                              forUser: String?,
                              store: FileStore = FileStore.shared,
                              decryptionMethod: ((String) -> String?)? = nil) -> Self? {
        guard let jsonString = String.fetchFromFile(key: forKey, forUser: forUser, store: store, decryptionMethod: decryptionMethod)
        else { return nil }
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }

        do {
            return try JSONDecoder().decode(self, from: jsonData)
        } catch {
            return nil
        }
    }
}
