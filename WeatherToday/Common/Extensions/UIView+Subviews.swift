//
//  UIView+Subviews.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

extension UIView {
    var superScrollableView: UIScrollView? {
        return findSuperScrollableView()
    }

    func getAllSubviews<T>(type: T.Type) -> [T] where T: UIView {
        let subviews = self.subviews.compactMap { view -> [T]? in
            if let view = view as? T {
                return [view]
            } else {
                return view.getAllSubviews(type: type)
            }
        }.flatMap { $0 }
        return subviews.sorted {
            ($0.superview?.convert($0.frame.origin, to: self).y)~ < ($1.superview?.convert($1.frame.origin, to: self).y)~
        }
    }

    func getValidatableViews() -> [ValidatableView] {
        let subviews = self.subviews.compactMap { view -> [ValidatableView]? in
            if let view = view as? ValidatableView {
                var validatableViews = [view]
                validatableViews.append(contentsOf: view.getValidatableViews())
                return validatableViews
            } else {
                return view.getValidatableViews()
            }
        }.flatMap { $0 }
        return subviews.sorted {
            ($0.superview?.convert($0.frame.origin, to: self).y)~ < ($1.superview?.convert($1.frame.origin, to: self).y)~
        }
    }

    private func findSuperScrollableView() -> UIScrollView? {
        var superview = self.superview

        while superview != nil {
            if let scrollView = superview as? UIScrollView {
                return scrollView
            }
            superview = superview?.superview
        }
        return nil
    }
}
