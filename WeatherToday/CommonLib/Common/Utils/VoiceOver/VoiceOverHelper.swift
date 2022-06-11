//
//  VoiceOverHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public class VoiceOverHelper {
    public class func isVoiceOverRunning() -> Bool {
        return UIAccessibility.isVoiceOverRunning
    }
}
