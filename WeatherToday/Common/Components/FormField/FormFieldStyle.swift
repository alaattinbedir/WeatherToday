//
//  FormFieldStyle.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

class FormFieldStyle {
    static let buttonHeight: CGFloat = 45.0
    static let buttonHeightForCardDetail: CGFloat = 52.0
    static let generalMargin: CGFloat = 16.0

    class func applyFormButtonStyle(_ button: FormButton, style: FormButtonStyle, for state: UIControl.State = .normal) {
        FormFieldStyle.applyButtonBackgroundStyle(button, style: style, for: state)
        FormFieldStyle.applyButtonTextStyle(button, style: style, for: state)
        FormFieldStyle.applyButtonShadowStyle(button, style: style, for: state)
        FormFieldStyle.applyButtonBorderStyle(button, style: style, for: state)
        FormFieldStyle.applyButtonFontStyle(button, style: style, for: state)
    }

    private class func applyButtonBackgroundStyle(_ button: FormButton,
                                                  style: FormButtonStyle,
                                                  for state: UIControl.State) {
        button.backgroundColor = FormFieldStyle.backgroundColor(for: button, style: style, state: state)
    }

    private class func applyButtonTextStyle(_ button: FormButton, style: FormButtonStyle, for state: UIControl.State) {
        let textColor = FormFieldStyle.enabledTextColor(for: style, state: state)
        button.setTitleColor(textColor, for: state)
    }

    private class func applyButtonShadowStyle(_ button: FormButton, style: FormButtonStyle, for state: UIControl.State) {
        button.shadowOpacity = 1.0
        button.shadowColor = FormFieldStyle.shadowColor(for: style, state: state)
        button.shadowRadius = FormFieldStyle.shadowRadius(for: style, state: state)
        button.shadowOffset = FormFieldStyle.shadowOffset(for: style, state: state)
    }

    private class func applyButtonBorderStyle(_ button: FormButton, style: FormButtonStyle, for state: UIControl.State) {
        button.borderUIColor = FormFieldStyle.borderColor(for: style, state: state)
        button.borderWidth = FormFieldStyle.borderWidth(for: style, state: state)

        let cornerRadius = FormFieldStyle.cornerRadius(for: style)
        if cornerRadius < 0 {
            button.cornerRadius = (button.bounds.height > 0 ? button.bounds.height : buttonHeight) / 2
        } else {
            button.cornerRadius = cornerRadius
        }
    }

    private class func applyButtonFontStyle(_ button: FormButton, style: FormButtonStyle, for state: UIControl.State) {
        let font = FormFieldStyle.font(for: style, state: state)
        button.setFont(font, for: state)
    }

    class func applyBottomRoundedStyle(_ button: FormButton) {
        button.cornerRadius = 0
        let maskPath1 = UIBezierPath(roundedRect: button.bounds,
                                     byRoundingCorners: [.bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: 27, height: 27))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = button.bounds
        maskLayer1.path = maskPath1.cgPath
        button.layer.mask = maskLayer1
    }

    private class func enabledTextColor(for style: FormButtonStyle, state: UIControl.State) -> UIColor {
        switch (style, state) {
        case (.primaryStyle, .normal), (.tabStyle, _), (.quinaryStyle, _), (.gradientStyle, _):
            return .white
        case (.secondaryStyle, _), (.quaternaryStyle, _), (.sextStyle, _), (.textStyle, _):
            return .azure2
        case (.teriateryStyle, _), (.iconedStyle, _):
            return .white
        case (.segmentedStyle, .selected):
            return .blackEight
        case (.segmentedStyle, _):
            return .greyish
        case (.primaryStyle, .disabled), (.primaryStyle, .activeDisabled):
            return .greyish
        case (.primaryStyle, _):
            return .white
        case (.borderedStyle, .selected):
            return .cerulean
        case (.borderedStyle, .normal):
            return .brightSkyBlue
        case (.borderedStyle, .disabled):
            return .coolGrey
        case (.borderedStyle, _):
            return .azure
        }
    }

    private class func backgroundColor(for button: FormButton,
                                       style: FormButtonStyle,
                                       state: UIControl.State) -> UIColor? {
        switch (style, state) {
        case (.primaryStyle, .disabled), (.primaryStyle, .activeDisabled):
            return .silver
        case (.primaryStyle, .normal), (.tabStyle, .normal), (.quinaryStyle, _):
            return UIColor.gradient(startColor: .brightSkyBlue,
                                    endColor: .azure,
                                    style: .horizontal,
                                    size: button.frame.size)
        case (.tabStyle, .selected):
            return UIColor.gradient(startColor: .white,
                                    endColor: .black,
                                    style: .topLeftBottomRight,
                                    size: button.frame.size)
        case (.secondaryStyle, _), (.teriateryStyle, _), (.segmentedStyle, _), (.textStyle, _):
            return .clear
        case (.tabStyle, _):
            return button.backgroundColor
        case (.gradientStyle, _):
            return UIColor.gradient(startColor: .salmon,
                                    endColor: .pinkRedTwo,
                                    style: .horizontal,
                                    size: button.frame.size)
        case (.borderedStyle, _):
            return .white
        default:
            return .silver
        }
    }

    private class func shadowColor(for style: FormButtonStyle, state: UIControl.State) -> UIColor {
        switch (style, state) {
        case (.primaryStyle, .disabled), (.primaryStyle, .activeDisabled), (.secondaryStyle, _), (.teriateryStyle, _),
             (.quaternaryStyle, _), (.segmentedStyle, _), (.iconedStyle, _), (.sextStyle, _), (.borderedStyle, _), (.textStyle, _):
            return .clear
        case (.primaryStyle, .normal), (.tabStyle, _), (.quinaryStyle, _):
            return .azure35
        case (.gradientStyle, _):
            return .pinkRedTwo
        default:
            return .clear
        }
    }

    private class func shadowRadius(for style: FormButtonStyle, state: UIControl.State) -> CGFloat {
        switch (style, state) {
        case (.primaryStyle, _), (.quinaryStyle, _):
            return 4.0
        case (.secondaryStyle, _), (.teriateryStyle, _), (.quaternaryStyle, _),
             (.segmentedStyle, _), (.iconedStyle, _), (.sextStyle, _), (.borderedStyle, _), (.textStyle, _):
            return 0
        case (.tabStyle, _), (.gradientStyle, _):
            return 2.0
        }
    }

    private class func shadowOffset(for style: FormButtonStyle, state: UIControl.State) -> CGSize {
        switch (style, state) {
        case (.primaryStyle, _), (.quinaryStyle, _):
            return CGSize(width: 0, height: 3)
        case (.secondaryStyle, _), (.teriateryStyle, _), (.quaternaryStyle, _),
             (.segmentedStyle, _), (.iconedStyle, _), (.sextStyle, _), (.borderedStyle, _), (.gradientStyle, _), (.textStyle, _):
            return .zero
        case (.tabStyle, _):
            return CGSize(width: 0, height: 1)
        }
    }

    private class func borderColor(for style: FormButtonStyle, state: UIControl.State) -> UIColor {
        switch (style, state) {
        case (.primaryStyle, _), (.tabStyle, _), (.teriateryStyle, _),
             (.segmentedStyle, _), (.iconedStyle, _), (.quinaryStyle, _), (.gradientStyle, _), (.textStyle, _):
            return .clear
        case (.quaternaryStyle, _), (.sextStyle, _), (.secondaryStyle, _):
            return .azure
        case (.borderedStyle, .normal):
            return UIColor.gradient(startColor: .azure,
                                    endColor: .brightSkyBlue,
                                    style: .topRightBottomLeft,
                                    size: CGSize(width: UIScreen.main.bounds.width,
                                                 height: buttonHeight)) ?? .azure
        case (.borderedStyle, .selected):
            return .cerulean
        case (.borderedStyle, .disabled):
            return .lightGreyBlue
        case (.borderedStyle, _):
            return .azure
        }
    }

    private class func borderWidth(for style: FormButtonStyle, state: UIControl.State) -> CGFloat {
        switch (style, state) {
        case (.primaryStyle, _), (.tabStyle, _), (.teriateryStyle, _),
             (.segmentedStyle, _), (.iconedStyle, _), (.quinaryStyle, _), (.gradientStyle, _), (.textStyle, _):
            return 0
        case (.secondaryStyle, _), (.quaternaryStyle, _), (.sextStyle, _):
            return 1
        case (.borderedStyle, _):
            return 2
        }
    }

    private class func cornerRadius(for style: FormButtonStyle) -> CGFloat {
        switch style {
        case .quaternaryStyle:
            return 20
        default:
            return -1
        }
    }

    private class func font(for style: FormButtonStyle, state: UIControl.State) -> UIFont {
        switch (style, state) {
        case (.segmentedStyle, .highlighted), (.segmentedStyle, .selected):
            return AppFont.bold16
        case (.segmentedStyle, _):
            return AppFont.regular16
        case (.iconedStyle, _):
            return AppFont.medium14
        case (.quinaryStyle, _), (.sextStyle, _):
            return AppFont.button.withSize(14.0)
        case (.gradientStyle, _):
            return AppFont.button.withSize(14.0)
        default:
            return AppFont.button
        }
    }

//    class func applyTextFormFieldStyle(_ textFormField: TextFormField) {
//        textFormField.textField.textColor = .black
//    }
//
//    class func applyPatternLockStyle(_ gestureLock: CCGestureLock, isSecure: Bool) {
//        gestureLock.lockSize = (4, 4)
//        gestureLock.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        gestureLock.responderSize = CGSize(width: 36, height: 36)
//
//        setPatternAppearanceForSelected(gestureLock, isSecure)
//        setPatternAppearanceForNormalAndError(gestureLock)
//
//        let gradientColor = UIColor.gradient(startColor: UIColor.brightSkyBlue,
//                                             endColor: UIColor.azure,
//                                             style: .vertical,
//                                             size: CGSize(width: 1, height: 1))
//
//        [CCGestureLock.GestureLockState.normal, CCGestureLock.GestureLockState.selected].forEach { state in
//            gestureLock.setLineAppearance(width: 2, color: isSecure ? .clear : gradientColor, forState: state)
//        }
//        gestureLock.setLineAppearance(width: 2, color: .black, forState: .error)
//        gestureLock.isSecure = isSecure
//    }
//
//    private class func setPatternAppearanceForSelected(_ gestureLock: CCGestureLock, _ isSecure: Bool) {
//        let gradientColor = UIColor.gradient(startColor: UIColor.brightSkyBlue,
//                                             endColor: UIColor.azure,
//                                             style: .vertical,
//                                             size: CGSize(width: 60, height: 60))
//        gestureLock.setSensorAppearance(type: .inner,
//                                        radius: 22,
//                                        color: .clear,
//                                        forState: .selected)
//        gestureLock.setSensorAppearance(type: .middle,
//                                        radius: 15,
//                                        color: isSecure ? .paleGreyThree : gradientColor,
//                                        forState: .selected)
//        gestureLock.setSensorAppearance(type: .outer,
//                                        radius: 16,
//                                        color: isSecure ? .warmGreyTwo : .clear,
//                                        forState: .selected)
//        gestureLock.setSensorAppearance(type: .outerShadow,
//                                        radius: 22,
//                                        color: .clear,
//                                        forState: .selected)
//    }
//
//    private class func setPatternAppearanceForNormalAndError(_ gestureLock: CCGestureLock) {
//        gestureLock.setSensorAppearance(type: .inner,
//                                        radius: 3,
//                                        color: .clear,
//                                        forState: .normal)
//        gestureLock.setSensorAppearance(type: .middle,
//                                        radius: 15,
//                                        color: .paleGreyThree,
//                                        forState: .normal)
//        gestureLock.setSensorAppearance(type: .outer,
//                                        radius: 16,
//                                        color: .warmGreyTwo,
//                                        forState: .normal)
//        gestureLock.setSensorAppearance(type: .outerShadow,
//                                        radius: 22,
//                                        color: .clear,
//                                        forState: .normal)
//    }
}
