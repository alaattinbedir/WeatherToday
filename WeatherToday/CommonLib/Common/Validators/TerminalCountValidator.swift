//
//  TerminalCountValidator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation

public class TerminalCountValidator: Validator<Int?, TerminalCountValidator.Result> {
    private var maxAllowedCount: Int

    public enum Result: String {
        case succeed
        case empty
        case zero
        case exceedMaxAllowed
    }

    public init(maxAllowedCount: Int) {
        self.maxAllowedCount = maxAllowedCount
        super.init()
    }

    override public func validate(_ data: Int?) -> Result {
        switch data {
        case nil:
            return .empty
        case 0:
            return .zero
        case let x? where x > maxAllowedCount:
            return .exceedMaxAllowed
        default:
            return .succeed
        }
    }
}
