//
//  UIView+IBInspectable.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderUIColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return nil
            }
        }
        set {
            if let borderUIColor = newValue {
                layer.borderColor = borderUIColor.cgColor
            }
        }
    }

    @IBInspectable var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = newValue }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            } else {
                return nil
            }
        }
        set {
            if let shadowColor = newValue {
                layer.shadowColor = shadowColor.cgColor
            }
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    @IBInspectable var shouldRasterize: Bool {
        get { return layer.shouldRasterize }
        set {
            layer.shouldRasterize = newValue
            layer.rasterizationScale = UIScreen.main.scale
        }
    }

    func addDashedBorder(with pattern: [NSNumber],
                         color: UIColor,
                         radius: CGFloat,
                         position: CGPoint) {
        layer.sublayers?.forEach { sublayer in
            if sublayer is CAShapeLayer {
                sublayer.removeFromSuperlayer()
            }
        }
        let shapeLayer = CAShapeLayer()
        let frameSize = bounds.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.frame = shapeRect
        shapeLayer.position = position
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = pattern
        shapeLayer.path = UIBezierPath(roundedRect: frame, cornerRadius: radius).cgPath
        layer.addSublayer(shapeLayer)
    }
}
