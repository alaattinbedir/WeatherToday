//
//  Keeper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit


final class PersistentKeeper {
    static let shared = PersistentKeeper()

    var hasAppRunBefore = false {
        didSet { UserDefaultsManager.set(hasAppRunBefore, forKey: Key.UserDefaults.hasAppRunBefore) }
    }

    var hasOnBoardingShownBefore = false {
        didSet { UserDefaultsManager.set(hasOnBoardingShownBefore, forKey: Key.UserDefaults.hasOnBoardingShownBefore) }
    }

    var languageDict: [String: String]? {
        didSet { UserDefaultsManager.set(languageDict, forKey: Key.UserDefaults.langDict) }
    }

//    var localeVersion = "" {
//        didSet { KeeperCommon.shared.localeVersion = localeVersion }
//    }

    var lastCheckedAppVersion = "" {
        didSet { UserDefaultsManager.set(lastCheckedAppVersion, forKey: Key.UserDefaults.lastCheckedAppVersion) }
    }

//    var activeReminededUser: MDUser? {
//        didSet { UserDefaultsManager.set(activeReminededUser, forKey: Key.UserDefaults.activeRemindedUser) }
//    }

    var isLoginBefore = false {
        didSet { UserDefaultsManager.set(isLoginBefore, forKey: Key.UserDefaults.isLoginBefore) }
    }

    var isDotLockSuccess = true {
        didSet { UserDefaultsManager.set(isDotLockSuccess, forKey: Key.UserDefaults.isDotLockSuccess) }
    }

    var shouldCheckMsisdn = true {
        didSet { UserDefaultsManager.set(shouldCheckMsisdn, forKey: Key.UserDefaults.shouldCheckMsisdn) }
    }

    var isRemoveVascoBefore = false {
        didSet { UserDefaultsManager.set(isRemoveVascoBefore, forKey: Key.UserDefaults.isRemoveVascoBefore) }
    }

    var hasHealthkitPermission = false {
        didSet { UserDefaultsManager.set(hasHealthkitPermission, forKey: Key.UserDefaults.hasHealthkitPermission) }
    }

    var isPayFast = false {
        didSet { UserDefaultsManager.set(isPayFast, forKey: Key.UserDefaults.isPayFast) }
    }

    var isLandscapeQR = false {
        didSet { UserDefaultsManager.set(isLandscapeQR, forKey: Key.UserDefaults.isLandscapeQR) }
    }

    private var pSelectedLanguageCode: String = ""
    var selectedLanguageCode: String {
        get {
            if pSelectedLanguageCode.isEmpty {
                let defaultLangKey = Key.UserDefaults.langCode
                let turkish = ApplicationLanguageEnum.turkish.rawValue
                let selectedCode = UserDefaultsManager.string(forKey: defaultLangKey) ?? turkish
                pSelectedLanguageCode = selectedCode
            }
            return pSelectedLanguageCode
        }
        set {
            if pSelectedLanguageCode != newValue {
                pSelectedLanguageCode = newValue
                UserDefaultsManager.set(pSelectedLanguageCode, forKey: Key.UserDefaults.langCode)
            }
        }
    }

    var verificationTypeContainTokens: Bool?
    var verificationType: String?

    var favoriteCardMaskNumber: String? {
        didSet { UserDefaultsManager.set(favoriteCardMaskNumber, forKey: Key.UserDefaults.favoriteCardMaskNumber) }
    }

    var plateNumber: String? {
        didSet { UserDefaultsManager.set(plateNumber, forKey: Key.UserDefaults.plateNumber) }
    }

    var dontShowAgainFeedBackCampaign: String? {
        didSet { UserDefaultsManager.set(dontShowAgainFeedBackCampaign, forKey: Key.UserDefaults.userFeedBackArray) }
    }

//    var secureDeviceOtp: String? {
//        didSet { KeeperCommon.shared.secureDeviceOtp = secureDeviceOtp }
//    }

    var autoLoginUser: String? {
        get { UserDefaultsManager.string(forKey: Key.UserDefaults.autoLoginUser) }
        set { UserDefaultsManager.set(newValue, forKey: Key.UserDefaults.autoLoginUser) }
    }

    var autoLoginPass: String? {
        get { UserDefaultsManager.string(forKey: Key.UserDefaults.autoLoginPass) }
        set { UserDefaultsManager.set(newValue, forKey: Key.UserDefaults.autoLoginPass) }
    }

    var isDeletedDevice: Bool = false {
        didSet { UserDefaultsManager.set(isDeletedDevice, forKey: Key.UserDefaults.isDeletedDevice) }
    }

    var isSelectNoForAddDevice: Bool = false {
        didSet { UserDefaultsManager.set(isSelectNoForAddDevice, forKey: Key.UserDefaults.isSelectNoForAddDevice) }
    }

//    var loginInfo: LoginResponse? {
//        didSet {
//            verificationType = loginInfo?.verificationType
//            if let verificationType = verificationType {
//                verificationTypeContainTokens =
//                    verificationType.decrypt() == VerificationType.smsWithSoftToken.rawValue
//                        || verificationType.decrypt() == VerificationType.hardTokenWithSoftToken.rawValue
//            } else {
//                verificationTypeContainTokens = nil
//            }
//        }
//    }

    var testMsisdnModeOn: Bool = false {
        didSet { UserDefaultsManager.set(testMsisdnModeOn, forKey: Key.UserDefaults.testMsisdnModeOpen) }
    }

    private init() {
        hasAppRunBefore = UserDefaultsManager.bool(forKey: Key.UserDefaults.hasAppRunBefore)
        hasOnBoardingShownBefore = UserDefaultsManager.bool(forKey: Key.UserDefaults.hasOnBoardingShownBefore)
        languageDict = UserDefaultsManager.object([String: String].self, forKey: Key.UserDefaults.langDict)
//        localeVersion = KeeperCommon.shared.localeVersion
        lastCheckedAppVersion = UserDefaultsManager.string(forKey: Key.UserDefaults.lastCheckedAppVersion)~
//        activeReminededUser = UserDefaultsManager.object(MDUser.self, forKey: Key.UserDefaults.activeRemindedUser)
        favoriteCardMaskNumber = UserDefaultsManager.string(forKey: Key.UserDefaults.favoriteCardMaskNumber)
        plateNumber = UserDefaultsManager.string(forKey: Key.UserDefaults.plateNumber)
        isLoginBefore = UserDefaultsManager.bool(forKey: Key.UserDefaults.isLoginBefore)
        isDotLockSuccess = UserDefaultsManager.bool(forKey: Key.UserDefaults.isDotLockSuccess)
        isRemoveVascoBefore = UserDefaultsManager.bool(forKey: Key.UserDefaults.isRemoveVascoBefore)
        dontShowAgainFeedBackCampaign = UserDefaultsManager.string(forKey: Key.UserDefaults.userFeedBackArray)
        shouldCheckMsisdn = UserDefaultsManager.bool(forKey: Key.UserDefaults.shouldCheckMsisdn)
//        if let secureDeviceOtp = UserDefaultsManager.string(forKey: Key.UserDefaults.secureDeviceOtp) {
//            self.secureDeviceOtp = secureDeviceOtp
//            KeeperCommon.shared.secureDeviceOtp = secureDeviceOtp
//            UserDefaultsManager.set(nil, forKey: Key.UserDefaults.secureDeviceOtp)
//        } else {
//            secureDeviceOtp = KeeperCommon.shared.secureDeviceOtp
//        }
        isDeletedDevice = UserDefaultsManager.bool(forKey: Key.UserDefaults.isDeletedDevice)
        isSelectNoForAddDevice = UserDefaultsManager.bool(forKey: Key.UserDefaults.isSelectNoForAddDevice)
        isPayFast = UserDefaultsManager.bool(forKey: Key.UserDefaults.isPayFast)
        isLandscapeQR = UserDefaultsManager.bool(forKey: Key.UserDefaults.isLandscapeQR)
    }

    func removeItems() {
//        activeReminededUser = nil
        hasAppRunBefore = false
        hasOnBoardingShownBefore = false
        languageDict = nil
//        localeVersion = ""
        lastCheckedAppVersion = ""
        favoriteCardMaskNumber = ""
        plateNumber = ""
        isLoginBefore = false
        isDotLockSuccess = true
        isRemoveVascoBefore = false
        dontShowAgainFeedBackCampaign = ""
        isDeletedDevice = false
        isSelectNoForAddDevice = false
        shouldCheckMsisdn = true
        isPayFast = false
        isLandscapeQR = false
//        secureDeviceOtp = ""
        autoLoginUser = nil
        autoLoginPass = nil
    }

    func removeSafeDevice() {
        isDeletedDevice = false
        isSelectNoForAddDevice = false
//        SecureDevicesMenuViewModel().continueRemoveDevice(isForgot: true,
//                                                          deviceId: UUIDHelper.getUniqueDeviceID())
//        secureDeviceOtp = ""
    }
}

enum ApplicationLanguageEnum: String {
    case turkish = "TR"
    case english = "EN"

    func getLocalize() -> String {
        switch self {
        case .turkish:
            return "tr-TR"
        case .english:
            return "en"
        }
    }
}


final class SessionKeeper {
    static let shared = SessionKeeper()
//    var currentEnvironment: AppEnvironment = AppEnvironment.prod {
//        didSet {
//            if let appGroupUserDefault = UserDefaults(suiteName: Key.AppGroupId) {
//                appGroupUserDefault.set(APPURL.baseUrl, forKey: Key.UserDefaults.currentEnvironment)
//            }
//        }
//    }

    var encryptionKey = ""
    var expiresIn: Double = 0

    var patternMinLength = 5
    var isUserLoggedIn = false
    var hasMainPageShown = false
    var shouldAutoSubmit = true
    var shouldAutoSubmitOtp = true
    var pushRegistrationId = ""
    var pushNotificationData: [AnyHashable: Any]?
    var deeplinkingCustomData: String?
    var selectedTabIndex = 0 {
        didSet {
            guard let basePageVC = UIApplication.shared.keyWindow?.rootViewController
                as? BasePageVC else { return }
            basePageVC.dataSource = nil
            basePageVC.dataSource = basePageVC
        }
    }

    var isUpdateApplicationProcess: Bool = false
    var associationCode: String = ""
    var eventPageName: PageName?
    var eventAction: String?
    var eventLabel: String?
    var eventValue: String?
    var screenName: String?
    var referrerScreenName: String?
    var enteredFunnelFrom: String?
    var checkMsisdn: Bool = false
    var isSafeDeviceEnabled: Bool = false
    var isSendCampaignState: Bool = false
    var isShowLastUnsuccessfulView: Bool = false
    var isShoppingPage: Bool = false
    var chatbotRecordTime: Int = 7
    var chatbotShowMicButton: Bool = false
    var isVascoOpen: Bool = true
    var customUrl: String = ""
    var customerNo: String = ""
    var isQuickPaymentActive = false
    var menus: [MenuModel]?
    var hasXToken: Bool = false

    private init() {
        // For singleton pattern
    }
}
