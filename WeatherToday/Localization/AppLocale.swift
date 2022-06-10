//
//  AppLocale.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

class AppLocale {
    static let shared = AppLocale()

    private init() { /* Singleton */ }

    func load() {
        if let appGroupLangaugeCode = AppLocale.readLangaugeCodeFormAppGroupStore() {
            AppLocalization.shared.language = AppLanguage(rawValue: appGroupLangaugeCode) ?? AppLanguage.turkish
        } else if let code = String.fetchFromDefaults(key: PersistencyKey.langCode, forUser: nil) {
            AppLocalization.shared.language = AppLanguage(rawValue: code) ?? AppLanguage.turkish
            Self.updateAppGroupStore(languageCode: code)
        } else {
            AppLocalization.shared.language = AppLanguage.turkish
            Self.updateAppGroupStore(languageCode: AppLocalization.shared.language.rawValue)
        }
    }

    func updateAppLanguage(_ lang: AppLanguage) {
        AppLocalization.shared.language = lang
        AppLocalization.shared.language.rawValue.saveToDefaults(key: PersistencyKey.langCode, forUser: nil)
        Self.updateAppGroupStore(languageCode: AppLocalization.shared.language.rawValue)
    }

    static func updateAppGroupStore(languageCode: String) {
        guard let appGroupUserDefault = UserDefaults(suiteName: Key.appGroupId) else { return }
        appGroupUserDefault.set(languageCode, forKey: PersistencyKey.langCode)
    }

    static func readLangaugeCodeFormAppGroupStore() -> String? {
        guard let appGroupUserDefault = UserDefaults(suiteName: Key.appGroupId) else { return nil }
        return (appGroupUserDefault.value(forKey: PersistencyKey.langCode) as? String)
    }
}
