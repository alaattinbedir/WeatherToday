//
//  UIView+Content.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

public extension UIView {
    func requiredResistanceAndHugging(for axis: NSLayoutConstraint.Axis) {
        setContentCompressionResistancePriority(.required, for: axis)
        setContentHuggingPriority(.required, for: axis)
    }

    func allSubViewsOf<T: UIView>(type _: T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }

    func findSuperView<T: UIView>(of type: T.Type) -> T? {
        guard let superview = superview else { return nil }
        if let typedSuperview = superview as? T {
            return typedSuperview
        } else {
            return superview.findSuperView(of: type)
        }
    }
}

public extension UIView {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
