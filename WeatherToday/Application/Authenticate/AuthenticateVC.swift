//
//  AuthenticateVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

import UIKit

class AuthenticateVC: BaseCreateUserVC<AuthenticateViewModel> {
    @IBOutlet var lblAuthenticateHeader: UILabel!
    @IBOutlet var tfCardPassword: TextFormField!
    @IBOutlet var lblSecurityQuestion: UILabel!
    @IBOutlet var tfSecurityQuestionAnswer: TextFormField!
    @IBOutlet var lblCardPassword: UILabel!
    @IBOutlet var btnContinue: FormButton!
    @IBOutlet var viewWarningInfo: WarningInfoAlertView! {
        didSet { viewWarningInfo.isHidden = false }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.pageOpened(data: data)
        configureFormFieldUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageTitle.value = viewModel.viewData?.createType == .user
            ? ResourceKey.loginCreateUser.value
            : ResourceKey.passwordCreatePassword.value
        pageStep.value = "2/4"
        if viewModel.viewData?.createType == .user {
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.createUser.rawValue,
                                             eventAction: "kullanici_olusturma_2")
        }
    }

    override func bind() {
        super.bind()
        if let data = data as? CreateUserViewModelData {
            viewModel.viewData = data
        }
        btnContinue.reactive.tap.bind(to: self) { $0.viewModel.continueButtonTapped() }.dispose(in: bag)
        viewModel.cardPass.bidirectionalBind(to: tfCardPassword.text).dispose(in: bag)
        viewModel.securityQuestion.bind(to: tfSecurityQuestionAnswer.lblTitle).dispose(in: bag)
        viewModel.securityQuestion.map { !($0 ?? "").isEmpty }
            .bind(to: viewWarningInfo.reactive.isHidden).dispose(in: bag)
        viewModel.isCardPassValid.observeNext { value in
            switch value {
            case true:
                self.tfCardPassword.clearError()
            case false:
                self.tfCardPassword.showError(ResourceKey.passwordWrongPasswordMessage.value)
            default: break
            }
        }.dispose(in: bag)
        viewModel.isCardPassFieldActive.map { $0 }
            .bind(to: tfCardPassword.textField.reactive.isEnabled).dispose(in: bag)
        viewModel.isQuestionFieldActive.map { $0 }
            .bind(to: tfSecurityQuestionAnswer.textField.reactive.isEnabled).dispose(in: bag)
        viewModel.securityQuestionAnswer.bidirectionalBind(to: tfSecurityQuestionAnswer.text).dispose(in: bag)
        viewModel.isValid.bind(to: btnContinue.reactive.isEnabled).dispose(in: bag)
        viewModel.type.map { $0 == .user }.bind(to: tfSecurityQuestionAnswer.reactive.isHidden).dispose(in: bag)
        viewModel.type.map { $0 == .user }.bind(to: viewWarningInfo.reactive.isHidden).dispose(in: bag)
    }

    override func onStateChanged(_ state: ViewState) {
        super.onStateChanged(state)
        guard let state = state as? AuthenticateViewState else { return }
        switch state {
        case let .nextScreen(data):
            NavigationRouter.push(from: self,
                                  to: OTPVerifyVC(),
                                  navigationOption: .popAll,
                                  data: data)
        case .noQuestion:
            tfSecurityQuestionAnswer.isHidden = true
            viewWarningInfo.isHidden = false
        }
    }

    private func configureFormFieldUI() {
        tfCardPassword.textField.keyboardType = .numberPad
        tfCardPassword.maxLength = 4
        tfCardPassword.textField.isSecureTextEntry = true
        tfSecurityQuestionAnswer.textField.isSecureTextEntry = true
    }

    override func onAlertButtonPressed(_ code: Alert?, buttonIdentifier: AlertButtonIdentifier) {
        switch buttonIdentifier {
        case .ok:
            break
        default:
            super.onAlertButtonPressed(code, buttonIdentifier: buttonIdentifier)
        }
    }

    override func setResources() {
        if let data = data as? CreateUserViewModelData {
            lblAuthenticateHeader.resource = data.createType == .user ? .createUserInfoMessage : .passwordInfoMessage
        }
        lblCardPassword.resource = .passwordCardPassword
        btnContinue.resource = .generalButtonContinue
        tfSecurityQuestionAnswer.placeholderResource = .magicQuestionDefinedQuestionsAnswerHint
        let label = UILabel.createModel1(text: ResourceKey.passwordMagicQuestionMessage.value,
                                         color: .brownishGreyTwo)
        label.accessibilityKey = .warning
        viewWarningInfo.configureView(type: .info, labels: [label])
    }

    override func setAccessibilityIdentifiers() {
        lblAuthenticateHeader.accessibilityKey = .label
        lblSecurityQuestion.accessibilityKey = .label1
        lblCardPassword.accessibilityKey = .label2
        tfSecurityQuestionAnswer.accessibilityKey = .alertIcon
        tfCardPassword.accessibilityKey = .amount
        btnContinue.accessibilityKey = .button1
    }
}
