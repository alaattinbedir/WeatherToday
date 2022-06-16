//
//  EasyTip+Extension.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import EasyTipView

extension EasyTipView {
    static func showMessage(text: String,
                            view: UIView,
                            desiredButton: UIButton,
                            arrowPosition: EasyTipView.ArrowPosition = EasyTipView.ArrowPosition.top) {
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = AppFont.semibold12
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = UIColor.gradient(startColor: UIColor.seaBlue,
                                                               endColor: UIColor.cyan,
                                                               style: .horizontal,
                                                               size: CGSize(width: 300, height: 300)) ?? .seaBlue
        preferences.drawing.arrowPosition = arrowPosition

        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1.5
        preferences.animating.dismissDuration = 1.5
        preferences.positioning.bubbleInsets.left = 30

        let tipView = EasyTipView(text: text, preferences: preferences)
        tipView.show(forView: view)
        desiredButton.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            tipView.dismiss()
            desiredButton.isUserInteractionEnabled = true
        }
    }
}
