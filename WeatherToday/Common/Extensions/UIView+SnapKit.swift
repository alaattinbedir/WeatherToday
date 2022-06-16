//
//  UIView+SnapKit.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import SnapKit
import UIKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
            if #available(iOS 11.0, *) {
                return safeAreaLayoutGuide.snp
            }
            return snp
        #else
            return snp
        #endif
    }
}
