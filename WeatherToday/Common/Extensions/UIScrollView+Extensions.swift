//
//  UIScrollView+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

extension UIScrollView {
    func scrollToView(view: UIView, axis: NSLayoutConstraint.Axis = .vertical, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin,
                                                 to: self)
            switch axis {
            case .horizontal:
                scrollRectToVisible(CGRect(x: childStartPoint.x,
                                           y: 0,
                                           width: frame.width,
                                           height: 1),
                                    animated: animated)
            case .vertical:
                scrollRectToVisible(CGRect(x: 0,
                                           y: childStartPoint.y,
                                           width: 1,
                                           height: frame.height),
                                    animated: animated)
            default:
                break
            }
        }
    }

    func scrollTop(of view: UIView?, animated: Bool = true, offset: CGFloat = 0.0) {
        guard let view = view else { return }
        let contentOffsetY = (view.superview?.convert(view.frame.origin, to: self).y)~ - offset
        setContentOffset(CGPoint(x: contentOffset.x, y: contentOffsetY), animated: animated)
    }

    func scrollBottom(of view: UIView?, animated: Bool = true, offset: CGFloat = 0.0) {
        guard let view = view else { return }
        let viewBottomPoint = CGPoint(x: view.frame.origin.x,
                                      y: view.frame.origin.y + view.frame.height)
        let contentOffsetY = (view.superview?.convert(viewBottomPoint, to: self).y)~ + offset
        setContentOffset(CGPoint(x: contentOffset.x,
                                 y: contentOffsetY),
                         animated: animated)
    }
}
