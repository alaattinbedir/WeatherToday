//
//  Array+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
extension Array {
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if !groups.keys.contains(key) {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    subscript(start startIndex: Int, end endIndex: Int) -> [Element] {
        return Array(self[startIndex ... Swift.min(endIndex, count - 1)])
    }
}

extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element

    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = firstIndex(of: item) {
            let lastItem: Bool = index(after: itemIndex) == endIndex
            if loop, lastItem {
                return first
            } else if lastItem {
                return nil
            } else {
                return self[index(after: itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = firstIndex(of: item) {
            let firstItem: Bool = itemIndex == startIndex
            if loop, firstItem {
                return last
            } else if firstItem {
                return nil
            } else {
                return self[index(before: itemIndex)]
            }
        }
        return nil
    }
}

extension Collection where Element: Equatable {
    func indexDistance(of element: Element) -> Int? {
        guard let index = firstIndex(of: element) else { return nil }
        return distance(from: startIndex, to: index)
    }
}

extension StringProtocol {
    func indexDistance(of string: Self) -> Int? {
        guard let index = range(of: string)?.lowerBound else { return nil }
        return distance(from: startIndex, to: index)
    }
}

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return count == other.count && sorted() == other.sorted()
    }
}
