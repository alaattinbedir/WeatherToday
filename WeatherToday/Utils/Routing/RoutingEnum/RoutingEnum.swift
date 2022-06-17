//
//  RoutingEnum.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation

enum RoutingEnum {
    case none
    case splash
    case landing
    case weather
    case landingWelcome
    case securityQuestionInfoPopUp
    case popup(title: String, message: String, type: WarningType, buttonActions: [(title: String, action: () -> Void)])
    case besApply
    case besApplyDetail(besQuestions: [BesApplyPageQuestion])
    case besApplyInfoStep(transferObject: BesApplyTO)
    case besApplyFundSelection(transferObject: BesApplyTO)
    case besApplyCombinedFundSelection(transferObject: BesApplyTO)
    case besApplyFundDistribution(transferObject: BesApplyTO)
    case besApplyRiskSurvey(transferObject: BesApplyTO)
    case besApplyRiskSurveyResult(transferObject: BesApplyTO)
    case besApplySelectFundPage(transferObject: BesApplyTO)
    case besRiskSurvey(transferObject: BesApplyTO)
    case besApplyEstimatedPensionSavings
    case besApplyFundReturnInfo(fundMonthlyReturn: BesApplyMonthlyReturn, fundCode: String? = nil, fundName: String? = nil, title: String)
}
