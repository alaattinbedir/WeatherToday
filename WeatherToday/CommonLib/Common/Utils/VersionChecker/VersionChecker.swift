//
//  VersionChecker.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class VersionChecker {
    public class func compare(version lValue: String, with rValue: String) -> ComparisonResult {
        let lValueArr = lValue.components(separatedBy: ".")
        let rValueArr = rValue.components(separatedBy: ".")

        let comparisonLength = max(lValueArr.count, rValueArr.count)

        for i in 0 ..< comparisonLength {
            let lValueDigit = i < lValueArr.count ? Int(lValueArr[i]) ?? 0 : 0
            let rValueDigit = i < rValueArr.count ? Int(rValueArr[i]) ?? 0 : 0

            if lValueDigit == rValueDigit {
                continue
            } else if lValueDigit > rValueDigit {
                return .orderedDescending
            } else if lValueDigit < rValueDigit {
                return .orderedAscending
            }
        }
        return .orderedSame
    }
}
