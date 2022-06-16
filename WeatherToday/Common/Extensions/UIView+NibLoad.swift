//
//  UIView+NibLoad.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNib(withOwner owner: Any? = nil) -> Self? {
        let name = String(describing: type(of: self)).components(separatedBy: ".")[0]
        let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil)[0]
        return cast(view)
    }

    func loadFromNibIfEmbeddedInDifferentNib() -> Self? {
        if subviews.isEmpty {
            let view = type(of: self).loadFromNib()
            translatesAutoresizingMaskIntoConstraints = false
            view?.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        return self
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

private func cast<T, U>(_ value: T) -> U? {
    return value as? U
}
