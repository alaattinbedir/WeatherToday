//
//  Any+Extension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public extension Optional where Wrapped == Int {
    func toString() -> String? {
        if let val = self {
            return String(val)
        }
        return nil
    }
}

public extension Optional where Wrapped == Any {
    func toString() -> String? {
        if let any = self {
            if let anyStr = any as? String {
                return anyStr
            } else {
                return String(describing: any)
            }
        }
        return nil
    }

    func toInt() -> Int? {
        if let any = self {
            if let anyInt = any as? Int {
                return anyInt
            } else if let anyStr = toString() {
                return Int(anyStr)
            }
        }
        return nil
    }

    func toInt64() -> Int64? {
        if let any = self {
            if let anyInt = any as? Int64 {
                return anyInt
            } else if let anyStr = toString() {
                return Int64(anyStr)
            }
        }
        return nil
    }

    func toDate() -> Date? {
        return self as? Date
    }

    func toDouble() -> Double? {
        if let any = self {
            if let anyDouble = any as? Double {
                return anyDouble
            } else if let anyStr = toString() {
                return Double(anyStr)
            }
        }
        return nil
    }

    func toFloat() -> Float? {
        if let any = self {
            if let anyFlaot = any as? Float {
                return anyFlaot
            } else if let anyStr = toString() {
                return Float(anyStr)
            }
        }
        return nil
    }

    func toBool() -> Bool? {
        if let any = self {
            if let anyBool = any as? Bool {
                return anyBool
            } else if let anyString = toString(), let boolVal = Bool(anyString) {
                return boolVal
            } else if let anyInt = toInt() {
                if anyInt == 1 {
                    return true
                } else if anyInt == 0 {
                    return false
                }
            }
        }
        return nil
    }
}
