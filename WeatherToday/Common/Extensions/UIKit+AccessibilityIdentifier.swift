//
//  UIKit+AccessibiltyIdentifier.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

protocol AccessiblityElement: AnyObject {
    var accessibilityKey: AccessibilityKey? { get set }
    var accessibilityPrefix: String { get }
}

extension UILabel {
    override var accessibilityPrefix: String {
        return "lbl"
    }
}

extension UIButton {
    override var accessibilityPrefix: String {
        return "btn"
    }
}

extension UITextField {
    override var accessibilityPrefix: String {
        return "tf"
    }
}

extension UITextView {
    override var accessibilityPrefix: String {
        return "tv"
    }
}

extension UIImageView {
    override var accessibilityPrefix: String {
        return "img"
    }
}

extension UISwitch {
    override var accessibilityPrefix: String {
        return "switch"
    }
}

extension UITableViewCell {
    override var accessibilityPrefix: String {
        return "cell"
    }
}

extension UICollectionViewCell {
    override var accessibilityPrefix: String {
        return "collection.cell"
    }
}

extension UIPickerView {
    override var accessibilityPrefix: String {
        return "picker"
    }
}

extension UIDatePicker {
    override var accessibilityPrefix: String {
        return "datePicker"
    }
}

extension UIView: AccessiblityElement {
    @objc var accessibilityPrefix: String {
        return "view"
    }
}

extension AccessiblityElement where Self: UIView {
    var accessibilityKey: AccessibilityKey? {
        get { return nil }
        set {
            guard let accessibilityKey = newValue else { return }
            accessibilityIdentifier = "\(accessibilityPrefix).\(accessibilityKey.value)"
        }
    }
}
