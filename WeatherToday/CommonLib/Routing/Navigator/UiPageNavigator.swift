//
//  UiPageNavigator.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit
import SafariServices

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

        let (showAsPopup, openTransitionStyle, wrapWithNavigationController) = findTransitionStyle(to: to, isPopup: isPopup, transitionStyle: transitionStyle)

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
                                      wrapWithNavigationController: wrapWithNavigationController,
                                      animated: animated,
                                      present: showAsPopup,
                                      replace: replace,
                                      completion: popupCompletion)

        case let .toViewController(toVCType, hidesBottomBarWhenPushed):
            guard let fromVC = fromVC else { return }
            let controller = toVCType.init()
            controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
            configureController(openTransitionStyle, controller, showAsPopup, fromVC)

            NavigationRouter.navigate(fromVC: fromVC,
                                      destination: .vc(controller),
                                      routingEnum: to,
                                      wrapWithNavigationController: wrapWithNavigationController,
                                      animated: animated,
                                      present: showAsPopup,
                                      replace: replace,
                                      completion: popupCompletion)
        case let .toTab(tabIndex, _):
            if clearNavigationStack ?? false {
                (tabbar?.viewControllers?[tabIndex] as? UINavigationController)?.popToRootViewController(animated: false)
            }
            ((tabbar?.viewControllers?[tabIndex] as? UINavigationController)?.topViewController as? BaseVC)?.routingEnum = to
            tabbar?.selectedIndex = tabIndex
        case let .safari(url):
            guard let fromVC = fromVC else { return }
            let saf = SFSafariViewController(url: URL(string: url).required())
            fromVC.present(saf, animated: true, completion: popupCompletion)
        case .popPage:
            if let presentedViewController = fromVC?.presentedViewController {
                presentedViewController.dismiss(animated: true, completion: popupCompletion)
            } else if let navigationContoller = fromVC as? UINavigationController {
                navigationContoller.popViewController(animated: animated)
            } else if let navigationContoller = fromVC?.navigationController {
                navigationContoller.popViewController(animated: animated)
            }
        case let .openUrl(url, params):
            var query: String = ""
            if let params = params, params.count > 0 {
                query = URLQueryBuilder(params: params).build()
            }
            if let url = URL(string: "\(url)\(query)") {
                UIApplication.shared.open(url)
            }
        case let .openApp(url, params, appstoreUrl):
            var query: String = ""
            if let params = params, params.count > 0 {
                query = URLQueryBuilder(params: params).build()
            }
            if let appDeepLinkUrl = URL(string: "\(url)\(query)") {
                if UIApplication.shared.canOpenURL(appDeepLinkUrl) {
                    UIApplication.shared.open(appDeepLinkUrl)
                } else if let appStoreUrl = URL(string: appstoreUrl) {
                    UIApplication.shared.open(appStoreUrl)
                }
            }
        case let .popup(title, message, type, buttonActions):
            WarningView(title: title, message: message, type: type, buttonActions: buttonActions).show()
        case let .popToRoot(animated):
            if let navigationContoller = fromVC?.navigationController {
                navigationContoller.popToRootViewController(animated: animated)
            }
        }
    }

    private func configureController(_ openTransitionStyle: RoutingTransitionStyle, _ controller: BaseViewController, _ showAsPopup: Bool, _: UIViewController) {
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

    private func findTransitionStyle(to: RoutingEnum, isPopup: Bool?, transitionStyle: RoutingTransitionStyle?) ->
        (showAsPopup: Bool, openTransitionStyle: RoutingTransitionStyle, wrapWithNavigationController: Bool) {
        var showAsPopup: Bool? = isPopup
        var openTransitionStyle = transitionStyle
        var wrapWithNavigationController: Bool? = transitionStyle?.wrapWithNavigationController

        if let transition = to.transitionStyle(for: to) {
            showAsPopup = isPopup ?? transition.isModal
            openTransitionStyle = transitionStyle ?? transition.transitionStyle
            wrapWithNavigationController = openTransitionStyle?.wrapWithNavigationController ?? false
        }

        return (showAsPopup ?? false, openTransitionStyle ?? .none, wrapWithNavigationController ?? false)
    }
}
