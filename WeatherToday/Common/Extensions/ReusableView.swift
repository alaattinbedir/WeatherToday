//
//  ReusableView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionReusableView: ReusableView {}
