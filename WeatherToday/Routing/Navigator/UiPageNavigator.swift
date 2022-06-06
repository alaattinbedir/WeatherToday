//
//  UiPageNavigator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

class UiPageNavigator: PageNavigator {
    // swiftlint:disable cyclomatic_complexity function_body_length
    func navigate(fromVC: UIViewController?,
                  to: RoutingEnum,
                  clearNavigationStack: Bool?,
                  openOwnTab: Bool?,
                  tabIndex: Int?,
                  replace: Bool,
                  animated: Bool,
                  isPopup: Bool?,
                  popupCompletion: (() -> Void)?,
                  transitionStyle: RoutingTransitionStyle?) {


        let window = UIApplication.shared.keyWindow
        let tabbar = window?.rootViewController as? UITabBarController
        var openOwnTab = openOwnTab
        var fromVC = fromVC

        if fromVC == nil, let rootViewController = window?.rootViewController {
            if rootViewController is UITabBarController {
                openOwnTab = true
            } else {
                fromVC = rootViewController
            }
        }

        if let tabbar = tabbar, let openOwnTab = openOwnTab, openOwnTab {
            if let tabIndex = tabIndex {
                tabbar.selectedIndex = tabIndex
            }
            if let rootViewController = (tabbar.selectedViewController as? UINavigationController)?.viewControllers.last {
                fromVC = rootViewController
            }
        }

        var currentPresentedVC = fromVC?.presentedViewController

        if clearNavigationStack ?? false {
            currentPresentedVC?.dismiss(animated: animated, completion: nil)
            currentPresentedVC = nil
            if let navigationContoller = fromVC?.navigationController {
                navigationContoller.popToRootViewController(animated: false)
                fromVC = navigationContoller
            } else if let navigationContoller = fromVC as? UINavigationController {
                navigationContoller.popToRootViewController(animated: false)
                fromVC = navigationContoller
            } else if let tabbar = tabbar, let nav = tabbar.selectedViewController as? UINavigationController {
                nav.popToRootViewController(animated: false)
            }
        }

        let navigationInfo = to.getNavigationInfo(fromVC: fromVC)

        switch navigationInfo {
        case .none:
            print("none")
        case let .toStoryBoard(toStoryboard, toVC, _):
            guard let fromVC = fromVC else { return }
            NavigationRouter.navigate(fromVC: fromVC,
                                      destination: .storyboard(toStoryboard, toVC),
                                      routingEnum: to,
                                      animated: animated,
                                      replace: replace,
                                      completion: popupCompletion)

        case let .toViewController(toVCType, hidesBottomBarWhenPushed):
            guard let fromVC = fromVC else { return }
            let controller = toVCType.init()
            controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed

            NavigationRouter.navigate(fromVC: fromVC,
                                      destination: .vc(controller),
                                      routingEnum: to,
                                      animated: animated,
                                      replace: replace,
                                      completion: popupCompletion)
        case .popPage:
            if let presentedViewController = fromVC?.presentedViewController {
                presentedViewController.dismiss(animated: true, completion: popupCompletion)
            } else if let navigationContoller = fromVC as? UINavigationController {
                navigationContoller.popViewController(animated: animated)
            } else if let navigationContoller = fromVC?.navigationController {
                navigationContoller.popViewController(animated: animated)
            }
        case let .popToRoot(animated):
            if let navigationContoller = fromVC?.navigationController {
                navigationContoller.popToRootViewController(animated: animated)
            }
        }
    }

    private func configureController(_ openTransitionStyle: RoutingTransitionStyle, _ controller: MDViewController, _ showAsPopup: Bool, _: UIViewController) {
        if openTransitionStyle.isModal() {
            controller.modalPresentationStyle = .custom
            controller.transitioningDelegate = openTransitionStyle.getDelegate()
        }

        if openTransitionStyle == .none, showAsPopup {
            controller.providesPresentationContextTransitionStyle = true
            controller.definesPresentationContext = true
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
        }
    }
}
