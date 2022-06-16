//
//  FormButton.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Bond
import Foundation
import ReactiveKit

extension UIControl.State {
    static var activeDisabled: UIControl.State { return UIControl.State(rawValue: 0b0001 << 23) }
}

enum FormButtonStyle: Int {
    case primaryStyle = 0
    case secondaryStyle = 1
    case tabStyle = 2
    case teriateryStyle = 3
    case segmentedStyle = 4
    case quaternaryStyle = 5
    case iconedStyle = 6
    case quinaryStyle = 7
    case sextStyle = 8
    case borderedStyle = 9
    case gradientStyle = 10
    case textStyle = 11
}

class FormButton: UIButton {
    private var isActiveDisabledState: UInt = 0
    var isActiveDisabled: Bool {
        get {
            return isActiveDisabledState &
                UIControl.State.activeDisabled.rawValue == UIControl.State.activeDisabled.rawValue
        } set {
            if newValue {
                isActiveDisabledState |= UIControl.State.activeDisabled.rawValue
            } else {
                isActiveDisabledState &= ~UIControl.State.activeDisabled.rawValue
            }
            setNeedsLayout()
        }
    }

    override var state: UIControl.State {
        return UIControl.State(rawValue: super.state.rawValue | isActiveDisabledState)
    }

    private var pFormButtonStyle: FormButtonStyle = .primaryStyle
    @IBInspectable var formButtonStyle: Int {
        get { return pFormButtonStyle.rawValue }
        set {
            if let style = FormButtonStyle(rawValue: newValue) {
                pFormButtonStyle = style
                FormFieldStyle.applyFormButtonStyle(self, style: style)
            }
        }
    }

    @IBInspectable var textSize: CGFloat = 0

    private var normalFont: UIFont?
    private var highlightedFont: UIFont?
    private var selectedFont: UIFont?
    private var disabledFont: UIFont?

    init(buttonStyle: FormButtonStyle) {
        super.init(frame: .zero)
        formButtonStyle = buttonStyle.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setFont(_ font: UIFont?, for state: UIControl.State) {
        switch state {
        case .normal:
            normalFont = font
        case .highlighted:
            highlightedFont = font
        case .selected:
            selectedFont = font
        case .disabled, .activeDisabled:
            disabledFont = font
        default:
            normalFont = font
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        FormFieldStyle.applyFormButtonStyle(self, style: pFormButtonStyle, for: state)

        switch state {
        case .normal:
            setTitleFont(normalFont)
        case .highlighted, .focused:
            setTitleFont(highlightedFont)
        case .selected:
            setTitleFont(selectedFont)
        case .disabled, .activeDisabled:
            setTitleFont(disabledFont)
        default:
            setTitleFont(normalFont)
        }
    }

    private func setTitleFont(_ font: UIFont?) {
        if let font = font {
            titleLabel?.font = textSize == 0 ? font : font.withSize(textSize)
        } else {
            titleLabel?.font = AppFont.button
        }
    }

    func setDoubleLineTitle(line1: String,
                            line2: String,
                            font1: UIFont? = UIFont(name: AppFont.bold, size: 17),
                            font2 _: UIFont? = UIFont(name: AppFont.bold, size: 11)) {
        let str = NSAttributedString(attributedString: "\(line1)\n\(line2)".font(font1 ?? UIFont()).centered())
        setAttributedTitle(str, for: .normal)
    }
}

extension ReactiveExtensions where Base: FormButton {
    var resource: Bond<ResourceKey?> {
        return bond { $0.resource = $1 }
    }
}
