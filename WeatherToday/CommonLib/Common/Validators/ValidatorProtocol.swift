//
//  ValidatorProtocol.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public protocol Validatable {
    associatedtype Input
    associatedtype Result

    func validate(_ input: Input) -> Result
}

public class AnyValidatable<V: Validatable>: Validatable {
    private let validatable: V

    public init(_ validatable: V) {
        self.validatable = validatable
    }

    open func validate(_ input: V.Input) -> V.Result {
        return validatable.validate(input)
    }
}

open class Validator<D, R> {
    public init() {
        // empty
    }

    open func validate(_: D) -> R {
        abort()
    }
}
