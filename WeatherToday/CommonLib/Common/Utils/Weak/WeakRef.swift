//
//  WeakRef.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class WeakRef<T> where T: AnyObject {
    public private(set) weak var ref: T?
    public init(ref: T?) {
        self.ref = ref
    }
}
