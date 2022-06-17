//
//  AuthenticateViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import Foundation
import ReactiveKit

enum AuthenticateViewState: ViewState {
    case nextScreen(CreateUserViewModelData)
    case noQuestion
}

class AuthenticateViewModel: BaseViewModel {
    var authenticationAPI: AuthenticationAPI
    var viewData: CreateUserViewModelData?
    var cardPass = Observable<String?>(nil)
    var isCardPassValid = Observable<Bool?>(nil)
    var securityQuestion = Observable<String?>(nil)
    var securityQuestionAnswer = Observable<String?>(nil)
    var isValid = Observable<Bool>(false)
    var isCardPassFieldActive = Observable<Bool>(true)
    var isQuestionFieldActive = Observable<Bool>(true)
    var type = Observable<CreateType>(.user)

    required convenience init() {
        self.init(api: AuthenticationAPI())
    }

    init(api: AuthenticationAPI) {
        authenticationAPI = api
    }

    func pageOpened(data: ViewModelData?) {
        guard let data = data as? CreateUserViewModelData else { return }
        type.value = data.createType
        cardPass.map {
            if $0 == nil || $0 == "" {
                self.isQuestionFieldActive.value = true
                return false
            }
            self.isQuestionFieldActive.value = false
            return $0?.count == 4
        }.bind(to: isValid)
        securityQuestionAnswer.map {
            if $0 == nil || $0 == "" {
                self.isCardPassFieldActive.value = true
                return false
            }
            self.isCardPassFieldActive.value = false
            return true
        }.bind(to: isValid)

        if let question = data.userIdentifyResponse.question {
            securityQuestion.value = question
        } else {
            state.send(AuthenticateViewState.noQuestion)
        }
    }

    func continueButtonTapped() {
        if cardPass.value == "" {
            cardPass.value = nil
        }
        let password = cardPass.value?.encrypt()
        do {
            let request = CreateUserIdentityRequest(securityQuestionAnswer: securityQuestionAnswer.value?.encrypt(),
                                                    cardPassword: password)
            authenticationAPI.createUserAuthenticate(isCreateUser: viewData?.createType == .user,
                                                     isCardNumber: password?.isEmpty ?? true,
                                                     params: request.toDict(),
                                                     succeed: parseResponse,
                                                     failed: handleFailure)
            request.clearData()
        }
    }

    func parseResponse(response: UserAuthenticateResponse) {
        guard let data = viewData else { return }
        data.userAuthenticateResponse = response
        state.send(AuthenticateViewState.nextScreen(data))
    }
}
