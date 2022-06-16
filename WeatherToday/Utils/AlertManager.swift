//
//  AlertManager.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Bond
import Foundation
import IQKeyboardManagerSwift
import ReactiveKit
import TextAttributes

class AlertManager {
    static let shared = AlertManager()
    static var fieldErrorViewHeight = Observable<CGFloat>(0.0)

    var warningView: DefaultWarningView?
    var fieldErrorView: FieldErrorView?
    var keyboardConstraint: NSLayoutConstraint?
    var keyboardHeight: CGFloat = 0.0
    let bag = DisposeBag()

    func build(with model: AlertModel) -> DefaultWarningView? {
        warningView = DefaultWarningView(model: model, attributes: nil)
        warningView?.dismissHandler = { [weak self] in
            self?.warningView = nil
        }
        return warningView
    }

    func show(fieldAlert: FieldAlertModel,
              for field: BaseFormField? = nil,
              in superview: UIView,
              onTopOf view: UIView? = nil,
              bottomOf: UIView? = nil) {
        guard let fieldErrorView = fieldErrorView else { return }

        if fieldErrorView.superview != superview {
            fieldErrorView.removeFromSuperview()
            superview.addSubview(fieldErrorView)
            fieldErrorView.text = fieldAlert.message

            fieldErrorView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                let offset = FormFieldStyle.generalMargin / 2.0
                if let view = view {
                    make.bottom.lessThanOrEqualTo(view.snp.top).offset(-offset).priority(.high)
                } else {
                    make.bottom.equalToSuperview().priority(751)
                }
                if let bottomOf = bottomOf {
                    make.top.equalTo(bottomOf.snp.bottom).offset(offset).priority(.medium)
                }
                make.bottom.lessThanOrEqualTo(superview.safeArea.bottom)
            }
            superview.layoutIfNeeded()
            removeKeyboardNotifications()
            observeKeyboardNotifications()
            keyboardConstraint?.isActive = IQKeyboardManager.shared.keyboardShowing
            AlertManager.fieldErrorViewHeight.value = fieldErrorView.bounds.height            
            AnimationHelper.springAnimation(with: 0.5, animations: {
                superview.layoutIfNeeded()
            }, completion: nil)
            fieldErrorView.animateContainer()
        } else {
            fieldErrorView.text = fieldAlert.message
        }
    }

    func hideFieldAlert() {
        fieldErrorView?.removeFromSuperview()
        keyboardConstraint?.isActive = false
        AlertManager.fieldErrorViewHeight.value = 0.0
        removeKeyboardNotifications()
    }

    private func observeKeyboardNotifications() {
        NotificationCenter.default
            .reactive
            .notification(name: UIApplication.keyboardWillShowNotification)
            .observeNext { [weak self] _ in
                self?.keyboardConstraint?.isActive = true
                self?.fieldErrorView?.superview?.layoutIfNeeded()
            }.dispose(in: bag)
        NotificationCenter.default
            .reactive
            .notification(name: UIApplication.keyboardWillHideNotification)
            .observeNext { [weak self] _ in
                self?.keyboardConstraint?.isActive = false
                self?.fieldErrorView?.superview?.layoutIfNeeded()
            }.dispose(in: bag)
        keyboardConstraint?.isActive = false
    }

    private func removeKeyboardNotifications() {
        bag.dispose()
    }
}

extension StatusType {
    var icon: UIImage {
        switch self {
        case .success:
            return #imageLiteral(resourceName: "resultSuccess").with(size: 40)
        case .confirm:
            return #imageLiteral(resourceName: "warning").with(size: 40)
        case .inform:
            return #imageLiteral(resourceName: "infoIcon").with(size: 40)
        case .warning:
            return #imageLiteral(resourceName: "warning").with(size: 40)
        case .error, .unknown:
            return #imageLiteral(resourceName: "warning").with(size: 40)
        }
    }
}

extension DefaultWarningView {
    func delegate(_ delegate: WarningViewDelegate) -> DefaultWarningView {
        self.delegate = delegate
        return self
    }
}
