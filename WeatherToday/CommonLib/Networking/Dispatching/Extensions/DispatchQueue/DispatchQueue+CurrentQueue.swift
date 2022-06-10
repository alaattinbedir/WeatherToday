//
//  DispatchQueue+CurrentQueue.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public extension DispatchQueue {
    static func getCurrentQueue() -> DispatchQueue {
        return Thread.isMainThread ? DispatchQueue.main : DispatchQueue.global()
    }
}
