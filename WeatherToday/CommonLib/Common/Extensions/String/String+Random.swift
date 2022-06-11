//
//  String+Random.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
public extension String {
    static func random(length: Int, from charset: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        return String((0 ..< length).map { _ in charset.randomElement()! })
    }

    static func generateUUID() -> String {
        return NSUUID().uuidString
    }
}
