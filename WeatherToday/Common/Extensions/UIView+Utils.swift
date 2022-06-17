//
//  UIView+Utils.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

extension UIView {
    func setAttributedString(limitFirst: String, limitSecond: String, label: UILabel) {
        let limitFirstAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blackEight,
                                    NSAttributedString.Key.font: AppFont.extraBold18]
        let limitSecondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brownishGreyTwo,
                                     NSAttributedString.Key.font: AppFont.regular12]
        let mutableAttributedString = NSMutableAttributedString(string: limitFirst,
                                                                attributes: limitFirstAttributes)
        let attributedString = NSAttributedString(string: limitSecond,
                                                  attributes: limitSecondAttributes)

        mutableAttributedString.append(attributedString)

        label.attributedText = mutableAttributedString
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            var masked = CACornerMask()
            if corners.contains(.topLeft) {
                masked.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                masked.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                masked.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                masked.insert(.layerMaxXMaxYCorner)
            }
            layer.maskedCorners = masked
        } else {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

    func addGradient() {
        makeTimerGradientColor(color1: UIColor.strongPink.cgColor,
                               color2: UIColor.azure.cgColor,
                               size: bounds.size,
                               startPoint: CGPoint(x: 0, y: 0.5),
                               endPoint: CGPoint(x: 1, y: 0.5))
    }

    func heightViewToFit() -> CGFloat {
        setNeedsLayout()
        layoutIfNeeded()
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return height
    }
}

// Easy tap gesture recognizer, source: https://github.com/utsavstha/EasyTapGesture/blob/master/TapGesture.swift
extension UIView {
    fileprivate enum AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    fileprivate typealias Action = (() -> Void)?

    private var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }

    public func addTapGestureRecognizer(action: (() -> Void)?) {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapGesture(_: UITapGestureRecognizer) {
        if let action = tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}
