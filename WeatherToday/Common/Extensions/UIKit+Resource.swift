//
//  UIKit+Resource.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation
import ReactiveKit
import TextAttributes

extension UILabel {
    var resource: ResourceKey? {
        get { return nil }
        set { text = newValue?.value }
    }

    func setAttributedResource(_ resource: ResourceKey?, attributes: TextAttributes) {
        attributedText = NSAttributedString(string: (resource?.value)~, attributes: attributes)
    }
}

extension UIButton {
    var resource: ResourceKey? {
        get { return nil }
        set { setTitle(newValue?.value, for: .normal) }
    }

    func setResource(_ resource: ResourceKey, for state: UIControl.State) {
        setTitle(resource.value, for: state)
    }

    func setAttributedResource(_ resource: ResourceKey, attributes: TextAttributes) {
        setAttributedResource(resource, for: .normal, attributes: attributes)
        setAttributedResource(resource, for: .highlighted, attributes: attributes)
    }

    func setAttributedResource(_ resource: ResourceKey, for state: UIControl.State, attributes: TextAttributes) {
        let attributedString = NSAttributedString(string: resource.value, attributes: attributes)
        setAttributedTitle(attributedString, for: state)
    }

    func setResourceWithTextMargins(resource: ResourceKey, margin: Int) {
        var marginString = ""
        for _ in 0 ... margin {
            marginString += " "
        }
        setTitle(marginString + resource.value + marginString, for: .normal)
    }
}

extension UITextView {
    var resource: ResourceKey? {
        get { return nil }
        set { text = newValue?.value }
    }
}

extension UITextField {
    var resource: ResourceKey? {
        get { return nil }
        set { text = newValue?.value }
    }

    var placeholderResource: ResourceKey? {
        get { return nil }
        set { placeholder = newValue?.value }
    }
}

extension UINavigationController {
    var resource: ResourceKey? {
        get { return nil }
        set { title = newValue?.value }
    }
}

extension ReactiveExtensions where Base: UILabel {
    var resource: Bond<ResourceKey?> {
        return bond { $0.resource = $1 }
    }
}

extension ReactiveExtensions where Base: UIButton {
    var resource: Bond<ResourceKey?> {
        return bond { $0.resource = $1 }
    }
}

extension ReactiveExtensions where Base: UITextField {
    var resource: Bond<ResourceKey?> {
        return bond { $0.resource = $1 }
    }

    var placeholderResource: Bond<ResourceKey?> {
        return bond { $0.placeholderResource = $1 }
    }
}

extension ReactiveExtensions where Base: UITextView {
    var resource: Bond<ResourceKey?> {
        return bond { $0.resource = $1 }
    }
}
