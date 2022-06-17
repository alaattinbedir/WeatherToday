//
//  TextFormField.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Bond
import ReactiveKit
import UIKit

class TextFormField: FormField {
    @IBInspectable var maxLength: UInt = UInt.max
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblError: UILabel!
    @IBOutlet var warningView: WarningInfoAlertView!
    @IBInspectable var validRegex: String = ".*"

    var placeholder: String? {
        didSet { textField.placeholder = placeholder }
    }

    override func awakeAfter(using _: NSCoder) -> Any? {
        let view = loadFromNibIfEmbeddedInDifferentNib()
        view?.isHidden = isHidden
        view?.alpha = alpha
        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if firstSetup {
            firstSetup = false
            bind()
        }
        warningView.isHidden = true
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        } else {
            textField.textContentType = .init(rawValue: "")
        }
    }

    override func bind() {
        super.bind()
    }

    var title: String = "" {
        didSet {
            lblTitle.text = title
        }
    }

    func clearError() {
        lblError.isHidden = true
        mainView?.layer.borderColor = UIColor.clear.cgColor
    }

    func showError(_ message: String) {
        lblError.isHidden = false
        lblError.text = message
        mainView?.layer.borderWidth = 2
        mainView?.layer.borderColor = UIColor.tomatoRed.cgColor
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}

extension TextFormField: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text~
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return (updatedText.count <= maxLength && isValid(text: string)) || string.isEmpty
    }

    private func isValid(text: String) -> Bool {
        if !validRegex.isEmpty {
            let predicate = NSPredicate(format: "SELF MATCHES %@", validRegex)
            return predicate.evaluate(with: text)
        } else {
            return true
        }
    }
}

extension TextFormField {
    var resource: ResourceKey? {
        get { return nil }
        set { text.value = newValue?.value }
    }

    var placeholderResource: ResourceKey? {
        get { return nil }
        set { placeholder = newValue?.value }
    }
}

extension TextFormField {
    var accessibilityKey: AccessibilityKey? {
        get { return nil }
        set {
            textField.accessibilityKey = newValue
            lblTitle.accessibilityIdentifier = "\(AccessibilityKey.title.rawValue).\((newValue?.value)~)"
            lblError.accessibilityIdentifier = "\(AccessibilityKey.error.rawValue).\((newValue?.value)~)"
        }
    }
}
