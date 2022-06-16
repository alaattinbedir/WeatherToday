//
//  UIColor+Gradient.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

extension UIColor {
    class func gradient(startColor: UIColor, endColor: UIColor, style: GradientStyle, size: CGSize) -> UIColor? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let colors = [startColor.cgColor, endColor.cgColor]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]

        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors as CFArray,
                                        locations: colorLocations) else { return nil }

        context.drawLinearGradient(gradient,
                                   start: style.startPoint × size,
                                   end: style.endPoint × size,
                                   options: CGGradientDrawingOptions(rawValue: 0))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        let color = UIColor(patternImage: image)
        UIGraphicsEndImageContext()
        return color
    }
}

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientStyle: Equatable {
    case topRightBottomLeft
    case topLeftBottomRight
    case bottomRightTopLeft
    case bottomLeftTopRight
    case horizontal
    case vertical
    case custom(GradientPoints)

    var startPoint: CGPoint {
        return points.startPoint
    }

    var endPoint: CGPoint {
        return points.endPoint
    }

    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1))
        case .topLeftBottomRight:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 0))
        case .bottomLeftTopRight:
            return (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))
        case .horizontal:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0))
        case .vertical:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))
        case let .custom(points):
            return points
        }
    }

    static func == (lhs: GradientStyle, rhs: GradientStyle) -> Bool {
        switch (lhs, rhs) {
        case (.topRightBottomLeft, .topRightBottomLeft):
            return true
        case (.topLeftBottomRight, .topLeftBottomRight):
            return true
        case (.bottomRightTopLeft, .bottomRightTopLeft):
            return true
        case (.bottomLeftTopRight, .bottomLeftTopRight):
            return true
        case (.horizontal, .horizontal):
            return true
        case (.vertical, .vertical):
            return true
        case let (.custom(lPoints), .custom(rPoints)):
            return lPoints == rPoints
        default:
            return false
        }
    }
}
