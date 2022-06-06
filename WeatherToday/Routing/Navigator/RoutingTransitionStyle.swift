//
//  RoutingTransitionStyle.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

enum RoutingTransitionStyle: Equatable {
    private static let modalDelegate = ModalTransitioningDelegate()
    private static let modalFullWidthDelegate = ModalTransitioningDelegate(modalWidthScale: 1.0)
    private static let modalFullWidthHeightDelegate = ModalTransitioningDelegate(modalWidthScale: 1.0, modalHeightScale: 1.0)
    private static let modalHalfHeightDelegate = ModalTransitioningDelegate(modalHeightScale: 0.5)
    private static let modalHalfHeightFullWidthDelegate = ModalTransitioningDelegate(modalWidthScale: 1.0, modalHeightScale: 0.5)
    private static let modalTwoThirdsHeightFullWidthDelegate = ModalTransitioningDelegate(modalWidthScale: 1.0, modalHeightScale: 0.7)

    case none
    case modal
    case modalFullWidth
    case modalFullWidthHeight
    case modalFullWidthHeightWithNavigation
    case modalHalfHeight
    case modalHalfHeightFullWidth
    case modalTwoThirdsHeightFullWidth
    case custom(transitioningDelegate: ModalTransitioningDelegate)

    func isModal() -> Bool {
        switch self {
        case .none:
            return false
        case .modal, .modalFullWidth, .modalFullWidthHeight, .modalFullWidthHeightWithNavigation, .modalHalfHeight, .modalHalfHeightFullWidth,
             .modalTwoThirdsHeightFullWidth, .custom:
            return true
        }
    }

    func getDelegate() -> UIViewControllerTransitioningDelegate? {
        switch self {
        case .none:
            return nil
        case .modal:
            return RoutingTransitionStyle.modalDelegate
        case .modalFullWidth:
            return RoutingTransitionStyle.modalFullWidthDelegate
        case .modalFullWidthHeight, .modalFullWidthHeightWithNavigation:
            return RoutingTransitionStyle.modalFullWidthHeightDelegate
        case .modalHalfHeight:
            return RoutingTransitionStyle.modalHalfHeightDelegate
        case .modalHalfHeightFullWidth:
            return RoutingTransitionStyle.modalHalfHeightFullWidthDelegate
        case .modalTwoThirdsHeightFullWidth:
            return RoutingTransitionStyle.modalTwoThirdsHeightFullWidthDelegate
        case let .custom(transitioningDelegate):
            return transitioningDelegate
        }
    }

    var wrapWithNavigationController: Bool {
        switch self {
        case .modalFullWidthHeightWithNavigation:
            return true
        default:
            return false
        }
    }
}
