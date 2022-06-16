//
//  BaseCardsOpsViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//
import Foundation
import UIKit

class BaseCardOpsViewModel: BaseViewModel {
    var cardsAPI: CardsAPI
    var guid: String = ""
    var guid2: String = ""
    var provisionNumber: String = ""
    var shadowCardNumber: String = ""

    private var pCards: [CardDetail] = []
    private var pCards2: [CardDetail] = []
    var cards: [CardDetail] {
        get { return pCards }
        set {
            pCards = newValue
            if guid.isEmpty {
                guard let favoriteCardNumber = PersistentKeeper.shared.favoriteCardMaskNumber else {
                    selectedCardIndex = 0
                    selectedCard = pCards.isEmpty ? nil : pCards[0]
                    return
                }
                if let favoriCardIndex = cards
                    .firstIndex(where: { $0.maskedCardNumber == favoriteCardNumber }) {
                    selectedCardIndex = favoriCardIndex
                    selectedCard = pCards[favoriCardIndex]
                } else {
                    selectedCardIndex = 0
                    selectedCard = pCards.isEmpty ? nil : pCards[0]
                }
            }
        }
    }

    var cards2: [CardDetail] {
        get { return pCards2 }
        set {
            pCards2 = newValue
            if guid2.isEmpty {
                guard let favoriteCardNumber = PersistentKeeper.shared.favoriteCardMaskNumber else {
                    selectedCardIndex2 = 0
                    selectedCard2 = pCards2.isEmpty ? nil : pCards2[0]
                    return
                }
                if let favoriCardIndex = cards2
                    .firstIndex(where: { $0.maskedCardNumber == favoriteCardNumber }) {
                    selectedCardIndex2 = favoriCardIndex
                    selectedCard2 = pCards2[favoriCardIndex]
                } else {
                    selectedCardIndex2 = 0
                    selectedCard2 = pCards2.isEmpty ? nil : pCards2[0]
                }
            }
        }
    }

    var accounts: [Account] = []
    var cardDetail: [KeyValuePair] = []
    var confirmationResponse: ConfirmResponse?

    private var pSelectedCardIndex = -1
    private var pSelectedCardIndex2 = -1

    var selectedCardIndex: Int {
        get { return pSelectedCardIndex }
        set {
            if pSelectedCardIndex != newValue {
                pSelectedCardIndex = newValue
                if pSelectedCardIndex > -1, pSelectedCardIndex < cards.count {
                    selectedCard = cards[pSelectedCardIndex]
                }
            }
        }
    }

    var selectedCardIndex2: Int {
        get { return pSelectedCardIndex2 }
        set {
            if pSelectedCardIndex2 != newValue {
                pSelectedCardIndex2 = newValue
                if pSelectedCardIndex2 > -1, pSelectedCardIndex2 < cards2.count {
                    selectedCard2 = cards2[pSelectedCardIndex2]
                }
            }
        }
    }

    private var pSelectedAccountIndex = -1

    var selectedAccountIndex: Int {
        get { return pSelectedAccountIndex }
        set {
            if pSelectedAccountIndex != newValue {
                pSelectedAccountIndex = newValue
                if pSelectedAccountIndex > -1, pSelectedAccountIndex < accounts.count {
                    selectedAccount = accounts[pSelectedAccountIndex]
                }
            }
        }
    }

    var selectedCard: CardDetail? {
        didSet {
            if let selectedCard = selectedCard, let cardIndex = cards.firstIndex(where: { $0.guid == selectedCard.guid }) {
                pSelectedCardIndex = cardIndex
                guid = selectedCard.guid
                for card in cards {
                    card.isSelected = false
                }
                cards[pSelectedCardIndex].isSelected = true
            }
        }
    }

    var selectedCard2: CardDetail? {
        didSet {
            if let selectedCard = selectedCard2, let cardIndex = cards2.firstIndex(where: { $0.guid == selectedCard.guid }) {
                pSelectedCardIndex2 = cardIndex
                guid2 = selectedCard.guid
                for card in cards2 {
                    card.isSelected = false
                }
                cards2[pSelectedCardIndex2].isSelected = true
            }
        }
    }

    var selectedAccount: Account? {
        didSet {
            if let selectedAccount = selectedAccount,
               let accountIndex = accounts.firstIndex(where: { $0.number == selectedAccount.number }) {
                pSelectedAccountIndex = accountIndex
                for account in accounts {
                    account.isSelected = false
                }
                accounts[pSelectedAccountIndex].isSelected = true
            }
        }
    }

    init(api: CardsAPI) {
        cardsAPI = api
        super.init()
    }

    required convenience init() {
        self.init(api: CardsAPI())
    }
}
