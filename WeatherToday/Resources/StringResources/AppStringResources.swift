//
//  AppStringResources.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

class AppStringResources {
    private static let localeVersionPersistantKey = "localeVersion"
    private static let langDictPersistantKey = "langDict"
    private(set) static var shared: AppStringResources = AppStringResources()
    private(set) var localeVersion: String?
    private var langDict: [String: Any]?
    private let userDefaults: UserDefaults

    private init() {
        if let appGroupUserDefault = UserDefaults(suiteName: Key.appGroupId) {
            userDefaults = appGroupUserDefault
        } else {
            userDefaults = UserDefaults.standard
        }
        localeVersion = userDefaults.string(forKey: AppStringResources.localeVersionPersistantKey)
        langDict = userDefaults.dictionary(forKey: AppStringResources.langDictPersistantKey)
    }

    func updateResources(localeVersion: String?, langDict: [String: Any]) {
        self.localeVersion = localeVersion
        self.langDict = langDict
        let safeLangDict = langDict.filter { !($0.value is NSNull) }
        userDefaults.set(safeLangDict, forKey: AppStringResources.langDictPersistantKey)
        userDefaults.set(localeVersion, forKey: AppStringResources.localeVersionPersistantKey)
    }

    func findResource(key: String, searchInLocal: Bool = true) -> Any? {
        if let remoteResource = langDict?[key] {
            return remoteResource
        }
        if searchInLocal {
            return NSLocalizedString(key, comment: "")
        }
        return false
    }
}
