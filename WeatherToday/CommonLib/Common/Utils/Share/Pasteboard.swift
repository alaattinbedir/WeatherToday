//
//  Pasteboard.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public class Pasteboard {
    public static var shared: Pasteboard = Pasteboard()

    public func copy(text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
}
