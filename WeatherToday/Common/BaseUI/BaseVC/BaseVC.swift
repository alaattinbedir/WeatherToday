//
//  BaseVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import IQKeyboardManagerSwift
import ReactiveKit
import SnapKit
import UIKit

protocol ViewModelData {}

class BaseVC<VM>: BaseDataViewController, WarningViewDelegate, UINavigationControllerDelegate where VM: BaseViewModel {
    lazy var viewModel: VM = VM()
    var activeDisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        observeViewStateChanges()
        setResources()
        setAccessibilityIdentifiers()
        registerLanguageChanges()
        print("*** \(String(describing: type(of: self))) initialized")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AlertManager.shared.hideFieldAlert()
        activeDisposeBag.dispose()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.resignFirstResponder()
    }

    func bind() {
        viewModel.alert.throttle(for: 1.0).bind(to: self) { delegate, alertModel in
            DispatchQueue.main.async {
                if AlertManager.shared.warningView != nil {
                    self.dismissWarningView(alertModel: alertModel, delegate: delegate)
                } else {
                    AlertManager.shared.build(with: alertModel)?.delegate(delegate).show()
                }
            }
        }.dispose(in: bag)
    }

    private func dismissWarningView(alertModel: AlertModel, delegate: BaseVC<VM>) {
        AlertManager.shared.warningView?.alert.dismiss(animated: true) {
            AlertManager.shared.build(with: alertModel)?.delegate(delegate).show()
        }
    }

    private func observeViewStateChanges() {
        viewModel.state.observeNext { [weak self] state in
            self?.onStateChanged(state)
        }.dispose(in: bag)
    }

    private func registerLanguageChanges() {
        NotificationCenter.default.reactive.notification(name: .languageDidChange).observeNext { [weak self] _ in
            self?.setResources()
            self?.onLanguageChanged()
        }.dispose(in: bag)
    }

    func onStateChanged(_ state: ViewState) {
//        guard let state = state as? BaseViewState else { return }
//        switch state {
//        case .sessionTimeout:
//            NavigationRouter.go(to: SplashVC(),
//                                transitionOptions: TransitionOptions(direction: .fade))
//        }
    }

    override func showAlert(with alertModel: AlertModel) {
        viewModel.alert.send(alertModel)
    }

    func onAlertButtonPressed(_ code: Alert?, buttonIdentifier: AlertButtonIdentifier) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            code?.navigate(with: buttonIdentifier)
        }
//        if viewModel.isOtherDevice {
//            PushNotificationHelper.shared.unregister()
//            PersistentKeeper.shared.removeItems()
//            KeychainKeeper.shared.removeItems()
//            PersistentKeeper.shared.hasAppRunBefore = true
//            NavigationRouter.go(to: SplashVC(),
//                                transitionOptions: TransitionOptions(direction: .fade))
//        }
//        if viewModel.isTimeout {
//            NavigationRouter.go(to: SplashVC(),
//                                transitionOptions: TransitionOptions(direction: .fade))
//        }
    }

    func onLanguageChanged() {
        // Intentionally unimplemented
    }

    func setResources() {
        // Intentionally unimplemented
    }

    func setAccessibilityIdentifiers() {
        // Intentionally unimplemented
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func startLoading() {
        ScreenActivityIndicator.shared.startAnimating()
    }

    func stopLoading() {
        ScreenActivityIndicator.shared.stopAnimating()
    }

    deinit {
        viewModel.disposeBag()
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
