//
//  BesApplyTO.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

struct BesApplyTO {
    var plan: Product?
    var fundSelectionPrefrences: [BesPreference]?
    var selectedFundPreference: BesPreference?
    var besQuestions: [BesApplyPageQuestion]?
    var participationAmount: Double?
    var sourceAccountId: String?
    var cardGuid: String?
    var paymentElement: Int?
    var riskSurveyResult: BesApplyRiskSurveyResultResponse?
    var hasAlternativePayment: Bool?
    var fundMonthlyReturn: BesApplyMonthlyReturn?
    var fundChangeType: BesFundChangeType?
    var agreementNo: String?
}
