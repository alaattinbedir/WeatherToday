//
//  CoreGraphics+Math.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

infix operator ×: MultiplicationPrecedence
infix operator ⨁: AdditionPrecedence

func × (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

func ⨁ (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func × (lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
}

func × (lhs: CGSize, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.width * rhs.x, y: lhs.height * rhs.y)
}

func × (lhs: CGPoint, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.x * rhs.width, height: lhs.y * rhs.height)
}

func × (lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width * rhs.x, height: lhs.height * rhs.y)
}

func × (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

func ⨁ (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
