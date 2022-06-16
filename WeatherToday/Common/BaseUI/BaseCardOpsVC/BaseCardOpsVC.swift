//
//  BaseCardOpsVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit

class CardOPSViewModelData: ViewModelData {
    var guid: String?

    init(guid: String?) {
        self.guid = guid
    }
}

class BaseCardsOpsVC<T>: BaseChildVC<T> where T: BaseViewModel {
    override func onAlertButtonPressed(_ code: Alert?,
                                       buttonIdentifier: AlertButtonIdentifier) {
        super.onAlertButtonPressed(code, buttonIdentifier: buttonIdentifier)
        NavigationRouter.dismiss(viewController: self)
    }

    override func getRightBarButtonItems() -> [NavigationBarButton] {
        let data = NavigationBarButtonData(image: #imageLiteral(resourceName: "closeWhite")) { _ in
            NavigationRouter.dismiss()
        }
        return [.custom(data)]
    }

    override func getNavigationBarBgColor() -> UIColor {
        return .azureThree
    }

    override func getWillShowTitleAndStep() -> Bool {
        return true
    }

    func openCardSelection(cardSelectionViewModelData: CardSelectionViewModelData? = nil,
                           handler: ((CardDetail?) -> Void)? = nil) {
        var data: CardSelectionViewModelData?
        if let cardSelectionViewModelData = cardSelectionViewModelData {
            data = cardSelectionViewModelData
        } else if let cardOpsViewModel = viewModel as? BaseCardOpsViewModel {
            data = CardSelectionViewModelData(cards: cardOpsViewModel.cards,
                                              selectedType: cardOpsViewModel.selectedCard?.cardType ?? .credit,
                                              handler: handler)
        } else {
            print("No available CardSelectionViewModelData")
            return
        }
        NavigationRouter.present(from: getRootVC(),
                                 to: CardSelectionVC(),
                                 presentationStyle: .overCurrentContext,
                                 data: data)
    }
}
