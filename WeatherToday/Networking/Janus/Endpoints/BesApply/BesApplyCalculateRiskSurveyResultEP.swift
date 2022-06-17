//
//  BesApplyCalculateRiskSurveyResultEP.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
class BesApplyCalculateRiskSurveyResultEP: Endpoint, MappableEndpointExecuter, ObservableNetworkActivity, Encodable {
    typealias SuccessType = BesApplyRiskSurveyResultResponse
    typealias ErrorType = ErrorMessage

    let path: String = "/bes/send-risk-survey-result"
    let method: HTTPMethodEnum = .post

    let productCode: String?
    let questionsAndAnswers: [BesApplySurveyAllAnswer]?

    init(productCode: String?, questionsAndAnswers: [BesApplySurveyAllAnswer]?) {
        self.productCode = productCode
        self.questionsAndAnswers = questionsAndAnswers
    }

    enum CodingKeys: String, CodingKey {
        case productCode
        case questionsAndAnswers
    }
}
