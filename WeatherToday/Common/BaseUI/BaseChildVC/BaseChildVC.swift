//
//  BaseChildVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import ReactiveKit
import UIKit

protocol TabBarItemable {
    var tabItem: TabItem { get }
}

class BaseChildVC<T>: BaseVC<T> where T: BaseViewModel {
    var pageLogo = Observable<UIImage?>(nil)
    var pageTitle = Observable<String?>("")
    var pageStep = Observable<String?>("")
    var pageBackgroundColor = Observable<UIColor>(.white)
    var leftBarButtonItems = Observable<[NavigationBarButton]>([])
    var rightBarButtonItems = Observable<[NavigationBarButton]>([])
    var willShowNavigationBar = Observable<Bool>(true)
    var willShowTitleAndStep = Observable<Bool>(false)
    var willShowLogo = Observable<Bool>(false)
    var navBarBackgroundImage = Observable<UIImage>(UIImage())
    var navBarBackgroundColor = Observable<UIColor>(.clear)
    var hasBondToRoot = false

    private func bindRootItems() {
        guard let rootVC = getRootVC() else { return }
        pageLogo.dropFirst(1).bind(to: rootVC.pageLogo)
        pageTitle.bind(to: rootVC.pageTitle)
        pageStep.bind(to: rootVC.pageStep)
        pageBackgroundColor.dropFirst(1).bind(to: rootVC.pageBackgroundColor)
        leftBarButtonItems.dropFirst(1).bind(to: rootVC.leftBarButtonItems)
        rightBarButtonItems.dropFirst(1).bind(to: rootVC.rightBarButtonItems)
        willShowNavigationBar.dropFirst(1).bind(to: rootVC.willShowNavigationBar)
        willShowTitleAndStep.bind(to: rootVC.willShowTitleStepView)
        willShowLogo.bind(to: rootVC.willShowLogo)
        navBarBackgroundImage.dropFirst(1).bind(to: rootVC.navBarBackgroundImage)
        navBarBackgroundColor.dropFirst(1).bind(to: rootVC.navBarBackgroundColor)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !hasBondToRoot {
            bindRootItems()
            hasBondToRoot = true
        }
        if let navigationController = navigationController {
            getRootVC()?.activeNavigationController = navigationController
        }
        setRootProperties()
    }

    private func setRootProperties() {
        pageLogo.value = getPageLogo()
        pageTitle.value = getPageTitle()
        pageStep.value = getPageStep()
        pageBackgroundColor.value = getPageBackgroundColor()
        leftBarButtonItems.value = getLeftBarButtonItems()
        rightBarButtonItems.value = getRightBarButtonItems()
        navBarBackgroundImage.value = getNavigationBarBgImage()
        navBarBackgroundColor.value = getNavigationBarBgColor()
        willShowNavigationBar.value = getWillShowNavigationBar()
        willShowTitleAndStep.value = getWillShowTitleAndStep()
        willShowLogo.value = getWillShowLogo()
    }

    override func getRootVC() -> BaseRootVC? {
        var viewController: UIViewController? = self

        while viewController?.parent != nil {
            if let rootVC = viewController?.parent as? BaseRootVC {
                return rootVC
            }
            viewController = viewController?.parent
        }
        if let rootVC = presentingViewController?.parent as? BaseRootVC {
            return rootVC
        }
        return nil
    }

    override func getRootPageVC() -> BasePageVC? {
        var viewController: UIViewController? = self

        while viewController?.parent != nil {
            if let rootPageVC = viewController?.parent as? BasePageVC {
                return rootPageVC
            }
            viewController = viewController?.parent
        }
        if let rootPageVC = presentingViewController?.parent as? BasePageVC {
            return rootPageVC
        }

        guard let basePageVC = UIApplication.shared.keyWindow?.rootViewController
            as? BasePageVC else { return nil }
        return basePageVC
    }

    override func getNavVC() -> BaseNC? {
        let rootPageVC = getRootPageVC()

        if let rootNavVC = rootPageVC?.presentedViewController as? BaseNC {
            return rootNavVC
        }

        var vc = presentedViewController
        while vc?.parent != nil {
            if let rootNC = vc?.parent as? BaseNC {
                return rootNC
            }
            vc = vc?.parent
        }

        guard let baseNC = UIApplication.shared.keyWindow?.rootViewController
            as? BaseNC else { return nil }

        return baseNC
    }

    func getPageLogo() -> UIImage? {
        return nil
    }

    func getPageTitle() -> String? {
        return nil
    }

    func getPageStep() -> String? {
        return nil
    }

    func getPageBackgroundColor() -> UIColor {
        return .paleGrey
    }

    func getLeftBarButtonItems() -> [NavigationBarButton] {
        return leftBarButtonItems.value
    }

    func getRightBarButtonItems() -> [NavigationBarButton] {
        return rightBarButtonItems.value
    }

    func getNavigationBarBgImage() -> UIImage {
        return navBarBackgroundImage.value
    }

    func getNavigationBarBgColor() -> UIColor {
        return .azureThree
    }

    func getWillShowNavigationBar() -> Bool {
        return willShowNavigationBar.value
    }

    func getWillShowTitleAndStep() -> Bool {
        return willShowTitleAndStep.value
    }

    func getWillShowLogo() -> Bool {
        return willShowLogo.value
    }

    func showWarningInfo(type: WarningInfoType,
                         textList: [String],
                         view: WarningInfoAlertView,
                         font: UIFont? = nil,
                         color: UIColor? = nil) {
        var labels: [UILabel] = []
        for text in textList {
            labels.append(UILabel.createModel1(text: text,
                                               font: font ?? UIFont(name: AppFont.semibold, size: 13),
                                               color: color ?? .white))
        }
        for (index, label) in labels.enumerated() {
            label.accessibilityIdentifier = "\(AccessibilityKey.label.rawValue)\(index)." + (type == .warning ? "warning" : "info")
        }
        view.configureView(type: type, labels: labels)
    }

    func updateCountDown(currentTime: UInt, duration: UInt, countDownView: UIView) {
        let currentAngle = (CGFloat(duration) - CGFloat(currentTime)) / CGFloat(duration) * CGFloat.pi * 2
        DispatchQueue.main.async {
            countDownView.makeTimerStandartColor(color: UIColor.greyishTwo.cgColor,
                                                 size: countDownView.bounds.size,
                                                 startPoint: CGPoint(x: 0, y: 0.5),
                                                 endPoint: CGPoint(x: 1, y: 0.5),
                                                 endAngle: CGFloat(currentAngle))
        }
    }
}
