//
//  ReceiptDisplayDetailBinder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond

class ReceiptDisplayDetailBinder<Changeset: SectionedDataSourceChangeset>: TableViewBinderDataSource<Changeset>, UITableViewDelegate
    where Changeset.Collection == Array2D<IntermRecordCard, IntermRecordItem> {
    override var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
        }
    }

    override init() {
        super.init()
        rowReloadAnimation = .fade
        rowInsertionAnimation = .fade
        rowDeletionAnimation = .fade
    }

    @objc
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewSectionHeader = ReceiptDisplayDetailHeaderView.loadFromNib()
        viewSectionHeader?.metadata = changeset?.collection.sections[section].metadata
        return viewSectionHeader
    }

    @objc
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return ReceiptDisplayDetailHeaderView.rowHeight
    }

    @objc
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if changeset?.collection.numberOfItems(inSection: indexPath.section) == 0 {
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueCell(ReceiptDetailCell.self,
                                             forIndexPath: indexPath)
            cell.receiptDetail = changeset?.collection.item(at: indexPath)
            return cell
        }
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
}
