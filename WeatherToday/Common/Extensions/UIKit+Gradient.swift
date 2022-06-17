//
//  UIKit+Gradient.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

extension UIView {
    var gradientLayer: CAGradientLayer? {
        return layer.sublayers?.first { $0 is CAGradientLayer } as? CAGradientLayer
    }
}
