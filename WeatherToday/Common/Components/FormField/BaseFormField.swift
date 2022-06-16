//
//  BaseFormField.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit

class BaseFormField: UIView {
    var firstSetup: Bool = true

    override func awakeAfter(using _: NSCoder) -> Any? {
        return loadFromNibIfEmbeddedInDifferentNib()
    }
}
