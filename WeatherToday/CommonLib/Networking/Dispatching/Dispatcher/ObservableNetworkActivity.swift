//
//  ObservableNetworkActivity.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public protocol ObservableNetworkActivity {
    var lockScreen: Bool { get }
}
