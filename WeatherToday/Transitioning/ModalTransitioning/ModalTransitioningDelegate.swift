//
//  ModalTransitioningDelegate.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import UIKit

class ModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    let modalHeightScale: CGFloat
    let modalWidthScale: CGFloat

    init(modalWidthScale: CGFloat = 0.95, modalHeightScale: CGFloat = 0.87) {
        self.modalWidthScale = modalWidthScale
        self.modalHeightScale = modalHeightScale
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalTransitionAnimator(type: .dismiss)
    }

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source _: UIViewController) -> UIPresentationController? {
        let controller = ModalPresentationController(presentedViewController: presented, presenting: presenting)
        controller.modalHeightScale = modalHeightScale
        controller.modalWidthScale = modalWidthScale
        return controller
    }
}
