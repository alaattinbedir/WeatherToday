//
//  UIButton+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import UIKit

extension UIButton {
    func centerVertically(padding: CGFloat = 1.0) {
        if imageView?.image == nil {
            return
        }

        guard let imageSize = imageView?.frame.size, let titleSize = titleLabel?.frame.size else {
            return
        }

        let totalHeight = imageSize.height + titleSize.height + padding

        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleSize.width - pow(titleSize.width * 0.05, 1.5)
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0.0
        )

        contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleSize.height,
            right: 0.0
        )
    }
}
