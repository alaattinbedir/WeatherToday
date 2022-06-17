//
//  CardSelectionBinder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import Foundation

class CardSelectionBinder<Changeset: SectionedDataSourceChangeset>: TableViewBinderDataSource<Changeset>,
    UITableViewDelegate where Changeset.Collection == Array2D<CardSelectionMetaData, CardDetail> {
    override var tableView: UITableView? {
        didSet { tableView?.delegate = self }
    }

    override init() {
        super.init()
        rowReloadAnimation = .fade
        rowInsertionAnimation = .fade
        rowDeletionAnimation = .fade
    }

    @objc
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewSectionHeader = CardSelectionHeaderView.loadFromNib()
        viewSectionHeader?.metadata = changeset?.collection.sections[section].metadata
        viewSectionHeader?.tag = section
        viewSectionHeader?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        return viewSectionHeader
    }

    @objc
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return CardSelectionHeaderView.height
    }

    @objc
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let collection = changeset?.collection else { return 0 }
        return collection.sections[section].metadata.isCollapsed ? 0 : collection.numberOfItems(inSection: section)
    }

    @objc
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CardsSelectionCell.self, forIndexPath: indexPath)
        cell.card = changeset?.collection.item(at: indexPath)
        return cell
    }

    @objc
    private func didTapHeader(sender: UITapGestureRecognizer) {
        let view = sender.view
        let selectedIndex = view?.tag ?? 0

        guard let collection = changeset?.collection else { return }
        for (index, section) in collection.sections.enumerated() {
            if index == selectedIndex {
                section.metadata.isCollapsed = !section.metadata.isCollapsed
            } else {
                section.metadata.isCollapsed = true
            }
        }

        tableView?.reloadData(with: UITableView.AnimationType.simple(duration: 0.3,
                                                                     direction: UITableView.Direction.bottom(useCellsFrame: true),
                                                                     constantDelay: 0))
    }
}
