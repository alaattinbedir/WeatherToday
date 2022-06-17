//
//  BesApplyRiskSurveyResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

import ObjectMapper

class BesApplyRiskSurveyResponse: Mappable {
    var surveyQuestions: [BesApplySurveyQuestion] = []

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        surveyQuestions <- map["surveyQuestions"]
    }
}

class BesApplySurveyQuestion: Mappable {
    var id: Int?
    var order: Int?
    var text: String?
    var answers: [BesApplySurveyAnswer] = []

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        id <- map["id"]
        order <- map["order"]
        answers <- map["answers"]
        text <- map["text"]
    }
}

class BesApplySurveyAnswer: Mappable {
    var id: Int?
    var mark = ""
    var text = ""
    var isDefaultAnswer = false
    var isSelected = false

    init() {
        // Empty function body
    }

    required init?(map _: Map) {
        // Empty function body
    }

    func mapping(map: Map) {
        id <- map["id"]
        mark <- map["mark"]
        text <- map["text"]
        isDefaultAnswer <- map["isDefaultAnswer"]
    }
}

class BesApplySurveyAllAnswer: Encodable {
    var questionId: Int?
    var answerId: Int?

    init() {
        // Empty function body
    }

    init(questionId: Int?) {
        self.questionId = questionId
    }

    required init?(map _: Map) {
        // Empty function body
    }
}
