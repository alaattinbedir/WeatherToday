//
//  AnimationHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import UIKit

class AnimationHelper {
    class func springAnimation(with duration: TimeInterval,
                               delay: TimeInterval = 0.0,
                               usingSpringWithDamping dampingRatio: CGFloat = 10.0,
                               initialSpringVelocity velocity: CGFloat = 0.0,
                               options: UIView.AnimationOptions = [.curveLinear],
                               animations: @escaping () -> Void,
                               completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: velocity,
                       options: options,
                       animations: animations,
                       completion: completion)
    }

    class func animate(with function: TimingFunction,
                       animations: @escaping () -> Void,
                       completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        CATransaction.setAnimationDuration(function.duration)
        CATransaction.setAnimationTimingFunction(function.function)
        UIView.animate(withDuration: function.duration, animations: animations)
        CATransaction.commit()
    }
}

enum TimingFunction {
    case onBoardingStart
    case onBoardingLogo
    case onBoardingImage
    case onBoardingTextPosition
    case onBoardingTextOpacity
    case welcomeArrowUp
    case welcomeArrowDown
    case mainPageQuickMenuScrollRight
    case mainPageQuickMenuScrollLeft
    case otpAlert
    case fieldError

    var function: CAMediaTimingFunction {
        switch self {
        case .onBoardingStart:
            return CAMediaTimingFunction(controlPoints: 0.42, 0, 1, 1)
        case .onBoardingLogo:
            return CAMediaTimingFunction(controlPoints: 0.6, 0.2, 0.32, 0.95)
        case .onBoardingImage:
            return CAMediaTimingFunction(controlPoints: 0.42, 0, 0.58, 1)
        case .onBoardingTextPosition, .onBoardingTextOpacity:
            return CAMediaTimingFunction(controlPoints: 0, 0, 0.35, 1.05)
        case .welcomeArrowUp, .welcomeArrowDown:
            return CAMediaTimingFunction(controlPoints: 0.28, 0.28, 0.45, 1.07)
        case .mainPageQuickMenuScrollLeft, .mainPageQuickMenuScrollRight:
            return CAMediaTimingFunction(controlPoints: 0.28, 0.28, 0.45, 1.07)
        case .otpAlert:
            return CAMediaTimingFunction(controlPoints: 0.35, 1.0, 0.6, 1.0)
        case .fieldError:
            return CAMediaTimingFunction(controlPoints: 0.0, 0.7, 0.3, 1.1)
        }
    }

    var duration: CFTimeInterval {
        switch self {
        case .onBoardingStart:
            return 0.45
        case .onBoardingLogo:
            return 0.78
        case .onBoardingImage:
            return 4.0
        case .onBoardingTextPosition, .welcomeArrowUp:
            return 1.0
        case .onBoardingTextOpacity, .welcomeArrowDown:
            return 0.7
        case .mainPageQuickMenuScrollRight, .mainPageQuickMenuScrollLeft:
            return 0.8
        case .otpAlert:
            return 0.2
        case .fieldError:
            return 0.35
        }
    }
}
