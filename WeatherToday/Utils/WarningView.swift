//
//  WarningView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import IQKeyboardManagerSwift
import TextAttributes

protocol WarningViewDelegate: AnyObject {
    func onAlertButtonPressed(_ code: Alert?, buttonIdentifier: AlertButtonIdentifier)
}

class WarningView {
    var model: AlertModel?
    weak var delegate: WarningViewDelegate?
    var alert: DKWarningViewController
    var attributes: TextAttributes?
    var buttonStyle: ((UIButton, Int) -> Void)?
    var dismissHandler: (() -> Void)?

    init(model: AlertModel, delegate: WarningViewDelegate? = nil, attributes: TextAttributes? = nil) {
        self.model = model
        self.delegate = delegate
        alert = DKWarningViewController()
        self.attributes = attributes
    }

    func show() {
        guard let model = model else { return }
        IQKeyboardManager.shared.resignFirstResponder()
        alert.show(data: DKWarningViewModelData(attributes: attributes,
                                                model: model,
                                                handler: buttonHandler))
    }

    func buttonHandler(index: Int) {
        guard let model = model else { return }
        alert.dismiss(animated: true) { [weak self] in
            self?.dismissHandler?()
            let alertCode = Alert(rawValue: model.code)
            self?.delegate?.onAlertButtonPressed(alertCode, buttonIdentifier: model.buttons[index].identifier)
        }
    }
}

class DefaultWarningView: WarningView {}
