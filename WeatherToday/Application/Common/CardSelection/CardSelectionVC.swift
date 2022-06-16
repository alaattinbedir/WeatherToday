//
//  CardSelectionVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import UIKit

class CardSelectionVC: BaseChildVC<CardSelectionViewModel> {
    @IBOutlet var viewBack: UIView!
    @IBOutlet var lblBack: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(CardsSelectionCell.self)
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data as? CardSelectionViewModelData {
            viewModel.cards = data.cards
            viewModel.handler = data.handler
            viewModel.handlerBackButton = data.handlerBackButton
            viewModel.selectedCardType = data.selectedType
            viewModel.willSortCards = data.willSortCards~
        }
    }

    override func bind() {
        super.bind()
        viewBack.reactive.tapGesture().observeNext { _ in
            self.viewModel.backButtonPressed()
        }.dispose(in: bag)
        bindTableView()
    }

    private func bindTableView() {
        viewModel.cardsArr.bind(to: tableView, using: CardSelectionBinder()).dispose(in: bag)
        tableView.reactive.selectedRowIndexPath.bind(to: viewModel.selectedCardsIndexPath).dispose(in: bag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.pageOpened()
    }

    override func onStateChanged(_ state: ViewState) {
        super.onStateChanged(state)
        guard let state = state as? CardSelectionViewState else { return }
        switch state {
        case .back:
            NavigationRouter.dismiss(viewController: self) {
                self.viewModel.handlerBackButton?()
            }
        case .exit:
            NavigationRouter.dismiss(viewController: self) {
                self.viewModel.handler?(self.viewModel.selectedCard)
            }
        }
    }

    override func setResources() {
        lblBack.resource = .back
        lblTitle.resource = .cards
    }

    override func setAccessibilityIdentifiers() {
        lblBack.accessibilityKey = .back
        lblTitle.accessibilityKey = .fullNameValue
    }
}
