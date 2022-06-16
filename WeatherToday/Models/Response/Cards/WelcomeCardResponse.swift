//
//  WelcomeCardResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import ObjectMapper

class WelcomeCardResponse: Mappable {
    var welcomeCards: [WelcomeCard] = []

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        welcomeCards <- map["welcomeCardList"]
    }
}

class WelcomeCard: CardDetail {
    var statementDate: String = ""
    var lastPaymentDate: String = ""
    var hasStatement: Bool = true
    var remainingDebt: String = ""
    var showLastPaymentDate: Bool = false
    var buttons: [String] = []
    var isOwnExtendCard: Bool = false
    var limitPercentage: Double = 0.0
    var remainingDebtEuro: Double?
    var remainingDebtUsd: Double?
    var remainingDebtEuroCurrency: String = ""
    var remainingDebtUsdCurrency: String = ""
    var isCanceled: Bool = false

    override func mapping(map: Map) {
        super.mapping(map: map)
        statementDate <- map["statementDate"]
        lastPaymentDate <- map["lastPaymentDate"]
        remainingDebt <- map["remainingDebt"]
        remainingDebtEuro <- map["remainingDebtEuro"]
        remainingDebtUsd <- map["remainingDebtUsd"]
        remainingDebtEuroCurrency <- map["remainingDebtEuroCurrency"]
        remainingDebtUsdCurrency <- map["remainingDebtUsdCurrency"]
        showLastPaymentDate <- map["showLastPaymentDate"]
        buttons <- map["buttons"]
        isOwnExtendCard <- map["isOwnExtendCard"]
        hasStatement <- map["hasStatement"]
        limitPercentage <- map["limitPercentage"]
        isCanceled <- map["isCanceled"]
    }

    static func == (card1: WelcomeCard, card2: WelcomeCard) -> Bool {
        return card1.guid == card2.guid
    }
}

class WelcomeCardWarningResponse: Mappable {
    var hasWarning = false
    var warningMessage = ""

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        hasWarning <- map["hasWarning"]
        warningMessage <- map["warningMessage"]
    }
}

class TotalRewardDetails: Mappable {
    var totalEarnedRewardCampaign: Double?
    var availableReward: Double?
    var totalCashbackAmount: Double?
    var totalRewardCancelAmount: Double?
    var totalEarnedRewardBank: Double?
    var totalEarnedRewardMerchant: Double?
    var guid: String = ""

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        totalEarnedRewardCampaign <- map["totalEarnedRewardCampaign"]
        availableReward <- map["availableReward"]
        totalCashbackAmount <- map["totalCashbackAmount"]
        totalRewardCancelAmount <- map["totalRewardCancelAmount"]
        totalEarnedRewardBank <- map["totalEarnedRewardBank"]
        totalEarnedRewardMerchant <- map["totalEarnedRewardMerchant"]
        guid <- map["guid"]
    }
}

class TotalRewardDetailsResponse: Mappable {
    var totalRewards: [TotalRewardDetails] = []

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        totalRewards <- map["totalRewardDetails"]
    }
}
