//
//  ShoppingPageBinder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond

class ShoppingPageBinder<Changeset: SectionedDataSourceChangeset>:
    TableViewBinderDataSource<Changeset>, UITableViewDelegate
    where Changeset.Collection == Array2D<ShoppingPageMetaData, Shop> {
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
        let viewSectionHeader = OrderedBillPaymentHeaderView.loadFromNib()
        viewSectionHeader?.lblHeader.font = AppFont.extraBold24
        viewSectionHeader?.metadata = changeset?.collection.sections[section].metadata.categoryTitle
        viewSectionHeader?.tag = section
        return viewSectionHeader
    }

    @objc
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return OrderedBillPaymentHeaderView.rowHeight
    }

    @objc
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if changeset?.collection.numberOfItems(inSection: indexPath.section) == 0 {
            let cell = tableView.dequeueCell(UITableViewCell.self,
                                             forIndexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueCell(ShoppingCell.self,
                                             forIndexPath: indexPath)
            cell.items = changeset?.collection.sections[indexPath.section].items ?? []
            return cell
        }
    }

    @objc
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }
}
