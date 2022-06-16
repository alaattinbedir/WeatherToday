//
//  UIWindow+Transitions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

extension UIWindow {
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        var transitionWindow: UIWindow?
        if let background = options.background {
            transitionWindow = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case let .customView(view):
                transitionWindow?.rootViewController = UIViewController.newController(withView: view,
                                                                                      frame: transitionWindow?.bounds ?? .zero)
            case let .solidColor(color):
                transitionWindow?.backgroundColor = color
            }
            transitionWindow?.makeKeyAndVisible()
        }

        layer.add(options.animation, forKey: kCATransition)
        rootViewController = controller
        makeKeyAndVisible()

        if let transitionWindow = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 + options.duration) {
                transitionWindow.removeFromSuperview()
            }
        }
    }
}

extension UIViewController {
    static func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }

    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
}

struct TransitionOptions {
    public var duration: TimeInterval
    public var direction: Direction
    public var style: Curve
    public var background: Background?

    public init(direction: Direction = .toRight,
                style: Curve = .custom(0, 1, 0.5, 1.0),
                duration: TimeInterval = 0.4) {
        self.direction = direction
        self.style = style
        self.duration = duration
    }

    internal var animation: CATransition {
        let transition = direction.transition()
        transition.duration = duration
        transition.timingFunction = style.function
        return transition
    }
}

enum Curve {
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case custom(Float, Float, Float, Float)

    internal var function: CAMediaTimingFunction {
        switch self {
        case .linear:
            return CAMediaTimingFunction(name: .linear)
        case .easeIn:
            return CAMediaTimingFunction(name: .easeIn)
        case .easeOut:
            return CAMediaTimingFunction(name: .easeOut)
        case .easeInOut:
            return CAMediaTimingFunction(name: .easeInEaseOut)
        case let .custom(cpx1, cpy1, cpx2, cpy2):
            return CAMediaTimingFunction(controlPoints: cpx1, cpy1, cpx2, cpy2)
        }
    }
}

enum Direction {
    case fade
    case toTop
    case toBottom
    case toLeft
    case toRight

    internal func transition() -> CATransition {
        let transition = CATransition()
        transition.type = .push
        switch self {
        case .fade:
            transition.type = .fade
            transition.subtype = nil
        case .toLeft:
            transition.subtype = .fromLeft
        case .toRight:
            transition.subtype = .fromRight
        case .toTop:
            transition.subtype = .fromTop
        case .toBottom:
            transition.subtype = .fromBottom
        }
        return transition
    }
}

enum Background {
    case solidColor(_: UIColor)
    case customView(_: UIView)
}
