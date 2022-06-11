//
//  AnimationHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

class AnimationHelper {
    class func springAnimation(
        with duration: TimeInterval,
        delay: TimeInterval = 0.0,
        usingSpringWithDamping dampingRatio: CGFloat = 10.0,
        initialSpringVelocity velocity: CGFloat = 0.0,
        options: UIView.AnimationOptions = [.curveLinear],
        animations: @escaping () -> Swift.Void,
        completion: ((Bool) -> Swift.Void)? = nil
    ) {
        UIView
            .animate(withDuration: duration, delay: delay, usingSpringWithDamping: dampingRatio,
                     initialSpringVelocity: velocity, options: options, animations: animations, completion: completion)
    }
}

