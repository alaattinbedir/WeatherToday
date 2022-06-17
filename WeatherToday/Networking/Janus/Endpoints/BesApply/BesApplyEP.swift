//
//  BesApplyEP.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

class BesApplyEP: JanusTransaction, Endpoint, MappableEndpointExecuter, Encodable,
    ObservableNetworkActivity {
    typealias SuccessType = ConfirmResponse
    typealias ErrorType = ErrorMessage
    let path: String = "/bes/purchase-request"
    let method: HTTPMethodEnum = .post

    let token: String?
    let eTag: String?
    let otp: String?
    let approvedContracts: [String]?
    let participationAmount: Double?
    let productName: String?
    let sourceAccountId: String
    let creditCardGuid: String?
    let hasAlternativePayment: Bool?
    let productCode: String?
    let paymentElement: Int?
    let fundMix: BesApplyFundDistribution?
    let funds: [BesFund]?

    init(token: String? = nil,
         eTag: String? = nil,
         otp: String? = nil,
         approvedContracts: [String]? = nil,
         participationAmount: Double? = nil,
         productName: String? = "",
         sourceAccountId: String = "",
         creditCardGuid: String? = "",
         hasAlternativePayment: Bool? = false,
         productCode: String? = "",
         paymentElement: Int? = 0,
         fundMix: BesApplyFundDistribution? = nil,
         funds: [BesFund]? = nil) {
        self.token = token
        self.eTag = eTag
        self.otp = otp
        self.approvedContracts = approvedContracts
        self.participationAmount = participationAmount
        self.productName = productName
        self.sourceAccountId = sourceAccountId
        self.creditCardGuid = creditCardGuid
        self.hasAlternativePayment = hasAlternativePayment
        self.productCode = productCode
        self.paymentElement = paymentElement
        self.fundMix = fundMix
        self.funds = funds
    }

    enum CodingKeys: String, CodingKey {
        case token
        case eTag
        case otp
        case approvedContracts
        case participationAmount
        case productName
        case sourceAccountId
        case creditCardGuid
        case hasAlternativePayment
        case productCode
        case paymentElement
        case fundMix
        case funds
    }
}
