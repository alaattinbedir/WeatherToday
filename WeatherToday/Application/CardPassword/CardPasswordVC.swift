//
//  CardPasswordVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import IQKeyboardManagerSwift
import ReactiveKit
import UIKit
import SnapKit
import EasyTipView

class CardPasswordVC: BaseCardsOpsVC<CardPasswordViewModel> {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tfPin: PinFormField! {
        didSet {
            tfPin.textField.keyboardType = .numberPad
        }
    }

    @IBOutlet var tfPinRepeat: PinFormField! {
        didSet {
            tfPinRepeat.textField.keyboardType = .numberPad
        }
    }

    @IBOutlet var cardPicker: CardPickerView!
    @IBOutlet var viewWarningInfo: WarningInfoAlertView!
    @IBOutlet var btnContinue: FormButton!
    @IBOutlet var btnCvvInfo: UIButton!
    @IBOutlet var tfCvv: PinFormField! {
        didSet {
            tfCvv.textField.keyboardType = .numberPad
        }
    }

    @IBOutlet var lblHeaderCvv: UILabel!

    @IBOutlet var cvvContainerStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data as? CardOPSViewModelData {
            viewModel.guid = data.guid~
        }
        SessionKeeper.shared.eventPageName = .changeCardPassword
        AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                         eventAction: "kart_sifresi_degistir_1")
        showWarningInfo(type: .warning,
                        textList: [ResourceKey.cardPasswordInformationText.value],
                        view: viewWarningInfo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.pageOpened()
        pageTitle.value = ResourceKey.cardPasswordHeader.value
        pageStep.value = "1/2"
    }

    override func bind() {
        super.bind()
        viewModel.card.dropFirst(1).observeNext { [weak self] card in
            guard let self = self else { return }
            let cardPickerItem = self.viewModel.selectedCard?.pickerItem
            self.viewModel.cvvActive.value = (self.viewModel.selectedCard?.isPrintBlocked)~
            self.cvvContainerStackView.isHidden = !self.viewModel.cvvActive.value

            cardPickerItem?.isButtonEnabled = self.viewModel.cards.count != 1
            self.cardPicker.lblTitle.resource = .cardPasswordSelectedCreditCard
            self.cardPicker.item = cardPickerItem
            if card == nil {
                self.showNoCardView()
            }
        }.dispose(in: bag)
        cardPicker.btnSelect.reactive.tap.bind(to: self) { $0.viewModel.cardPickerTapped() }.dispose(in: bag)

        btnCvvInfo.reactive.tap.bind(to: self) { [weak self] _, _ in
            guard let self = self else { return }
            EasyTipView.showMessage(text: ResourceKey.cardPasswordCvvInfo.value,
                                    view: self.btnCvvInfo,
                                    desiredButton: self.btnCvvInfo)
        }.dispose(in: bag)

        viewModel.cvv.bidirectionalBind(to: tfCvv.text).dispose(in: bag)
        viewModel.pin.bidirectionalBind(to: tfPin.text).dispose(in: bag)
        viewModel.pinRepeat.bidirectionalBind(to: tfPinRepeat.text).dispose(in: bag)
        viewModel.isValid.map { $0 }.bind(to: btnContinue.reactive.isEnabled).dispose(in: bag)
        viewModel.isValidPin.bind(to: tfPinRepeat.reactive.isUserInteractionEnabled).dispose(in: bag)
        btnContinue.reactive.tap.bind(to: self) { $0.viewModel.continueButtonPressed() }.dispose(in: bag)
        bindCvvFormField()
        bindPinFormField()
    }

    private func bindCvvFormField() {
        tfCvv.reactive.editingChanged.observeNext { [weak self] in
            guard let cvv = self?.tfCvv.text.value else { return }
            if cvv.isEmpty {
                self?.tfCvv.clearError()
            }
        }.dispose(in: bag)
        tfCvv.reactive.editingEnded.observeNext { [weak self] in
            guard let cvv = self?.tfCvv.text.value else { return }
            guard let result = self?.viewModel.cvvValidator.validate(cvv) else { return }
            switch result {
            case .succeeded:
                self?.tfCvv.clearError()
            case .empty:
                self?.tfCvv.showError(ResourceKey.cardPasswordCvvWarning.value)
            case .invalidCvv:
                self?.tfCvv.showError(ResourceKey.cardPasswordCvvWarning.value)
            }
        }.dispose(in: bag)
    }

    private func bindPinFormField() {
        tfPinRepeat.reactive.editingEnded.observeNext { [weak self] in
            if self?.tfPinRepeat.text.value?.count == 4,
               self?.viewModel.pin.value != self?.viewModel.pinRepeat.value {
                self?.tfPinRepeat.showError(ResourceKey.cardPasswordInvalidPasswordWarning.value)
            } else {
                self?.tfPinRepeat.clearError()
            }
        }.dispose(in: bag)
        tfPin.reactive.editingChanged.observeNext { [weak self] in
            guard let pin = self?.tfPin.text.value else { return }
            if pin.isEmpty {
                self?.tfPin.clearError()
            }
        }.dispose(in: bag)
        tfPin.reactive.editingEnded.observeNext { [weak self] in
            guard let pin = self?.tfPin.text.value else { return }
            guard let result = self?.viewModel.pinValidator.validate(pin) else { return }
            switch result {
            case .allEqual:
                self?.tfPin.showError(ResourceKey.cardPasswordRuleThreePasswordWarningText.value)
            case .consecutive:
                self?.tfPin.showError(ResourceKey.cardPasswordSequentPasswordWarningText.value)
            case .iterant:
                self?.tfPin.showError(ResourceKey.cardPasswordIterantPasswordWarningText.value)
            case .symmetric:
                self?.tfPin.showError(ResourceKey.cardPasswordSymmetricPasswordWarningText.value)
            case .empty:
                self?.tfPin.clearError()
            case .maxLengthLess:
                self?.tfPin.showError(ResourceKey.cardPasswordMinPasswordWarningText.value)
            case .invalidPrefix:
                self?.tfPin.showError(ResourceKey.cardPasswordRuleTwoPasswordWarningText.value)
            case .succeeded:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self?.tfPinRepeat.becomeFirstResponder()
                }
                self?.tfPin.clearError()
            }
        }.dispose(in: bag)
        tfPinRepeat.reactive.editingEnded.observeNext { [weak self] in
            guard let pin = self?.tfPinRepeat.text.value else { return }
            guard let result = self?.viewModel.pinValidator.validate(pin) else { return }
            if result == .empty {
                self?.tfPinRepeat.clearError()
            }
        }.dispose(in: bag)
    }

    override func onAlertButtonPressed(_ code: Alert?, buttonIdentifier: AlertButtonIdentifier) {
        switch (code, buttonIdentifier) {
        case (.checkPinError?, .ok):
            break
        default:
            super.onAlertButtonPressed(code, buttonIdentifier: buttonIdentifier)
        }
    }

    override func onStateChanged(_ state: ViewState) {
        super.onStateChanged(state)
        guard let state = state as? CardPasswordViewState else { return }
        switch state {
        case let .openSummary(viewModelData):
            NavigationRouter.push(from: self,
                                  to: CardOpsSummaryVC(),
                                  data: viewModelData)
        case .clearPinError:
            tfPinRepeat.clearError()
        case let .cardPickerTapped(data):
            NavigationRouter.present(from: getRootVC(),
                                     to: CardSelectionVC(),
                                     presentationStyle: .overCurrentContext,
                                     data: data)
        case .updateCardPickerItem:
            cardPicker.item = viewModel.selectedCard?.pickerItem
            viewModel.cvvActive.value = (viewModel.selectedCard?.isPrintBlocked)~
            cvvContainerStackView.isHidden = !viewModel.cvvActive.value
            tfPin.clearError()
            tfPinRepeat.clearError()
        }
    }

    override func setResources() {
        tfPin.titleResource = .cardPasswordNewPin
        tfPinRepeat.titleResource = .cardPasswordNewPinAgain
        btnContinue.resource = .generalButtonContinue
        lblHeaderCvv.resource = .cardPasswordCvv
    }

    override func setAccessibilityIdentifiers() {
        tfPin.accessibilityKey = .pin
        tfPinRepeat.accessibilityKey = .pinRepeat
        btnContinue.accessibilityKey = .continueButton
        lblHeaderCvv.accessibilityKey = .cvvTitle
        tfCvv.accessibilityKey = .cvv
        btnCvvInfo.accessibilityKey = .cvvInfo
    }
}
