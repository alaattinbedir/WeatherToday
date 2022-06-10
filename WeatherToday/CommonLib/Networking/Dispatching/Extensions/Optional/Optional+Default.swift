//
//  Optional+Default.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation
import UIKit

infix operator ==>

func ==> <T>(from: Any?, _: T.Type) -> T {
    return from as! T
}

extension Int: DefaultValue {
    public static var defaultValue: Int { return 0 }
}

extension Double: DefaultValue {
    public static var defaultValue: Double { return 0.0 }
}

extension Float: DefaultValue {
    public static var defaultValue: Float { return 0.0 }
}

extension String: DefaultValue {
    public static var defaultValue: String { return "" }
}

extension Bool: DefaultValue {
    public static var defaultValue: Bool { return false }
}

extension Array: DefaultValue {
    public static var defaultValue: [Element] { return [] }
}

extension UIFont: DefaultValue {
    public static var defaultValue: UIFont { return UIFont.systemFont(ofSize: 13) }
}

extension UITableViewCell: DefaultValue {
    public static var defaultValue: UITableViewCell { return UITableViewCell(frame: .zero) }
}

