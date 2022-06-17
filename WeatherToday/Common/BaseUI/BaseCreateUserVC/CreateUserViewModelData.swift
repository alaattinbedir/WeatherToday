//
//  CreateUserViewModelData.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

enum CreateType {
    case user
    case password
    case changePassword
}

class CreateUserViewModelData: ViewModelData {
    var createType: CreateType
    var identificationNumber: String = ""
    var phoneNumber: String = ""
    var securityQuestionAnswer: String = ""
    var secret: String = ""
    var userIdentifyResponse: UserIdentifyResponse = UserIdentifyResponse()
    var userAuthenticateResponse: UserAuthenticateResponse = UserAuthenticateResponse()
    var userOTPVerifyResponse: UserVerifyResponse = UserVerifyResponse()

    init(createType: CreateType,
         identificationNumber: String = "",
         phoneNumber: String = "",
         securityQuestionAnswer: String = "",
         secret: String = "",
         userIdentifyResponse: UserIdentifyResponse = UserIdentifyResponse(),
         userAuthenticateResponse: UserAuthenticateResponse = UserAuthenticateResponse(),
         userOTPVerifyResponse: UserVerifyResponse = UserVerifyResponse()) {
        self.createType = createType
        self.identificationNumber = identificationNumber
        self.phoneNumber = phoneNumber
        self.securityQuestionAnswer = securityQuestionAnswer
        self.secret = secret
        self.userIdentifyResponse = userIdentifyResponse
        self.userAuthenticateResponse = userAuthenticateResponse
        self.userOTPVerifyResponse = userOTPVerifyResponse
    }
}
