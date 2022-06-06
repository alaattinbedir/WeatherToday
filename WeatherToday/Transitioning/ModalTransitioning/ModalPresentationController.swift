//
//  ModalPresentationController.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    var panGestureRecognizer: UIPanGestureRecognizer
    var tapGestureRecognizer: UITapGestureRecognizer
    var direction: CGFloat = 0

    var modalHeightScale: CGFloat = 0.87
    var modalWidthScale: CGFloat = 0.95
    let animationDuration = 0.2
    let cornerRadius: CGFloat = 10
    var disableGestures = false

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        tapGestureRecognizer = UITapGestureRecognizer()
        panGestureRecognizer = UIPanGestureRecognizer()
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        // Add Pan
        panGestureRecognizer.addTarget(self, action: #selector(onPan(pan:)))
        presentedViewController.view.addGestureRecognizer(panGestureRecognizer)

        presentedViewController.view.roundCorners([.topLeft, .topRight], radius: cornerRadius)
        presentedViewController.view.frame = calculateFrame(view: presentedViewController.view)

        tapGestureRecognizer.addTarget(self, action: #selector(dismissSelf(gesture:)))
        cover.isUserInteractionEnabled = true
        cover.addGestureRecognizer(tapGestureRecognizer)
    }

    var panLastPoint = CGPoint.zero
    var startY: CGFloat = 0.0
    @objc func onPan(pan: UIPanGestureRecognizer) {
        guard !disableGestures else { return }
        let endPoint = pan.translation(in: pan.view?.superview)
        switch pan.state {
        case .began:
            panLastPoint = endPoint
            startY = presentedView.required().frame.origin.y

        case .changed:
            let velocity = pan.velocity(in: pan.view?.superview)
            direction = velocity.y

            let delta = endPoint.y - panLastPoint.y
            panLastPoint = endPoint
            presentedView.required().frame.origin.y += delta

            if presentedView.required().frame.origin.y < startY {
                presentedView.required().frame.origin.y = startY
            }

        case .ended:
            panLastPoint = .zero
            if direction > 300 {
                presentedViewController.dismiss(animated: true, completion: nil)
            } else {
                changeScale()
            }

        default: break
        }
    }

    func changeScale() {
        if let presentedView = presentedView, let containerView = self.containerView {
            UIView.animate(
                withDuration: animationDuration,
                animations: {
                    let containerFrame = containerView.frame
                    let halfFrame = CGRect(
                        origin: CGPoint(
                            x: containerFrame.width * ((1 - self.modalWidthScale) / 2.0),
                            y: containerFrame.height * (1 - self.modalHeightScale)
                        ),
                        size: CGSize(
                            width: containerFrame.width * self.modalWidthScale,
                            height: containerFrame.height * self.modalHeightScale
                        )
                    )
                    presentedView.frame = halfFrame
                }, completion: { _ in /* empty */ }
            )
        }
    }

    let cover: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()

    override func presentationTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            cover.frame = presentingViewController.view.bounds
            containerView.required().addSubview(cover)

            coordinator.animate(alongsideTransition: { [unowned self] _ in
                self.cover.alpha = 0.5
            }, completion: nil)
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [unowned self] _ in
                self.cover.alpha = 0.0
            }, completion: { _ in
                self.cover.removeFromSuperview()
            })
        }
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        return calculateFrame(view: containerView.required())
    }

    @objc func dismissSelf(gesture _: UIGestureRecognizer) {
        guard !disableGestures else { return }
        presentingViewController.dismiss(animated: true, completion: nil)
    }

    private func calculateFrame(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.width * ((1 - modalWidthScale) / 2.0),
                      y: view.bounds.height * (1 - modalHeightScale),
                      width: view.bounds.width * modalWidthScale,
                      height: view.bounds.height * modalHeightScale)
    }
}
