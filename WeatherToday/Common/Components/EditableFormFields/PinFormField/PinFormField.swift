//
//  PinFormField.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation
import ReactiveKit

class PinFormField: FormField {
    @IBInspectable var size: Int = 6 {
        didSet { createPinFormItems() }
    }

    @IBInspectable var title: String? {
        didSet { lblTitle.text = title }
    }

    @IBInspectable var titleColor: UIColor? = .black {
        didSet { lblTitle.textColor = titleColor }
    }

    @IBInspectable var spacing: CGFloat = 8.0 {
        didSet { viewContainer.spacing = spacing }
    }

    private var observableIsSecure = Observable<Bool>(false)
    @IBInspectable var isSecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecure
            observableIsSecure.value = isSecure
        }
    }

    private var observableActiveIndicatorColor = Observable<UIColor>(.black)
    @IBInspectable var activeIndicatorColor: UIColor = .black {
        didSet { observableActiveIndicatorColor.value = activeIndicatorColor }
    }

    private var observableDefaultIndicatorColor = Observable<UIColor>(.lightGray)
    @IBInspectable var defaultIndicatorColor: UIColor = .lightGray {
        didSet { observableDefaultIndicatorColor.value = defaultIndicatorColor }
    }

    private var observableTextColor = Observable<UIColor>(.black)
    @IBInspectable var textColor: UIColor = .black {
        didSet { observableTextColor.value = textColor }
    }

    private var observableErrorColor = Observable<UIColor>(.red)
    @IBInspectable var errorColor: UIColor = .red {
        didSet { observableErrorColor.value = errorColor }
    }

    @IBInspectable var validRegex: String = "[0-9]{0,1000}"
    @IBOutlet var lblTitle: UILabel!

    @IBOutlet var viewContainer: UIStackView!
    @IBOutlet var lblError: UILabel!

    weak var delegate: FormFieldDelegate?

    var isEnabled: Bool = true {
        didSet {
            textField.isEnabled = isEnabled
            alpha = isEnabled ? 1.0 : 0.5
        }
    }

    override func awakeAfter(using _: NSCoder) -> Any? {
        return loadFromNibIfEmbeddedInDifferentNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if firstSetup {
            firstSetup = false
            bind()
        }
    }

    override func bind() {
        super.bind()
        text.bidirectionalBind(to: textField.reactive.text)
        textField.reactive.controlEvents(.editingDidBegin).bind(to: self) { $0.editingBegan() }.dispose(in: bag)
        textField.reactive.controlEvents(.editingDidEnd).bind(to: self) { $0.editingEnded() }.dispose(in: bag)
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

    private func editingBegan() {
        isEditing.value = true
    }

    private func editingEnded() {
        isEditing.value = false
    }

    private func createPinFormItems() {
        viewContainer.removeAllArrangedSubviews()
        for index in 0 ..< size {
            guard let pinFormItemView = PinFormItemView.loadFromNib() else { return }
            pinFormItemView.snp.makeConstraints { $0.width.equalTo(20) }
            pinFormItemView.snp.makeConstraints { $0.width.equalTo(30) }
            bindItemProperties(pinFormItemView, for: index)
            viewContainer.addArrangedSubview(pinFormItemView)
        }
        layoutIfNeeded()
    }

    private func bindItemProperties(_ item: PinFormItemView, for index: Int) {
        observableIsSecure.bind(to: item.isSecure)
        observableActiveIndicatorColor.bind(to: item.activeIndicatorColor)
        observableDefaultIndicatorColor.bind(to: item.defaultIndicatorColor)
        observableTextColor.bind(to: item.textColor)
        observableErrorColor.bind(to: item.errorColor)
        text.map { index == $0~.count - 1 }.bind(to: item.isCurrent)
        text.map { String($0~ [index]) }.bind(to: item.text)
        text.map { [weak self] text in
            guard let self = self else { return false }
            return text~.count > index || self.textField.isFirstResponder && index == 0
        }.bind(to: item.isActive)

        combineLatest(text, isEditing).map { [weak self] text, isEditing in
            guard let self = self else { return false }
            return index == max(0, min(text~.count, self.size - 1)) && isEditing
        }.bind(to: item.hasFocus)
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

extension PinFormField {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text~
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return (updatedText.count <= size && isValid(text: updatedText)) || string.isEmpty
    }

    private func isValid(text: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", validRegex)
        return predicate.evaluate(with: text)
    }
}

extension PinFormField {
    var accessibilityKey: AccessibilityKey? {
        get { return nil }
        set {
            lblTitle.accessibilityKey = newValue
            textField.accessibilityKey = newValue
        }
    }
}

extension PinFormField {
    var titleResource: ResourceKey? {
        get { return nil }
        set { title = newValue?.value }
    }
}

protocol FormFieldDelegate: AnyObject {
    func editibleFormFieldShouldBeginEditing(_ editibleFormField: FormField) -> Bool
    func editibleFormFieldDidBeginEditing(_ editibleFormField: FormField)
    func editibleFormFieldShouldEndEditing(_ editibleFormField: FormField) -> Bool
    func editibleFormFieldDidEndEditing(_ editibleFormField: FormField)
    func editibleFormFieldDidEndEditing(_ editibleFormField: FormField,
                                        reason: UITextField.DidEndEditingReason)
    func editibleFormFieldShouldClear(_ editibleFormField: FormField) -> Bool
    func editibleFormFieldShouldReturn(_ editibleFormField: FormField) -> Bool
}

extension PinFormField: UITextFieldDelegate {
    func textFieldDidEndEditing(_: UITextField) {
        delegate?.editibleFormFieldDidEndEditing(self)
    }

    func textFieldDidBeginEditing(_: UITextField) {
        delegate?.editibleFormFieldDidBeginEditing(self)
    }

    func textFieldShouldClear(_: UITextField) -> Bool {
        return delegate?.editibleFormFieldShouldClear(self) ?? true
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        return delegate?.editibleFormFieldShouldReturn(self) ?? true
    }

    func textFieldShouldEndEditing(_: UITextField) -> Bool {
        return delegate?.editibleFormFieldShouldEndEditing(self) ?? true
    }

    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        return delegate?.editibleFormFieldShouldBeginEditing(self) ?? true
    }

    func textFieldDidEndEditing(_: UITextField, reason: UITextField.DidEndEditingReason) {
        delegate?.editibleFormFieldDidEndEditing(self, reason: reason)
    }
}

extension FormFieldDelegate {
    func editibleFormFieldShouldBeginEditing(_: FormField) -> Bool {
        return true
    }

    func editibleFormFieldDidBeginEditing(_: FormField) {
        // Intentionally unimplemented...
    }

    func editibleFormFieldShouldEndEditing(_: FormField) -> Bool {
        return true
    }

    func editibleFormFieldDidEndEditing(_: FormField) {
        // Intentionally unimplemented...
    }

    func editibleFormFieldDidEndEditing(_: FormField,
                                        reason _: UITextField.DidEndEditingReason) {
        // Intentionally unimplemented...
    }

    func editibleFormFieldShouldClear(_: FormField) -> Bool {
        return true
    }

    func editibleFormFieldShouldReturn(_: FormField) -> Bool {
        return true
    }
}
