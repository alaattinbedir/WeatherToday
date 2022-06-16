//
//  DKWarningViewController.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import IQKeyboardManagerSwift
import ReactiveKit
import Bond
import SnapKit
import UIKit

typealias DKActionHandler = (DKWarningViewController) -> Void

class DKWarningViewController: BaseVC<DKWarningViewModel> {
    @IBOutlet var mainView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var messageTextView: UITextView! {
        didSet {
            messageTextView.isScrollEnabled = false
        }
    }

    @IBOutlet var buttonsStackView: UIStackView!
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var messageTextViewBottomConstaint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data as? DKWarningViewModelData {
            viewModel.attributes = data.attributes
            viewModel.model = data.model
            viewModel.buttonTappedHandler = data.buttonTappedHandler
            updateView()
            DispatchQueue.main.async {
                self.messageTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
            }
        }
    }

    open func addActionButtons() {
        guard let model = viewModel.model else { return }
        for index in 0 ..< model.buttons.count {
            let btnAction = FormButton(buttonStyle: model.buttons[index].style)
            btnAction.snp.makeConstraints { $0.height.equalTo(FormFieldStyle.buttonHeight) }
            if model.buttons.count == 1 {
                let title = model.buttons[index].resource.value.isEmpty ? NSLocalizedString("GeneralButton.OK", comment: "") : model.buttons[index].resource.value
                btnAction.setTitle(title, for: .normal)
            } else {
                btnAction.setTitle(model.buttons[index].resource.value, for: .normal)
            }
            btnAction.reactive.tap.observeNext { [weak self] _ in
                guard let self = self else { return }
                guard let handler = self.viewModel.buttonTappedHandler else { return }
                handler(index)
            }.dispose(in: bag)
            btnAction.accessibilityIdentifier = "Button\(index)"
            buttonsStackView.addArrangedSubview(btnAction)
        }
    }

    func updateView() {
        if let attributes = viewModel.attributes, let model = viewModel.model {
            lblTitle.attributedText = NSMutableAttributedString(string: model.title~, attributes: attributes)
            messageTextView.attributedText = NSMutableAttributedString(string: model.message~, attributes: attributes)
        } else {
            lblTitle.text = viewModel.model?.title
            if let isHtml = viewModel.model?.isHtml, isHtml {
                messageTextView.setHTMLFromStringWithoutFont(htmlText: viewModel.model?.message ?? "")
            } else {
                messageTextView.text = viewModel.model?.message
                messageTextView.font = viewModel.model?.textFont ?? AppFont.bold17
            }
        }
        configureTextView()
        imageView.isHidden = viewModel.model?.icon == nil
        imageView.image = viewModel.model?.icon
        btnClose.isHidden = !(viewModel.model?.enableCloseButton ?? true)
        addActionButtons()
        messageTextView.setContentOffset(.zero, animated: false)
        mainView.isHidden = false
        messageTextView.textAlignment = viewModel.model?.textAlignment ?? .center
        btnClose.reactive.tap.bind(to: self) { _ in
            NavigationRouter.dismiss()
        }.dispose(in: bag)
    }

    open func show(in controller: UIViewController, data: ViewModelData) {
        NavigationRouter.present(from: controller,
                                 to: self,
                                 presentationStyle: .overCurrentContext,
                                 data: data)
    }

    func show(data: ViewModelData) {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return }
        if let viewController = rootVC.alertPresentableViewController {
            show(in: viewController, data: data)
        }
    }

    override func setAccessibilityIdentifiers() {
        lblTitle.accessibilityKey = .popupTitle
        messageTextView.accessibilityKey = .popupDescription
    }

    private func configureTextView() {
        guard let currentText = messageTextView.text else { return }
        let currentTextHeight = currentText.height(font: messageTextView.font ?? AppFont.bold17, width: messageTextView.frame.width)
        let maxMessageTextViewHeight = getMaxMessageTextViewHeight()

        if currentTextHeight > maxMessageTextViewHeight {
            let newBottomConstraint = NSLayoutConstraint(item: messageTextViewBottomConstaint.firstItem as Any,
                                                         attribute: messageTextViewBottomConstaint.firstAttribute,
                                                         relatedBy: .equal,
                                                         toItem: messageTextViewBottomConstaint.secondItem,
                                                         attribute: messageTextViewBottomConstaint.secondAttribute,
                                                         multiplier: messageTextViewBottomConstaint.multiplier,
                                                         constant: messageTextViewBottomConstaint.constant)
            messageTextViewBottomConstaint.isActive = false
            newBottomConstraint.isActive = true
            messageTextView.isScrollEnabled = true
        }
    }

    private func getMaxMessageTextViewHeight() -> CGFloat {
        var safeFrame: CGFloat = 0
        let window = UIApplication.shared.windows[0]
        if #available(iOS 11.0, *) {
            safeFrame = window.safeAreaLayoutGuide.layoutFrame.height
        } else {
            safeFrame = UIScreen.main.bounds.height
        }
        let topViewHeight: CGFloat = 114.0
        let bottomViewHeight: CGFloat = 66.0
        let tableViewSpacingHeight: CGFloat = 60.0
        let topBottomSpaceHeight: CGFloat = 80.0
        let viewsHeight = lblTitle.frame.height + buttonsStackView.frame.height
        let height = safeFrame - (topViewHeight + tableViewSpacingHeight + viewsHeight + bottomViewHeight + topBottomSpaceHeight)
        return height
    }
}
