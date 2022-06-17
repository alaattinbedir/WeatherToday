//
//  UIView+Gradient.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

extension UIView {
    func makeBorderGradientColor(color1: CGColor,
                                 color2: CGColor,
                                 size: CGSize,
                                 startPoint: CGPoint,
                                 endPoint: CGPoint) {
        layer.borderWidth = 0

        let existedGradient = gradientBorderLayer(name: "GradientBorderLayer")
        let gradient = existedGradient ?? CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero,
                                size: size)
        gradient.colors = [color1, color2]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.name = "GradientBorderLayer"

        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 1, y: 1),
                                                      size: CGSize(width: size.width - 2,
                                                                   height: size.height - 2)),
                                  cornerRadius: 10).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        layer.addSublayer(gradient)
    }

    func makeBorderColorStandart(color: CGColor) {
        removeGradientBorder()
        layer.borderColor = color
        layer.cornerRadius = 10
        layer.borderWidth = 2
    }

    public func removeGradientBorder() {
        guard let borderLayers = layer.sublayers else { return }
        for borderLayer in borderLayers {
            if borderLayer.name == "TimerGradientLayer"
                || borderLayer.name == "TimerStandartLayer"
                || borderLayer.name == "GradientBorderLayer" {
                borderLayer.removeFromSuperlayer()
            }
        }
    }

    private func gradientBorderLayer(name: String) -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter { $0.name == name }
        if borderLayers?.count ?? 0 > 1 {
            fatalError("Fatal Error")
        }
        return borderLayers?.first as? CAGradientLayer
    }

    func makeTimerGradientColor(color1: CGColor,
                                color2: CGColor,
                                size: CGSize,
                                startPoint: CGPoint,
                                endPoint: CGPoint) {
        layer.borderWidth = 0

        let existedGradient = gradientBorderLayer(name: "TimerGradientLayer")
        let gradient = existedGradient ?? CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero,
                                size: size)
        gradient.colors = [color1, color2]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.name = "TimerGradientLayer"

        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 1.5, y: 1.5),
                                                      size: CGSize(width: size.width - 3,
                                                                   height: size.height - 3)),
                                  cornerRadius: size.width / 2.0).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        layer.addSublayer(gradient)
    }

    func makeTimerStandartColor(color: CGColor,
                                size: CGSize,
                                startPoint: CGPoint,
                                endPoint: CGPoint,
                                endAngle: CGFloat) {
        layer.borderWidth = 0
        let existedGradient = gradientBorderLayer(name: "TimerStandartLayer")
        let gradient = existedGradient ?? CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero,
                                size: size)
        gradient.colors = [color, color]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.name = "TimerStandartLayer"

        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = UIBezierPath(arcCenter: CGPoint(x: size.width / 2,
                                                     y: size.height / 2),
                                  radius: (size.width - 2) / 2 - 0.5,
                                  startAngle: -CGFloat.pi / 2,
                                  endAngle: endAngle - CGFloat.pi / 2,
                                  clockwise: true).cgPath

        shape.strokeColor = color
        shape.fillColor = UIColor.clear.cgColor

        gradient.mask = shape
        layer.addSublayer(gradient)
    }
}
