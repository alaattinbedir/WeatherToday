//
//  CardSelectionViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation

enum CardSelectionViewState: ViewState {
    case exit
    case back
}

class CardSelectionViewModelData: ViewModelData {
    var cards: [CardDetail] = []
    var selectedType: CardType?
    var handler: ((CardDetail?) -> Void)?
    var handlerBackButton: (() -> Void)?
    var willSortCards: Bool? = true

    init(cards: [CardDetail],
         selectedType: CardType,
         handler: ((CardDetail?) -> Void)?,
         handlerBackButton: (() -> Void)? = nil,
         willSortCards: Bool? = true) {
        self.cards = cards
        self.selectedType = selectedType
        self.handler = handler
        self.handlerBackButton = handlerBackButton
        self.willSortCards = willSortCards
    }
}

class CardSelectionMetaData {
    var isCollapsed = true
    var cardType: CardType = .credit
    var numOfCards = 0

    init(isCollapsed: Bool, cardType: CardType, numOfCards: Int) {
        self.isCollapsed = isCollapsed
        self.cardType = cardType
        self.numOfCards = numOfCards
    }
}

class CardSelectionViewModel: BaseViewModel {
    var cards: [CardDetail] = []
    var cardsArr = MutableObservableArray2D(Array2D<CardSelectionMetaData, CardDetail>())
    var handler: ((CardDetail?) -> Void)?
    var handlerBackButton: (() -> Void)?
    var selectedCardsIndexPath = Observable<IndexPath?>(nil)
    var selectedCard: CardDetail?
    var selectedCardType: CardType?
    var willSortCards: Bool = true

    required init() {
        super.init()
        bind()
    }

    private func bind() {
        selectedCardsIndexPath.observeNext { [weak self] indexPath in
            guard let indexPath = indexPath else { return }
            self?.cardSelected(with: indexPath)
        }.dispose(in: bag)
    }

    func pageOpened() {
        if willSortCards {
            let groupedCards = cards
                .grouped { $0.cardType }
                .map { (CardSelectionMetaData(isCollapsed: $0.key != selectedCardType,
                                              cardType: $0.key,
                                              numOfCards: $0.value.count),
                        $0.value.sorted { $0.cardType.rawValue < $1.cardType.rawValue })
                }.sorted { $0.0.cardType.rawValue < $1.0.cardType.rawValue }
            cardsArr.replace(with: Array2D<CardSelectionMetaData, CardDetail>(sectionsWithItems: groupedCards))
        } else {
            let groupedCards = cards
                .grouped { $0.cardType }
                .map { (CardSelectionMetaData(isCollapsed: $0.key != selectedCardType,
                                              cardType: $0.key,
                                              numOfCards: $0.value.count),
                        $0.value)
                }.sorted { $0.0.cardType < $1.0.cardType }
            cardsArr.replace(with: Array2D<CardSelectionMetaData, CardDetail>(sectionsWithItems: groupedCards))
        }
    }

    private func cardSelected(with selectedIndexPath: IndexPath) {
        selectedCard = cardsArr.collection.item(at: selectedIndexPath)
        state.send(CardSelectionViewState.exit)
    }

    func backButtonPressed() {
        state.send(CardSelectionViewState.back)
    }
}
