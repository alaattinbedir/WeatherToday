//
//  MDLoggerEvent.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 8.06.2022.
//
import Foundation

public protocol MDLoggerEvent {
    var event: String { get }
    var params: [String: Any]? { get }
}
