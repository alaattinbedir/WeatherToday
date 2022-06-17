//
//  CardsPageVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import ReactiveKit
import SnapKit
import UIKit

class CardsPageVC: BaseChildVC<CardsPageViewModel> {
    @IBOutlet var lblViewTitle: UILabel!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(CardCell.self)
            tableView.register(NoCardCell.self)
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var noCardView: UIView!
    @IBOutlet var lblNoCardTitle: UILabel!
    @IBOutlet var lblNoCardSubtitle: UILabel!
    @IBOutlet var btnNoCard: FormButton!
    @IBOutlet var segmentedView: UIView!
    @IBOutlet var segmentedCollection: UICollectionView! {
        didSet {
            segmentedCollection.register(TabSelectionCell.self)
        }
    }

    override func bind() {
        super.bind()
        btnNoCard.reactive.tap.bind(to: self) { $0.viewModel.openCardApplicationPage() }.dispose(in: bag)
        viewModel.tabHeaders.bind(to: segmentedCollection) { tabs, indexPath, collectionView -> UICollectionViewCell in
            let cell = collectionView.dequeueCell(TabSelectionCell.self, forIndexPath: indexPath)
            self.viewModel.selectedTabIndex.observeNext { selectedTabIndex in
                cell.titleRes = tabs[indexPath.row]
                cell.font = UIFont(name: AppFont.bold, size: 16)
                if selectedTabIndex == indexPath.row {
                    cell.viewUnderline.backgroundColor = .lightPink
                    cell.lblTitle.textColor = .black
                } else {
                    cell.viewUnderline.backgroundColor = .clear
                    cell.lblTitle.textColor = .greyish
                }
            }.dispose(in: cell.bag)
            return cell
        }.dispose(in: bag)

        segmentedCollection.reactive.selectedItemIndexPath.map { $0.row }.bind(to: viewModel.selectedTabIndex)

        viewModel.selectedTabIndex.observeNext { [weak self] index in
            self?.viewModel.tabSelected(index: index)
        }.dispose(in: bag)

        viewModel.cards.bind(to: tableView, using: CardsPageBinder()).dispose(in: bag)
        viewModel.cards.observeNext { [weak self] cards in
            guard !cards.collection.sections.isEmpty else { return }
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                        at: .top,
                                        animated: true)
        }.dispose(in: bag)
        tableView.reactive.selectedRowIndexPath.bind(to: viewModel.selectedIndexForRow)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.pageOpened()
        stackView.isHidden = true
        SessionKeeper.shared.enteredFunnelFrom = "kartlar"
    }

    override func onStateChanged(_ state: ViewState) {
        super.onStateChanged(state)
        guard let state = state as? CardsPageViewState else { return }
        switch state {
        case .noCardFound:
            stackView.isHidden = false
            segmentedView.isHidden = true
            noCardView.isHidden = false
            tableView.isHidden = true
            view.layoutIfNeeded()
        case .showCards:
            showCards()
        case .createExtendCard:
            NavigationRouter.present(from: getRootPageVC(),
                                     to: CreateExtendCard1VC(),
                                     in: BaseRootVC())
        case .createVirtualCard:
            NavigationRouter.present(from: getRootPageVC(),
                                     to: VirtualCardCreateVC(),
                                     in: BaseRootVC())
        case let .openCard(viewModelData):
            NavigationRouter.present(from: getRootPageVC(),
                                     to: CardDetailVC(),
                                     in: BaseRootVC(),
                                     presentationStyle: .overCurrentContext,
                                     data: viewModelData)
        case .openCardApplication:
            NavigationRouter.present(from: getRootPageVC(),
                                     to: CreditCardApplicationFirstStepVC(),
                                     in: BaseRootVC(),
                                     presentationStyle: .overCurrentContext)
        case .createDebitCard:
            NavigationRouter.present(from: getRootPageVC(),
                                     to: CreateDebitCardFirstVC(),
                                     in: BaseRootVC())
        case .createVirtualDebitCard:
            NavigationRouter.present(from: getRootPageVC(),
                                     to: CreateVirtualDebitCardVC(),
                                     in: BaseRootVC())
        case .createExtendedDebitCard:
            NavigationRouter.present(from: getRootPageVC(),
                                     to: CreateExtendedDebitCardVC(),
                                     in: BaseRootVC())
        }
    }

    private func showCards() {
        stackView.isHidden = false
        if viewModel.havePersonalCards, viewModel.haveCorporateCards {
            viewModel.selectedTabIndex.value = 0
            segmentedView.isHidden = false
        } else {
            segmentedView.isHidden = true
        }
        viewModel.tabSelected(index: viewModel.havePersonalCards ? 0 : 1)
        noCardView.isHidden = true
        tableView.isHidden = false
        view.layoutIfNeeded()
    }

    override func setResources() {
        lblViewTitle.resource = .cards
        lblNoCardTitle.resource = .cardDetailNoCardWarningHeader
        lblNoCardSubtitle.resource = .cardDetailNoCardInfo
        btnNoCard.resource = .cardDetailCardApplicationButton
    }

    override func setAccessibilityIdentifiers() {
        lblViewTitle.accessibilityKey = .title
        lblNoCardTitle.accessibilityKey = .label
        lblNoCardSubtitle.accessibilityKey = .label2
        btnNoCard.accessibilityKey = .button1
    }
}

extension CardsPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 2 - 20,
                      height: 40)
    }
}

extension CardsPageVC: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: ResourceKey.menuCards.value,
                       image: #imageLiteral(resourceName: "tab3Inactive"),
                       selectedImage: #imageLiteral(resourceName: "tab3Active"))
    }
}
