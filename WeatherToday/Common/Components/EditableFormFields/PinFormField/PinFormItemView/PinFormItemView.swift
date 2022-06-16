//
//  PinFormItemView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation
import ReactiveKit

class PinFormItemView: BaseFormField {
    @IBOutlet var viewIndicator: UIView!
    @IBOutlet var lblItem: UILabel!

    var textColor = Observable<UIColor>(.black)
    var errorColor = Observable<UIColor>(.red)
    var activeIndicatorColor = Observable<UIColor>(.black)
    var defaultIndicatorColor = Observable<UIColor>(.lightGray)
    var isSecure = Observable<Bool>(false)

    var text = Observable<String?>(nil)
    var isActive = Observable<Bool>(false)
    var isCurrent = Observable<Bool>(false)
    var hasFocus = Observable<Bool>(false)
    var hasError = Observable<Bool>(false)

    private var secureAnimation: DispatchWorkItem?
    private var timer: Timer?
    private var isCursorAnimationOn: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        bind()
    }

    private func bind() {
        textColor.bind(to: lblItem.reactive.textColor)
        combineLatest(isActive, hasError).observeNext { [weak self] isActive, hasError in
            guard let self = self else { return }
            if hasError {
                self.viewIndicator.backgroundColor = self.errorColor.value
            } else {
                self.viewIndicator.backgroundColor = isActive ?
                    self.activeIndicatorColor.value : self.defaultIndicatorColor.value
            }
        }.dispose(in: bag)
        combineLatest(text, isSecure).observeNext { [weak self] text, isSecure in
            guard let this = self else { return }
            let hasTextChanged = this.lblItem.text != text && this.lblItem.text != "●"
            this.lblItem.text = text
            this.secureAnimation?.cancel()
            if text != nil, isSecure {
                if this.isCurrent.value, hasTextChanged {
                    this.secureAnimation = DispatchWorkItem { [weak self] in
                        self?.lblItem.text = "●"
                    }
                    if let animationBlock = this.secureAnimation {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: animationBlock)
                    }
                } else {
                    this.lblItem.text = "●"
                }
            }
        }.dispose(in: bag)

        hasFocus.observeNext { [weak self] hasFocus in
            if hasFocus {
                self?.startTimer()
            } else {
                self?.stopTimer()
            }
        }.dispose(in: bag)
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 0.6,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc
    private func updateTimer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.1) {
                if self.isCursorAnimationOn {
                    self.viewIndicator.backgroundColor = self.hasError.value ?
                        self.errorColor.value : self.activeIndicatorColor.value
                } else {
                    self.viewIndicator.backgroundColor = self.defaultIndicatorColor.value
                }
            }
            self.isCursorAnimationOn = !self.isCursorAnimationOn
        }
    }

    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}
