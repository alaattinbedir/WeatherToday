//
//  CardDetailResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import ObjectMapper

class CardDetail: Mappable, Equatable {
    var cardType: CardType = .credit
    var cardStatus: String = ""
    var isPrintBlocked: Bool = false
    var guid: String = ""
    var name: String = ""
    var image: String = ""
    var maskedCardNumber: String = ""
    var clearCardNumber: String = ""
    var shadowCardNumber: String = ""
    var cvv2: String = ""
    var availableLimit: String = ""
    var availableLimitCurrency: String = ""
    var availableLimitFirst: String = ""
    var availableLimitSecond: String = ""
    var availableCashLimitFirst: String = ""
    var availableCashLimitSecond: String = ""
    var bonus: String = ""
    var totalLimit: String = ""
    var ownerName: String = ""
    var isSelected = false
    var expiryDate: String = ""
    var currency: Int = 0
    var availableBonus: Double = 0.0
    var availableTransferBonus: Double = 0.0
    var cvv: String = ""
    var cardRefNumber: String = ""
    var isShowBonus = false
    var sourceAccount: String = ""
    var isWithSmartAccount: Bool = false
    var isEnabled = true
    var traceId: String = ""
    var totalDebtAmount: Double = 0.0
    var totalRewardDetails: TotalRewardDetails = TotalRewardDetails()

    init() {
        // Intentionally unimplemented
    }

    init(cardType: CardType,
         guid: String,
         name: String) {
        self.cardType = cardType
        self.guid = guid
        self.name = name
    }

    init(name: String,
         maskedCardNumber: String,
         availableLimitFirst: String,
         availableLimitSecond: String,
         availableLimitCurrency: String) {
        self.name = name
        self.maskedCardNumber = maskedCardNumber
        self.availableLimitFirst = availableLimitFirst
        self.availableLimitSecond = availableLimitSecond
        self.availableLimitCurrency = availableLimitCurrency
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        cardType <- map["cardType"]
        cardStatus <- map["cardStatus"]
        isPrintBlocked <- map["isPrintBlocked"]
        guid <- map["guid"]
        name <- map["name"]
        image <- map["image"]
        maskedCardNumber <- map["maskedCardNumber"]
        shadowCardNumber <- map["shadowCardNumber"]
        clearCardNumber <- map["clearCardNumber"]
        cvv2 <- map["cvv2"]
        availableLimit <- map["availableLimit"]
        availableLimitCurrency <- map["availableLimitCurrency"]
        availableLimitFirst <- map["availableLimitFirst"]
        availableLimitSecond <- map["availableLimitSecond"]
        availableCashLimitFirst <- map["availableCashLimitFirst"]
        availableCashLimitSecond <- map["availableCashLimitSecond"]
        bonus <- map["bonus"]
        totalLimit <- map["totalLimit"]
        ownerName <- map["ownerName"]
        expiryDate <- map["expiryDate"]
        currency <- map["currency"]
        availableBonus <- map["availableBonus"]
        availableTransferBonus <- map["availableTransferBonus"]
        cvv <- map["cvv"]
        cardRefNumber <- map["cardRefNumber"]
        sourceAccount <- map["sourceAccount"]
        isWithSmartAccount <- map["isWithSmartAccount"]
        traceId <- map["traceId"]
        totalDebtAmount <- map["totalDebtAmount"]
    }

    static func == (card1: CardDetail, card2: CardDetail) -> Bool {
        return card1.guid == card2.guid
    }

    func getAvailableLimit() -> Double {
        return availableLimitFirst.amountToDouble() + availableLimitSecond.amountToDouble()
    }
}

extension CardDetail: CardAccountPickerItemable {
    var pickerItem: CardAccountPickerItem {
        return CardAccountPickerItem(left1: name,
                                     left2: maskedCardNumber,
                                     right2: "\(availableLimitFirst)\(availableLimitSecond)",
                                     currency: availableLimitCurrency,
                                     ownerName: ownerName,
                                     balanceAmount: totalLimit,
                                     softLoginLimitFirst: availableLimitFirst,
                                     softLoginLimitSecond: "\(availableLimitSecond) \(availableLimitCurrency)",
                                     cardType: cardType)
    }

    var pickerItemBonus: CardAccountPickerItem {
        return CardAccountPickerItem(left1: name,
                                     left2: maskedCardNumber,
                                     right2: availableBonus.string(),
                                     currency: availableLimitCurrency,
                                     ownerName: ownerName,
                                     balanceAmount: totalLimit,
                                     softLoginLimitFirst: availableLimitFirst,
                                     softLoginLimitSecond: "\(availableLimitSecond) \(availableLimitCurrency)",
                                     cardType: cardType)
    }

    var pickerItemForCashAdvance: CardAccountPickerItem {
        return CardAccountPickerItem(left1: name,
                                     left2: maskedCardNumber,
                                     right2: "\(availableCashLimitFirst)\(availableCashLimitSecond)",
                                     currency: availableLimitCurrency,
                                     ownerName: ownerName,
                                     balanceAmount: totalLimit,
                                     softLoginLimitFirst: availableLimitFirst,
                                     softLoginLimitSecond: "\(availableLimitSecond) \(availableLimitCurrency)",
                                     cardType: cardType)
    }
}
