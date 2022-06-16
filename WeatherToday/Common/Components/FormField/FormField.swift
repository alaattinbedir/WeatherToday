//
//  FormField.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import ReactiveKit
import UIKit

class FormField: UIView {
    var isEditing = Observable<Bool>(false)
    var firstSetup: Bool = true
    @IBInspectable var clearButtonEnabled: Bool = true
    @IBInspectable var cursorEnabled: Bool = true
    @IBOutlet internal var textField: CustomTextField! {
        didSet {
            textField.clearButtonMode = .whileEditing
        }
    }

    @IBOutlet internal var mainView: UIView? {
        didSet {
            setupFocusAgent()
        }
    }

    var text = Observable<String?>(nil)

    func setupFocusAgent() {
        mainView?.addTapGestureRecognizer(action: { [weak self] in
            self?.textField.becomeFirstResponder()
        })
    }

    func bind() {
        guard let textField = textField else { return }
        text.bidirectionalBind(to: textField.reactive.text)
        textField.reactive.controlEvents(.editingDidBegin).bind(to: self) { $0.editingBegin() }.dispose(in: bag)
        textField.reactive.controlEvents(.editingDidEnd).bind(to: self) { $0.editingDidEnd() }.dispose(in: bag)
    }

    private func editingBegin() {
        guard let mainView = mainView else { return }
        if !clearButtonEnabled {
            textField.clearButtonMode = .never
        }
        if !cursorEnabled {
            textField.tintColor = .clear
        }
        let color1 = UIColor.brightSkyBlue.cgColor
        let color2 = UIColor.azure.cgColor
        mainView.makeBorderGradientColor(color1: color1,
                                         color2: color2,
                                         size: CGSize(width: mainView.bounds.size.width,
                                                      height: mainView.bounds.size.height),
                                         startPoint: CGPoint(x: 0, y: 0.5),
                                         endPoint: CGPoint(x: 1, y: 0.5))
    }

    private func editingDidEnd() {
        guard let mainView = mainView else { return }
        mainView.makeBorderColorStandart(color: UIColor.clear.cgColor)
    }
}
