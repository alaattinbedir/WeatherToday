//
//  AnalyticsHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Adjust
import EVReflection
import Netmera

enum EventCategory: String {
    case cardTransactions = "kart_islemleri"
    case createUser = "kullanici_olusturma"
    case loginEvent = "login"
    case campaignActions = "kampanya_islemleri"
    case transportationCardTransactions = "ulasim_kart_islemleri"
    case paymentTransactions = "odeme_islemleri"
    case invoiceTransactions = "fatura_islemleri"
    case opportunityTransactions = "firsat_islemleri"
    case personalPage = "kisisel_takip"
    case storyClick = "story_click"
    case campaignsClick = "kampanyalar_click"
    case mainPageClick = "anasayfa_click"
    case operationsClick = "islemler_click"
    case shoppingClick = "firsatlar_click"
    case storyWatch = "story_watch"
}

enum EventAction: String {
    case softLogin = "soft_login"
    case hardLogin = "hard_login"
    case campaignClap = "kampanya_alkis"
    case campaignJoin = "kampanya_katilim"
}

enum AdjustToken: String {
    case statementFragment = "xd2wbl"
    case gastoDiscount = "2y6lxa"
    case hardLogin = "nb0in3"
    case campaignJoin = "6uehoe"
    case installment = "bjr4va"
    case paymentWithQR = "gizkcq"
    case softLogin = "cc3t1z"
    case commitmentJoin = "niw99a"
    case installmentCashAdvance = "geyy5p"
    case transportationPaid = "1w5j6d"
    case cardDetail = "56k1ps"
    case debtPayment = "w40r4t"
    case captainTask = "xpkrly"
    case cardPassword = "ciq1dh"
    case cashAdvanceSucceed = "lrkjct"
    case openClosedCard = "8hj8ch"
    case createVirtualCard = "4ffptv"
    case cardApplication = "4r8xn7"
    case technoCardApplication = "t0oj54"
    case extendCardApplication = "2rh9je"
    case limitIncreaseDemand = "tu8zwc"
    case regularLimitIncreaseDemand = "kdl53e"
    case automaticInstallment = "d6j2ff"
    case cardDebtSafe = "4s9dv2"
    case mtvPayment = "h194xv"
    case mtvPaymentDirection = "gsis4f"
    case addTransportation = "284nrf"
    case balanceInquiryTransportation = "wo4pe0"
    case payPhone = "ph5llt"
    case payNaturalGas = "e8vrqy"
    case payElectric = "3y91bd"
    case payWater = "tc9imq"
    case payTelecom = "32dntm"
    case automaticPayPhone = "uvzrcr"
    case automaticPayNaturalGas = "cxydo2"
    case automaticPayElectric = "3saada"
    case automaticPayWater = "86aw6u"
    case automaticPayTelecom = "1vdky5"
    case updateBillDemand = "3zg6j7"
    case createUser = "1o6v1c"
    case virtualCardCvvUpdate = "xoxm9m"
    case overseasDepartureFeePayment = "eyx90l"
    case passportFeePayment = "u4rt5h"
    case loginWithPush = "zg2ffb"
    case paymentWithQrcode = "9amq1g"
    case ecomTransactionPermission = "dk5qcz"
    case closeTemporaryCard = "a8rwka"
    case matchingDevice = "5i39lc"
    case paymentPushConfirmationWith3D = "rrep9q"
    case updateIncome = "8cbroe"
    case transferBonusPoints = "6el0wa"
    case igaFastTrack = "e1xohf"
    case turnaCom = "sn4j3o"
}

class AnalyticsHelper {
    private(set) static var shared: AnalyticsHelper?

    static func configure() {
        shared = AnalyticsHelper()
    }

    class func getAuthorizationStatus() -> NSString {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return "T"
        } else {
            return "F"
        }
    }

    class func getDefaultParams() -> [String: Any] {
        var params: [String: Any] = [:]

        let userID = "\(KeychainKeeper.shared.userIdentifier~)"
        let loginStatus = SessionKeeper.shared.isUserLoggedIn ? "T" : "F"
        let authorizationStatus = getAuthorizationStatus()

        var isDeeplink = "F"
        if let deeplink = SessionKeeper.shared.deeplinkingCustomData, !deeplink.isEmpty {
            isDeeplink = "T"
        }

        params[AnalyticsParam.userId.rawValue] = userID
        params[AnalyticsParam.loginStatus.rawValue] = loginStatus
        params[AnalyticsParam.isDeeplink.rawValue] = isDeeplink
        params[AnalyticsParam.currency.rawValue] = "TR"
        params[AnalyticsParam.dimension2.rawValue] = authorizationStatus // yer izni
        params[AnalyticsParam.dimension3.rawValue] = "" // belge izni
        params[AnalyticsParam.dimension4.rawValue] = "" // telefon izni
        params[AnalyticsParam.dimension5.rawValue] = "" // kampanya izni
        params[AnalyticsParam.dimension6.rawValue] = "" // sms izni
        params[AnalyticsParam.dimension7.rawValue] = "" // kullanıcı segmenti(afili, kurumsal vs.)
        params[AnalyticsParam.dimension8.rawValue] = "" // bireysel kart
        params[AnalyticsParam.dimension9.rawValue] = "" // business kart
        params[AnalyticsParam.dimension10.rawValue] = "" // işletme kart
        params[AnalyticsParam.dimension11.rawValue] = "" // üretici kart
        params[AnalyticsParam.dimension12.rawValue] = "" // banka kart
        params[AnalyticsParam.dimension13.rawValue] = "" // bonus kart
        params[AnalyticsParam.dimension14.rawValue] = false // kart şifresi
        params[AnalyticsParam.dimension15.rawValue] = false // internet alışveriş izni

        #if APP_STORE
            params[AnalyticsParam.developmentVersion.rawValue] =
                (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "-"
        #else
            params[AnalyticsParam.developmentVersion.rawValue] =
                "\((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "-")- DEV"
        #endif

        return params
    }

    class func sendNetmeraEvent(eventCategory: String,
                                eventAction: String,
                                eventLabel: String? = "",
                                eventValue: String? = "",
                                screenName: String? = "") {
        if eventCategory.contains(EventCategory.cardTransactions.rawValue) ||
            eventCategory.contains(EventCategory.paymentTransactions.rawValue) ||
            eventCategory.contains(EventCategory.transportationCardTransactions.rawValue) ||
            eventCategory.contains(EventCategory.invoiceTransactions.rawValue) ||
            eventCategory.contains(EventCategory.createUser.rawValue) {
            SessionKeeper.shared.referrerScreenName = eventCategory
        }
        if eventAction.contains("basarili") {
            SessionKeeper.shared.referrerScreenName = ""
        }
        let defaultParams = AnalyticsHelper.getDefaultParams()
        let mergedParams = getGaEventDictionary(eventCategory, eventAction, eventLabel, eventValue, screenName)
            .merging(defaultParams) { _, new -> Any in new }
        DispatchQueue.main.async {
            let netmeraEvent = GAEvent()
            EVReflection.setPropertiesfromDictionaryBySafe(mergedParams as NSDictionary, anyObject: netmeraEvent)
            Netmera.send(netmeraEvent)
        }
        SessionKeeper.shared.referrerScreenName = ""
        print("\n🕊🕊🕊\nNetmeraEvent\neventCategory: \(eventCategory)\neventAction: \(eventAction)\n🕊🕊🕊\n")
    }

    class func sendAdjustEvent(adjustToken: String? = nil) {
        if let adjustToken = adjustToken {
            sendAdjustEvent(adjustToken: adjustToken)
        }
    }

    class func getGaEventDictionary(_ eventCategory: String,
                                    _ eventAction: String,
                                    _ eventLabel: String? = "",
                                    _ eventValue: String? = "",
                                    _ screenName: String? = "") -> [String: Any] {
        let userId = "\(KeychainKeeper.shared.userIdentifier~)"
        let loginStatus = SessionKeeper.shared.isUserLoggedIn ? "T" : "F"
        var eventValueString: String = eventValue~.replacingOccurrences(of: "TL", with: "")~
        eventValueString = eventValueString.replacingOccurrences(of: " ", with: "")

        return ["eventCategory": eventCategory as NSObject,
                "eventAction": eventAction.lowercased() as NSObject,
                "eventLabel": (eventLabel as NSObject?) ?? "",
                "userID": userId,
                "loginStatus": loginStatus,
                "eventValue": eventValueString.toDouble() as Any,
                "screenName": (screenName as NSObject?) ?? "",
                "referrerScreenName": SessionKeeper.shared.referrerScreenName~,
                "enteredFunnelFrom": SessionKeeper.shared.enteredFunnelFrom~,
                "dimension1": "" as NSObject,
                "dimension4": "" as NSObject,
                "dimension5": "" as NSObject,
                "dimension6": "" as NSObject,
                "dimension7": "" as NSObject,
                "dimension10": "" as NSObject,
                "dimension11": "" as NSObject,
                "dimension12": "" as NSObject,
                "dimension14": false,
                "dimension15": false,
                "dimension8": "" as NSObject,
                "dimension9": "" as NSObject,
                "dimension13": "" as NSObject]
    }

    class func sendAdjustEvent(adjustToken: String) {
        let adjustEvent = ADJEvent(eventToken: adjustToken)
        Adjust.trackEvent(adjustEvent)
    }
}
