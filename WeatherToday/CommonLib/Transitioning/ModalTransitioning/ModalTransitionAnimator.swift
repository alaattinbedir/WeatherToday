//
//  ModalTransitionAnimator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import UIKit

class ModalTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var type: ModalTransitionAnimatorType

    init(type: ModalTransitionAnimatorType) {
        self.type = type
    }

    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            from.required().view.frame.origin.y = 800
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
}

internal enum ModalTransitionAnimatorType {
    case present
    case dismiss
}

