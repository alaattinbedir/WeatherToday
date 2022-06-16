//
//  SplashViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import ReactiveKit
import UIKit

enum SplashViewState: ViewState {
    case ended
}

class SplashViewModel: BaseViewModel {
//    let authenticationApi: AuthenticationAPI
//    var loginApi: LoginAPI
//    var appUpdateUrl: String?
//    var status = HealthKitHelper.shared.getAuthorizationsStatus()
    var isReadyToStartTheApp = false
    var isTokenFetched = false

    required convenience init() {
        self.init()
//        self.init(authenticationApi: AuthenticationAPI(),
//                  loginApi: LoginAPI())
    }

//    init(authenticationApi: AuthenticationAPI,
//         loginApi: LoginAPI) {
//        self.authenticationApi = authenticationApi
//        self.loginApi = loginApi
//    }

    func pageOpened() {
        SessionKeeper.shared.isSendCampaignState = false
        SessionKeeper.shared.isUserLoggedIn = false
        PersistentKeeper.shared.lastCheckedAppVersion = Bundle.main.versionNumber ?? "Unknown"
        if !PersistentKeeper.shared.isRemoveVascoBefore {
//            VascoManager.removeUserActivation()
            PersistentKeeper.shared.isRemoveVascoBefore = true
        }
        getToken()
    }

    private func getToken() {
//        authenticationApi.getAuthToken(params: InitRequest().toDict(),
//                                       succeed: parse,
//                                       failed: handleFailure)
    }

//    private func parse(_ response: AuthTokenResponse) {
//        SessionKeeper.shared.encryptionKey = response.encryptionKey.decrypt(with: STATIC_CHECKSUM_KEY)
//        VascoKeeper.shared().encriptionKey = SessionKeeper.shared.encryptionKey
//        SessionKeeper.shared.expiresIn = response.expiresIn
//        SessionKeeper.shared.checkMsisdn = response.checkMsisdn
//        SessionKeeper.shared.isSafeDeviceEnabled = response.isSafeDeviceEnabled
//        AppLocalization.shared.setServerDate(serverDate: response.currentTime~)
//
//        if let data = response.locale.data {
//            let resources = LanguageResources(localeVersion: response.locale.version,
//                                              langDict: data)
//            resources.saveResources()
//        }
//        checkUpdate(with: response.update)
//        checkHealthKitPermission()
//        isTokenFetched = true
//    }

//    func checkHealthKitPermission() {
//        if KeychainKeeper.shared.isUserRegistered {
//            switch status {
//            case .sharingAuthorized:
//                HealthKitHelper.shared.getLastUserStepsUpdateDate()
//            default:
//                break
//            }
//        }
//    }

//    private func checkUpdate(with updateInfo: UpdateResponse?) {
//        guard let update = updateInfo else {
//            return
//        }
//        if update.hasNewVersion,
//           update.isMandatory || (update.isOptional && isNewAppVersionToCheck(for: update.version)) {
//            appUpdateUrl = update.updateUrl
//            let message: ResourceKey = update.isMandatory ? .popupVersioncontrolHeaderForced : .popupVersioncontrolHeaderOptional
//            let buttons: [AlertButtonTag] = update.isMandatory ? [.forceUpdateUpdate] : [.forceUpdateUpdate, .forceUpdateLater]
//            let model = AlertModel(title: .popupVersioncontrolHeaderBold,
//                                   message: message,
//                                   icon: StatusType.confirm.icon,
//                                   buttons: buttons)
//            alert.send(Alert.appUpdate.with(model))
//        } else {
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, appDelegate.splashTimeOut.value != -1 {
//                isReadyToStartTheApp = true
//            }
//            state.send(SplashViewState.ended)
//        }
//    }

//    private func isNewAppVersionToCheck(for version: String) -> Bool {
//        return VersionChecker.compare(version: version,
//                                      with: PersistentKeeper.shared.lastCheckedAppVersion) == .orderedDescending
//    }

    func jailbreakWarning() {
        alert.send(Alert.jailbreakDetection.model)
    }
}
