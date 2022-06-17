//
//  IntermTransactionsBinder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import Foundation

class IntermTransactionsBinder<Changeset: SectionedDataSourceChangeset>: TableViewBinderDataSource<Changeset>,
    UITableViewDelegate where Changeset.Collection == Array2D<IntermHeaderMetaData, IntermRecordMetaData> {
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
        let viewSectionHeader = IntermTransactionsHeaderView.loadFromNib()
        viewSectionHeader?.metadata = changeset?.collection.sections[section].metadata
        viewSectionHeader?.tag = section
        viewSectionHeader?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        return viewSectionHeader
    }

    @objc
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return IntermTransactionsHeaderView.rowHeight
    }

    @objc
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(IntermTransactionsCell.self, forIndexPath: indexPath)
        cell.intermRecordItem = changeset?.collection.item(at: indexPath)
        guard let collection = changeset?.collection else { return UITableViewCell() }
        for i in collection.sections {
            let cardType = i.metadata.cardType
            if cardType == .producer || cardType == .business || cardType == .businessExtend {
                cell.btnTripleDot.isHidden = true
            }
        }
        cell.btnInstallment.reactive.tap.observeNext { [weak self] _ in
            guard let self = self else { return }
            let selectedIndex = indexPath.item
            guard let collection = self.changeset?.collection else { return }
            let section = collection.sections[indexPath.section]
            let item = section.items[selectedIndex]
            item.recordHandler?(section.metadata.guid, item.provisionNumber, section.metadata.shadowCardNumber)
            if section.metadata.cardType == .producer {
                cell.lblValor.isHidden = false
            }
        }.dispose(in: bag)
        cell.viewPlusInstallment.reactive.tapGesture().observeNext { [weak self] _ in
            guard let self = self else { return }
            let selectedIndex = indexPath.item
            guard let collection = self.changeset?.collection else { return }
            let section = collection.sections[indexPath.section]
            let item = section.items[selectedIndex]
            item.addInstallmentHandler?(section.metadata.guid, item.provisionNumber, section.metadata.shadowCardNumber)
        }.dispose(in: bag)
        return cell
    }

    @objc
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let collection = changeset?.collection else { return 0 }
        return collection.sections[section].metadata.isCollapsed ? 0 : collection.numberOfItems(inSection: section)
    }

    @objc
    private func didTapHeader(sender: UITapGestureRecognizer) {
        let view = sender.view
        let selectedIndex = view?.tag ?? 0

        guard let collection = changeset?.collection else { return }

        for (index, section) in collection.sections.enumerated() where section.metadata.isCollapsable {
            if index == selectedIndex {
                section.metadata.isCollapsed = !section.metadata.isCollapsed
                section.metadata.handler?()
                tableView?.reloadData(with: UITableView.AnimationType.simple(duration: 0.3,
                                                                             direction: UITableView.Direction
                                                                                 .bottom(useCellsFrame: true),
                                                                             constantDelay: 0))
            } else {
                section.metadata.isCollapsed = false
            }
        }
    }
}
