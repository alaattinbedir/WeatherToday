//
//  VersionChecker.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
class VersionChecker {
    class func compare(version lValue: String, with rValue: String) -> ComparisonResult {
        let lValueArr = lValue.components(separatedBy: ".")
        let rValueArr = rValue.components(separatedBy: ".")

        let comparisonLength = max(lValueArr.count, rValueArr.count)

        for index in 0 ..< comparisonLength {
            let lValueDigit = index < lValueArr.count ? Int(lValueArr[index])~ : 0
            let rValueDigit = index < rValueArr.count ? Int(rValueArr[index])~ : 0

            if lValueDigit == rValueDigit {
                continue
            } else if lValueDigit > rValueDigit {
                return .orderedDescending
            } else {
                return .orderedAscending
            }
        }
        return .orderedSame
    }
}
