//
//  BaseSelectionCell.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

protocol Selectable {}

protocol CustomSelectionCell: BaseSelectionCell {
    func configure(item: Selectable, isSelected: Bool)
}

class BaseSelectionCell: UITableViewCell {
    @IBOutlet var mainView: UIView!

    func makeUISelected() {
        let color1 = UIColor.brightSkyBlue.cgColor
        let color2 = UIColor.azure.cgColor
        let screenBounds = UIScreen.main.bounds
        mainView.makeBorderGradientColor(color1: color1,
                                         color2: color2,
                                         size: CGSize(width: screenBounds.size.width - 72,
                                                      height: mainView.bounds.size.height),
                                         startPoint: CGPoint(x: 0, y: 0.5),
                                         endPoint: CGPoint(x: 1, y: 0.5))
    }

    func makeUIUnselected() {
        let color = UIColor.duckEggBlue.cgColor
        mainView.makeBorderColorStandart(color: color)
    }
}
