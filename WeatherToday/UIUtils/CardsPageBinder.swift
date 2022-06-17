//
//  CardsPageBinder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import Foundation

class CardsPageBinder<Changeset: SectionedDataSourceChangeset>:
    TableViewBinderDataSource<Changeset>, UITableViewDelegate
    where Changeset.Collection == Array2D<CardsPageMetaData, Card> {
    override var tableView: UITableView? {
        didSet { tableView?.delegate = self }
    }

    override init() {
        super.init()
        rowReloadAnimation = .fade
        rowInsertionAnimation = .fade
        rowDeletionAnimation = .fade
        tableView?.isHidden = false
    }

    @objc
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let collection = changeset?.collection else { return nil }
        let viewSectionHeader = CardHeaderView.loadFromNib()
        viewSectionHeader?.cardType = collection.sections[section].metadata.cardType
        viewSectionHeader?.tag = section
        viewSectionHeader?.addCardView.tag = section
        viewSectionHeader?.configureAddCardButton(isShowing: collection.sections[section].metadata.showApplyCardOnHeader)
        viewSectionHeader?.addCardView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                   action: #selector(didTapHeader)))
        return viewSectionHeader
    }

    @objc
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return CardSelectionHeaderView.height
    }

    @objc
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let collection = changeset?.collection else { return 1 }
        if collection.numberOfItems(inSection: section) == 0 {
            return 1
        } else {
            return collection.numberOfItems(inSection: section)
        }
    }

    @objc
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if changeset?.collection.numberOfItems(inSection: indexPath.section) == 0 {
            let cell = tableView.dequeueCell(NoCardCell.self, forIndexPath: indexPath)
            cell.cardType = changeset?.collection.sections[indexPath.section].metadata.cardType
            cell.btnAddCard.tag = indexPath.section
            cell.btnAddCard.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                        action: #selector(didTapHeader)))
            return cell
        } else {
            let cell = tableView.dequeueCell(CardCell.self, forIndexPath: indexPath)
            cell.cardType = changeset?.collection.sections[indexPath.section].metadata.cardType
            cell.card = changeset?.collection.item(at: indexPath)
            return cell
        }
    }

    @objc
    private func didTapHeader(sender: UITapGestureRecognizer) {
        let view = sender.view
        let selectedIndex = view?.tag ?? 0
        guard let collection = changeset?.collection else { return }
        let metadata = collection.sections[selectedIndex].metadata
        metadata.handler?()
    }
}
