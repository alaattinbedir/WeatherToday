//
//  CardsPageMetaData.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import Foundation

enum CardsPageViewState: ViewState {
    case noCardFound
    case showCards
    case createVirtualCard
    case createExtendCard
    case openCard(ViewModelData)
    case openCardApplication
    case createDebitCard
    case createVirtualDebitCard
    case createExtendedDebitCard
}

class CardsPageMetaData {
    var cardType: CardType = .credit
    var showApplyCardOnHeader = false
    var handler: (() -> Void)?

    init(cardType: CardType,
         showApplyCardOnHeader: Bool,
         handler: (() -> Void)?) {
        self.cardType = cardType
        self.showApplyCardOnHeader = showApplyCardOnHeader
        self.handler = handler
    }
}

class CardsPageViewModel: BaseViewModel {
    let cardsAPI: CardsAPI
    var cards = MutableObservableArray2D(Array2D<CardsPageMetaData, Card>())
    var personalCards = Array2D<CardsPageMetaData, Card>()
    var businessCards = Array2D<CardsPageMetaData, Card>()
    var selectedIndexForRow = Observable<IndexPath?>(nil)
    var haveCorporateCards = false
    var havePersonalCards = false
    var tabHeaders = MutableObservableArray<ResourceKey>()
    var selectedTabIndex = Observable<Int>(0)
    var welcomeCards: [(Int, Card)] = []
    private var cardsResponse: CardsResponse?

    required convenience init() {
        self.init(api: CardsAPI())
    }

    init(api: CardsAPI) {
        cardsAPI = api
        super.init()
        bind()
    }

    private func bind() {
        selectedIndexForRow.observeNext { [weak self] _ in
            self?.handleCardSelected()
        }.dispose(in: bag)
    }

    func pageOpened() {
        getCards()
        tabHeaders.replace(with: [.cardDetailPersonalCard, .cardDetailCorporateCard])
    }

    func getCards() {
        cardsAPI.getCards(succeed: parseGetCards,
                          areCancelledCardsIncluded: false,
                          isBusinessCardInclude: true,
                          isDebitCardInclude: true,
                          failed: handleFailure)
    }

    private func parseGetCards(_ response: CardsResponse) {
        cardsResponse = response
        welcomeCards = []
        for i in 0 ..< response.creditCardListResponse.cards.count {
            welcomeCards.append((response.creditCardListResponse.groupOrder,
                                 response.creditCardListResponse.cards[i]))
        }
        for i in 0 ..< response.extendCardListResponse.cards.count {
            welcomeCards.append((response.extendCardListResponse.groupOrder,
                                 response.extendCardListResponse.cards[i]))
        }
        for i in 0 ..< response.virtualCardListResponse.cards.count {
            welcomeCards.append((response.virtualCardListResponse.groupOrder,
                                 response.virtualCardListResponse.cards[i]))
        }
        for i in 0 ..< response.debitCardListResponse.cards.count {
            welcomeCards.append((response.debitCardListResponse.groupOrder,
                                 response.debitCardListResponse.cards[i]))
        }
        for i in 0 ..< response.businessCardListResponse.cards.count {
            welcomeCards.append((response.businessCardListResponse.groupOrder,
                                 response.businessCardListResponse.cards[i]))
        }
        for i in 0 ..< response.producerCardListResponse.cards.count {
            welcomeCards.append((response.producerCardListResponse.groupOrder,
                                 response.producerCardListResponse.cards[i]))
        }
        for i in 0 ..< response.extendDebitCardListResponse.cards.count {
            welcomeCards.append((response.extendDebitCardListResponse.groupOrder,
                                 response.extendDebitCardListResponse.cards[i]))
        }
        for i in 0 ..< response.virtualDebitCardListResponse.cards.count {
            welcomeCards.append((response.virtualDebitCardListResponse.groupOrder,
                                 response.virtualDebitCardListResponse.cards[i]))
        }
        for i in 0 ..< response.bonussBussinesCardListResponse.cards.count {
            welcomeCards.append((response.bonussBussinesCardListResponse.groupOrder,
                                 response.bonussBussinesCardListResponse.cards[i]))
        }
        for i in 0 ..< response.bonussBussinesExtendedCardListResponse.cards.count {
            welcomeCards.append((response.bonussBussinesExtendedCardListResponse.groupOrder,
                                 response.bonussBussinesExtendedCardListResponse.cards[i]))
        }
        for i in 0 ..< response.businessExtendCardListResponse.cards.count {
            welcomeCards.append((response.businessExtendCardListResponse.groupOrder,
                                 response.businessExtendCardListResponse.cards[i]))
        }
        welcomeCards = welcomeCards.sorted { $0.0 < $1.0 }
        parseCards(response: response)
    }

    func parseCards(response: CardsResponse) {
        personalCards = Array2D<CardsPageMetaData, Card>(sectionsWithItems:
            createPersonalCardsArray(response: response))
        businessCards = Array2D<CardsPageMetaData, Card>(sectionsWithItems:
            createBusinessCardsArray(response: response))
        checkCardsAndGoToState()
    }

    private func createBusinessCardsArray(response: CardsResponse) -> [(CardsPageMetaData, [Card])] {
        var cards: [(CardsPageMetaData, [Card])] = []
        let businessCards = (CardsPageMetaData(cardType: CardType.business,
                                               showApplyCardOnHeader: false,
                                               handler: nil),
                             response.businessCardListResponse.cards)
        let bonussBussinesCards = (CardsPageMetaData(cardType: CardType.bonusBusiness,
                                                     showApplyCardOnHeader: false,
                                                     handler: nil),
                                   response.bonussBussinesCardListResponse.cards)
        let bonusExtendCards = (CardsPageMetaData(cardType: CardType.businessExtend,
                                                  showApplyCardOnHeader: false,
                                                  handler: nil),
                                response.businessExtendCardListResponse.cards)
        let bonussBussinesExtendedCards = (CardsPageMetaData(cardType: CardType.bonusBusinessExtend,
                                                             showApplyCardOnHeader: false,
                                                             handler: nil),
                                           response.bonussBussinesExtendedCardListResponse.cards)
        let bonussBussinesVirtualCards = (CardsPageMetaData(cardType: CardType.bonusBusinessVirtual,
                                                            showApplyCardOnHeader: false,
                                                            handler: nil),
                                          response.bonussBussinesVirtualCardListResponse.cards)
        if !response.businessCardListResponse.cards.isEmpty {
            cards.append(businessCards)
        }
        if !response.businessExtendCardListResponse.cards.isEmpty {
            cards.append(bonusExtendCards)
        }
        if !response.bonussBussinesCardListResponse.cards.isEmpty {
            cards.append(bonussBussinesCards)
        }
        if !response.bonussBussinesExtendedCardListResponse.cards.isEmpty {
            cards.append(bonussBussinesExtendedCards)
        }
        if !response.bonussBussinesVirtualCardListResponse.cards.isEmpty {
            cards.append(bonussBussinesVirtualCards)
        }
        return cards
    }

    private func createPersonalCardsArray(response: CardsResponse) -> [(CardsPageMetaData, [Card])] {
        var result: [(CardsPageMetaData, [Card])] = []
        let creditCardList = getFavoriteCardFirst(cards: response.creditCardListResponse.cards)
        let creditCards = (CardsPageMetaData(cardType: CardType.credit,
                                             showApplyCardOnHeader: !creditCardList.isEmpty,
                                             handler: openCardApplicationPage),
                           creditCardList)
        result.append(creditCards)
        var showApplyCard = false
        if response.creditCardListResponse.cards.count !=
            response.virtualCardListResponse.cards.count,
            !response.virtualCardListResponse.cards.isEmpty {
            showApplyCard = true
        }
        let virtualCards = (CardsPageMetaData(cardType: CardType.virtual,
                                              showApplyCardOnHeader: showApplyCard,
                                              handler: handleAddVirtualCard),
                            response.virtualCardListResponse.cards)
        result.append(virtualCards)
        if !response.producerCardListResponse.cards.isEmpty {
            let producerCards = (CardsPageMetaData(cardType: CardType.producer,
                                                   showApplyCardOnHeader: false,
                                                   handler: nil),
                                 response.producerCardListResponse.cards)
            result.append(producerCards)
        }
        let extendCards = (CardsPageMetaData(cardType: CardType.extend,
                                             showApplyCardOnHeader: !response.extendCardListResponse.cards.isEmpty,
                                             handler: handleAddExtendCard),
                           response.extendCardListResponse.cards)
        result.append(extendCards)
        let debitCards = (CardsPageMetaData(cardType: CardType.debit,
                                            showApplyCardOnHeader: false,
                                            handler: handleCreateDebitCard),
                          response.debitCardListResponse.cards)
        result.append(debitCards)
        if !response.extendDebitCardListResponse.cards.isEmpty {
            let extendDebitCards = (CardsPageMetaData(cardType: CardType.extendedDebit,
                                                      showApplyCardOnHeader: false,
                                                      handler: nil),
                                    response.extendDebitCardListResponse.cards)
            result.append(extendDebitCards)
        }
        let virtualDebitCard = (CardsPageMetaData(cardType: CardType.virtualDebit,
                                                  showApplyCardOnHeader: false,
                                                  handler: handleAddVirtualDebitCard),
                                response.virtualDebitCardListResponse.cards)
        result.append(virtualDebitCard)
        return result
    }

    private func getFavoriteCardFirst(cards: [Card]) -> [Card] {
        var creditCardList = cards
        if let favoriteCardNumber = PersistentKeeper.shared.favoriteCardMaskNumber,
           let favoriteCardIndex = creditCardList
           .firstIndex(where: { $0.maskedCardNumber == favoriteCardNumber }) {
            let favoriteCard = creditCardList.remove(at: favoriteCardIndex)
            creditCardList.insert(favoriteCard, at: 0)
        }
        return creditCardList
    }

    private func checkCardsAndGoToState() {
        havePersonalCards = false
        for section in personalCards.sections
            where !section.items.isEmpty {
            havePersonalCards = true
        }
        haveCorporateCards = false
        for section in businessCards.sections
            where !section.items.isEmpty {
            haveCorporateCards = true
        }
        if !havePersonalCards, !haveCorporateCards {
            state.send(CardsPageViewState.noCardFound)
        } else {
            state.send(CardsPageViewState.showCards)
        }
    }

    func tabSelected(index: Int) {
        cards.replace(with: index == 0 ? personalCards : businessCards)
    }

    func handleAddVirtualCard() {
        state.send(CardsPageViewState.createVirtualCard)
    }

    func handleAddExtendCard() {
        state.send(CardsPageViewState.createExtendCard)
    }

    func handleCreateDebitCard() {
        state.send(CardsPageViewState.createDebitCard)
    }

    func handleAddVirtualDebitCard() {
        state.send(CardsPageViewState.createVirtualDebitCard)
    }

    private func handleCardSelected() {
        guard let cardIndex = selectedIndexForRow.value else { return }
        if cards.collection.numberOfItems(inSection: cardIndex.section) != 0 {
            let card = cards.collection.item(at: cardIndex)
            let modelData = CardDetailViewModelData(cards: welcomeCards.map { $0.1 },
                                                    guid: card.guid,
                                                    maskedCardNumber: "",
                                                    handler: cardDetailCloseHandler)
            state.send(CardsPageViewState.openCard(modelData))
        }
    }

    @objc
    private func cardDetailCloseHandler() {
        guard let cardsResponse = cardsResponse else { return }
        parseCards(response: cardsResponse)
    }

    func openCardApplicationPage() {
        state.send(CardsPageViewState.openCardApplication)
    }
}
