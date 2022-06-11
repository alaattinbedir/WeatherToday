//
//  String+PascalCase.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension String {
    func pascalCase() -> String {
        return components(separatedBy: " ")
            .map { word in
                guard let first = word.first, word.count > 1 else { return word }
                return "\(first.uppercased())\(word.dropFirst().lowercased())"
            }
            .joined(separator: "")
    }

    func upperCasedFirstChar() -> String {
        guard let first = self.first else { return self }
        return "\(first.uppercased())\(dropFirst())"
    }
}
