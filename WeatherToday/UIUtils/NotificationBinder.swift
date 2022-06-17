//
//  NotificationBinder.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import Foundation

class NotificationBinder<Changeset: SectionedDataSourceChangeset>: TableViewBinderDataSource<Changeset>,
    UITableViewDelegate where Changeset.Collection == Array2D<String, NotificationInfo> {
    override var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    var isEditing: Observable<Bool>?

    init(isEditing: Observable<Bool>) {
        super.init()
        rowReloadAnimation = .fade
        rowInsertionAnimation = .fade
        rowDeletionAnimation = .fade
        self.isEditing = isEditing
    }

    @objc
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewSectionHeader = NotificationHeaderView.loadFromNib()
        viewSectionHeader?.header = changeset?.collection.sections[section].metadata
        return viewSectionHeader
    }

    @objc
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return NotificationHeaderView.height
    }

    @objc
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(NotificationCell.self, forIndexPath: indexPath)
        cell.notificationInfo = changeset?.collection.item(at: indexPath)
        isEditing?.bind(to: cell.isEditingCell).dispose(in: cell.bag)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeset?.collection.item(at: indexPath).isSelected = true
    }

    func tableView(_: UITableView, didDeselectRowAt indexPath: IndexPath) {
        changeset?.collection.item(at: indexPath).isSelected = false
    }
}
