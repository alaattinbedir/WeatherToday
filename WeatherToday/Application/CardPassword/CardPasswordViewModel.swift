//
//  CardPasswordViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation
import ReactiveKit

enum CardPasswordViewState: ViewState {
    case openSummary(CardOpsSummaryViewModelData)
    case clearPinError
    case cardPickerTapped(CardSelectionViewModelData)
    case updateCardPickerItem
}

class CardPasswordViewModel: BaseCardOpsViewModel {
    let cardsApi: CardsAPI
    var card = Observable<CardDetail?>(nil)
    var cvv = Observable<String?>(nil)
    var pin = Observable<String?>(nil)
    var pinRepeat = Observable<String?>(nil)
    var isValid = Observable<Bool>(false)
    var isValidCvv = Observable<Bool>(false)
    var isValidPin = Observable<Bool>(false)
    var isValidPinRepeat = Observable<Bool>(false)
    var pinValidator = PinValidator()
    var cvvValidator = CvvValidator()
    var cvvActive = Observable<Bool>(false)

    required convenience init() {
        self.init(cardsApi: CardsAPI())
    }

    init(cardsApi: CardsAPI) {
        self.cardsApi = cardsApi
        super.init(api: cardsApi)
        bind()
    }

    func bind() {
        pin.map { [weak self] pin in self?.pinValidator.validate(pin) == .succeeded }.bind(to: isValidPin).dispose(in: bag)
        pinRepeat.map { [weak self] pin in self?.pinValidator.validate(pin) == .succeeded }.bind(to: isValidPinRepeat).dispose(in: bag)
        cvv.map { [weak self] cvv in self?.cvvValidator.validate(cvv) == .succeeded }.bind(to: isValidCvv).dispose(in: bag)
        pin.observeNext { [weak self] pin in
            if pin~.isEmpty {
                self?.state.send(CardPasswordViewState.clearPinError)
                self?.pinRepeat.value = ""
            }
        }.dispose(in: bag)

        combineLatest(pin, pinRepeat, isValidPin, isValidPinRepeat, isValidCvv).map { $0 == $1 && $2 && $3 && ($4 || !self.cvvActive.value) }.bind(to: isValid)
    }

    func pageOpened() {
        getCards()
    }

    private func getCards() {
        cardsApi.getCardsWBBMainAndExtendCardFilter(lockScreen: true,
                                                    isBusinessCardInclude: true,
                                                    isDebitCardInclude: true,
                                                    isProducerCardInclude: true,
                                                    succeed: parseGetCards,
                                                    failed: handleFailure)
    }

    private func parseGetCards(_ response: WelcomeCardResponse) {
        cards = response.welcomeCards.filter { $0.cardType != .virtual && $0.cardType != .virtualDebit }
        selectedCardIndex = cards.firstIndex { $0.guid == guid }~
        card.value = selectedCard
    }

    private func checkCardPin() {
        guard let selectedCard = selectedCard else { return }
        do {
            if cvvActive.value {
                let request = ChangePinRequest(cardGuid: selectedCard.guid, newPin: (pin.value?.encrypt())~, cvv: (cvv.value?.encrypt())~)
                cardsApi.changeCardPinCvv(params: request.toDict(),
                                          succeed: parseCheckCardPin,
                                          failed: handleFailure)
                request.clearData()
            } else {
                let request = CheckPinRequest(cardGuid: selectedCard.guid, newPin: (pin.value?.encrypt())~)
                cardsApi.checkCardPin(params: request.toDict(),
                                      succeed: parseCheckCardPin,
                                      failed: handleFailure)
                request.clearData()
            }
        }
    }

    private func parseCheckCardPin(_: CardPasswordValidResponse) {
        guard let selectedCard = selectedCard else { return }
        let cardSummaryWidget = SummaryWidget.card(ResourceKey.virtualCardLimitUpdateCardInfo.value, selectedCard)
        let summary = KeyValuePair(key: ResourceKey.cardPasswordSummaryTransactionType.value,
                                   value: ResourceKey.cardPasswordHeader.value)
        let summaryObject = SummaryObject(title: ResourceKey.cardPasswordHeader.value,
                                          stepNumber: "2/2",
                                          description: ResourceKey.cardPasswordSummaryInfoText.value,
                                          summaries: [summary],
                                          widgets: [cardSummaryWidget],
                                          approveKey: "Summary.Button.ApproveCardPassword",
                                          requestDict: ["CardGuid": selectedCard.guid,
                                                        "NewPin": (pin.value?.encrypt())~],
                                          endPoint: Endpoints.changeCardPin)
        let viewModelData = CardOpsSummaryViewModelData(object: summaryObject)
        state.send(CardPasswordViewState.openSummary(viewModelData))
    }

    func continueButtonPressed() {
        checkCardPin()
    }

    func cardPickerTapped() {
        let data = CardSelectionViewModelData(cards: cards,
                                              selectedType: selectedCard?.cardType ?? .credit,
                                              handler: cardSelected(card:))
        state.send(CardPasswordViewState.cardPickerTapped(data))
    }

    func cardSelected(card: CardDetail?) {
        selectedCard = card
        pin.value = ""
        pinRepeat.value = ""
        state.send(CardPasswordViewState.updateCardPickerItem)
    }
}
