//
//  ObservableStruct.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public struct ObservableStruct<T> {
    public var value: T {
        didSet {
            let newValue = value
            observers.forEach { _, observer in
                DispatchQueue.main.async { observer(newValue) }
            }
        }
    }

    public typealias ChangeBlock = (T) -> Void
    private var observers = [Int: ChangeBlock]()
    private var index: Int = -1

    public init(_ value: T) {
        self.value = value
    }

    public mutating func onChange(_ block: @escaping ChangeBlock) -> Int {
        index += 1
        observers[index] = block
        return index
    }

    public mutating func removeObserver(_ index: Int) {
        observers.removeValue(forKey: index)
    }
}
