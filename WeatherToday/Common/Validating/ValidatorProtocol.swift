//
//  ValidatorProtocol.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

protocol Validatable {
    associatedtype Input
    associatedtype Result

    func validate(_ input: Input) -> Result
}
