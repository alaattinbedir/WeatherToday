//
//  UIViewController+Overlay.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

class OverlayView: UIView {
    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        generalInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        generalInit()
    }

    private func generalInit() {
        backgroundColor = .lightBlack
        alpha = 0.0
    }
}

protocol OverlayViewPresentable {
    func showOverlayView()
    func hideOverlayView()
}

extension UIViewController: OverlayViewPresentable {
    func showOverlayView() {
        if !view.subviews.contains { $0 is OverlayView } {
            let overlayView = OverlayView()
            view.addSubview(overlayView)
            overlayView.snp.makeConstraints { $0.edges.equalToSuperview() }
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.2) {
                overlayView.alpha = 1.0
            }
        }
    }

    func hideOverlayView() {
        if let overlayView = view.subviews.last as? OverlayView {
            UIView.animate(withDuration: 0.2, animations: { overlayView.alpha = 0.0 }, completion: { _ in
                overlayView.removeFromSuperview()
            })
        }
    }
}

extension UIViewController {
    func hideParentOverlayView() {
        presentingViewController?.parent?.hideOverlayView()
    }
}
