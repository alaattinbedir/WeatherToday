//
//  SplashVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import AppTrackingTransparency
import Bond
import IQKeyboardManagerSwift
import ReactiveKit
import SnapKit
import UIKit

class SplashVC: BaseVC<SplashViewModel> {
    @IBOutlet var imgLogo: UIImageView!
    
    var timer: Timer?
    var waiterTimer: Timer?
    static let waitingTime = 10

    override func viewDidLoad() {
        super.viewDidLoad()
//        makeNavigationBarHidden(animated: false)

        waiterTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(SplashVC.waitingTime), repeats: false) { [weak self] _ in
            if (self?.viewModel.isTokenFetched)~, !(self?.viewModel.isReadyToStartTheApp)~ {
                self?.startApp()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestDataPermission()
        viewModel.pageOpened()
//        JailbreakDetection.inspectDevice()
//        if JailbreakDetection.isBroken() {
//            viewModel.jailbreakWarning()
//        }
    }

    private func requestDataPermission() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    switch status {
                    case .authorized:
                        print("Authorized")
                    case .denied:
                        print("Denied")
                    case .notDetermined:
                        print("Not Determined")
                    case .restricted:
                        print("Restricted")
                    @unknown default:
                        print("Unknown")
                    }
                })
            } else {
                print("you got permission to track, iOS 14 is not yet installed")
            }
        }
    }

    override func bind() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.splashImage.bind(to: imgLogo.reactive.image)
//            appDelegate.splashTimeOut.observeNext { [weak self] timeOut in
//                guard let self = self else { return }
//
//                if timeOut != -1 {
//                    self.waiterTimer?.invalidate()
//                    self.viewModel.isReadyToStartTheApp = true
//                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeOut / 1000), repeats: false) { [weak self] _ in
//                        if (self?.viewModel.isReadyToStartTheApp)~ {
//                            self?.timer?.invalidate()
//                            self?.startApp()
//                        }
//                    }
//                }
//            }.dispose(in: bag)
        }
    }

    override func onStateChanged(_ state: ViewState) {
        super.onStateChanged(state)
        guard let state = state as? SplashViewState else { return }
        switch state {
        case .ended:
            if viewModel.isReadyToStartTheApp {
                startApp()
            }
        }
    }

    private func startApp() {
//        ThirdPartyLoader.loadIQKeyoardManager()

        if let tempTimer = timer, tempTimer.isValid { return }
        SessionKeeper.shared.selectedTabIndex = 0
//        let tabChilds = [MainPageVC(), CampaignsPageVC(), OperationMenuVC(), CardsPageVC(), ShoppingVC()]
//        let tabControllers = tabChilds.map { BaseNC(rootViewController: $0) }
//        let tabVC = BaseTC(tabChildren: tabControllers)
//        let controllers = [PersonalPageVC(), tabVC, StoryPageVC()]
//        NavigationRouter.go(to: PersonalPageVC(),
//                            embedController: .pageVC(controllers),
//                            transitionOptions: TransitionOptions(direction: .fade, style: .easeInOut))
    }

    override func onAlertButtonPressed(_ code: Alert?, buttonIdentifier: AlertButtonIdentifier) {
        switch (code, buttonIdentifier) {
        case (.noConnection?, _),
             (.closeError?, _):
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.viewModel.pageOpened()
            }
        case (.appUpdate?, .forceUpdateLater):
//            ThirdPartyLoader.loadIQKeyoardManager()
            startApp()
        case (.appUpdate?, .forceUpdateUpdate):
            openAppStore()
        default:
            super.onAlertButtonPressed(code, buttonIdentifier: buttonIdentifier)
        }
    }

    private func openAppStore() {
//        if let url = URL(string: viewModel.appUpdateUrl~), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//        }
    }

    override func setAccessibilityIdentifiers() {
        imgLogo.accessibilityKey = .logo
    }
}
