//
//  BaseVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 7.06.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BaseVC: MDViewController, WarningViewDelegate {
    var menuItems: [OptionsMenuItem] = []

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        refreshPageMenuEnum()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        refreshPageMenuEnum()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshPageMenuEnum()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNavigationBarStyle()
        makeBackgroundPureClean()
        setNavBarTitleFont()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNavigationBarStyle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAndShowCampaignIfNeeded()
    }

    func loadNavigationBarStyle() {
        makeBackBarItemEmpty()
        makeNavigationBarAppear(animated: false)
        setNavBarTitleFont()
        if Keeper.shared.isNewUxEnabled {
            reloadBackButtonByOpenStyle()
            makeNavigationBarBackgroundColor(navigationController?.navigationBar, g1: AppColor.ceruleanThree, g2: AppColor.ceruleanTwo, imageName: nil)
        } else {
            makeNavigationBarBackgroundColor(g1: AppColor.ceruleanBG, g2: AppColor.cerulean)
        }
    }

    // MARK: - Campaign

    var campaign: CampaignInformation?
    func checkAndShowCampaignIfNeeded() {
        if let campaign = campaignForCurrentPage() {
            self.campaign = campaign
            enqueueShowCampaign(campaign: campaign)
        }
    }

    func enqueueShowCampaign(campaign _: CampaignInformation) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let sself = self else { return }
            if ActivityIndicatorPresenter.sharedInstance.isAnimating() {
                NotificationCenter.default
                    .addObserver(sself, selector: #selector(sself.loadingEnded(not:)),
                                 name: NSNotification.Name.mdScreenActivityIndicatorEnded, object: nil)
            } else {
                sself.showCampaign()
            }
        }
    }

    @objc func loadingEnded(not _: Notification) {
        NotificationCenter.default
            .removeObserver(self, name: NSNotification.Name.mdScreenActivityIndicatorEnded, object: nil)
        showCampaign()
    }

    func showCampaign() {
        if let campaign = campaign {
            RoutingEnum.logonCampaign(campaign: campaign).navigate(fromVC: self, isPopup: true, transitionStyle: .modal)
        }
    }

    // override when needed (ex: two menu enum navigates to same page)
    func campaignForCurrentPage() -> CampaignInformation? {
        if let campaign = CampaignApi.campaign,
           let campaignMenuEnum = MenuEnum(rawValue: campaign.showMobileFormNo ?? ""),
           type(of: self) == campaignMenuEnum.getRoutingEnum(params: nil).getClassType() {
            return campaign
        }
        return nil
    }

    // MARK: -

    func tryShowGeneralError(_ errorMessage: ErrorMessage?, isFatal: Bool) {
        guard let errorMessage = errorMessage else { return }
        showGeneralError(errorMessage, isFatal)
    }

    func tryShowGeneralError(_ errorMessage: ErrorMessage?) {
        guard let errorMessage = errorMessage else { return }
        showGeneralError(errorMessage, false)
    }

    func showGeneralError(_ errorMessage: ErrorMessage) {
        showGeneralError(errorMessage, false)
    }

    func showFatalError(_ errorMessage: ErrorMessage) {
        if errorMessage.responseType == 2 {
            showGeneralErrorThenNavigateToHome(errorMessage)
            return
        }
        showGeneralError(errorMessage, true)
    }

    func showGeneralErrorThenNavigateToHome(_ errorMessage: ErrorMessage, _ popBack: Bool = false, type _: WarningType = .warning) {
        var title = errorMessage.title
        if title.count == 0 {
            title = "WarningTitle".resource()
        }
        let alert = WarningView(title: title, message: errorMessage.message, type: errorMessage.getWarningType(), buttonActions: [("OkButton".resource(), {
            RoutingEnum.dashboard.navigate()
        })])
        alert.popBack = popBack
        alert.delegate = self
        alert.show()
    }

    func showGeneralError(_ errorMessage: ErrorMessage, _ popBack: Bool = false, type _: WarningType = .warning) {
        var title = errorMessage.title
        if title.count == 0 {
            title = "WarningTitle".resource()
        }
        let alert = WarningView(title: title, message: errorMessage.message, type: errorMessage.getWarningType())
        alert.popBack = popBack
        alert.delegate = self
        alert.show()
    }

    func showCompleteMessage(_ message: PageLoadingStatus.Message) {
        let alert = WarningView(title: message.title, message: message.body, type: .inform)
        alert.popBack = true
        alert.delegate = self
        alert.show()
    }

    func warningView(_ warning: WarningView, tappedButtonIndex _: Int) {
        if warning.popBack {
            closePage()
        }
    }

    @objc func closePageForSelector() {
        closePage(animated: true)
    }

    @IBAction open func closePage() {
        closePage(animated: true)
    }

    open func closePage(animated: Bool) {
        closePage(animated: animated, completion: nil)
    }

    open func closePage(animated: Bool, completion: (() -> Void)?) {
        if isPresentedModally || ((type(of: self) as? RoutingConfiguration.Type)?.transitionStyle(for: routingEnum ?? .none))?.isModal ?? false {
            dismiss(animated: animated, completion: completion)
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
            completion?()
        } else {
            dismiss(animated: animated, completion: completion)
        }
    }

    func optionMenuButton(with menuItems: [String], callback: OptionsMenuItemCallback?) -> UIBarButtonItem {
        self.menuItems = optionsMenuItems(with: menuItems, callback: callback)
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "navigation_more_menu_icon"), style: .plain,
                                     target: self, action: #selector(toggleOptionsMenu))
        button.accessibilityIdentifier = "btn.MoreActionMenu"
        return button
    }

    func optionMenuButton(with menuItems: [String], callback: OptionsMenuItemCallback?) -> UIButton {
        self.menuItems = optionsMenuItems(with: menuItems, callback: callback)
        let btnOptions = UIButton(type: .custom)
        btnOptions.setImage(#imageLiteral(resourceName: "navigation_more_menu_icon"), for: .normal)
        btnOptions.addTarget(self, action: #selector(toggleOptionsMenu), for: .touchUpInside)
        btnOptions.isAccessibilityElement = false
        return btnOptions
    }

    fileprivate func optionsMenuItems(with items: [String], callback: OptionsMenuItemCallback?) -> [OptionsMenuItem] {
        return items.map { OptionsMenuItem(title: $0, callback: callback) }
    }

    @objc func toggleOptionsMenu() {
        UIAccessibility
            .post(notification: UIAccessibility.Notification.announcement,
                  argument: "VoiceOver.Dashboard.Secret.MenuText".resource())

        if OptionsMenu.shared.isShowing {
            OptionsMenu.shared.hideMenu()
        } else {
            OptionsMenu.shared.showMenu(in: (parent as? BaseVC)?.view ?? view, with: menuItems)
        }
    }

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            startLoading()
        } else {
            stopLoading()
        }
    }

    func startLoading() {
        ScreenActivityIndicator.shared.startAnimating()
    }

    func stopLoading() {
        ScreenActivityIndicator.shared.stopAnimating()
    }

    func isLoading() -> Bool {
        return ScreenActivityIndicator.shared.isAnimating()
    }

    func addCustomBackButton(action: Selector? = nil) {
        if isPresentedModally {
            addCustomBackButton(action: action, backActionType: .cross)
        } else {
            addCustomBackButton(action: action, backActionType: .arrow)
        }
    }

    func reloadBackButtonByOpenStyle() {
        if isPresentedModally {
            addCustomBackButton(action: #selector(closePageForSelector), backActionType: .cross)
        } else if navigationController?.viewControllers.count ?? 0 > 1 {
            addCustomBackButton(action: #selector(closePageForSelector), backActionType: .arrow)
        }
    }

    func createWidgetAndQuickMenuView() -> WidgetAndQuickMenuView? {
        let subMenus = MenuProxy.shared.menuItems.subMenus(pageMenuEnum, types: .widget, .widgetMenuItem)

        if let quickMenu = subMenus.first(where: { $0.menuKey == .quickMenu }) {
            let view = WidgetAndQuickMenuView()
            let viewModel = WidgetAndQuickMenuViewModel(menuEnum: quickMenu.menuKey)
            view.setViewModel(viewModel)
            return view
        } else if subMenus.first(where: { $0.type == .widgetMenuItem }) != nil {
            let view = WidgetAndQuickMenuView()
            let viewModel = WidgetAndQuickMenuViewModel(menuEnum: pageMenuEnum)
            view.setViewModel(viewModel)
            return view
        }
        return nil
    }
}

extension UIViewController {
    func add(child: UIViewController, parentView: UIView) {
        addChild(child)

        parentView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        child.view.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
        child.view.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        child.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true

        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func addCustomBackButton(action: Selector? = nil, backActionType: BackActionType = .arrow) {
        switch backActionType {
        case .arrow:
            backWithArrowButton(action: action)
        case .cross:
            backWithCrossButton(action: action)
        }
    }

    func backWithArrowButton(action: Selector?) {
        edgesForExtendedLayout = .top
        let navigationItem = getNavigationItem()
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: ImageResource.backArrowWhite.toUIImage(),
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: action ?? #selector(customBackButtonPressed))
        newBackButton.accessibilityLabel = "VoiceOver.BackButton".resource()
        navigationItem.leftBarButtonItem = newBackButton
    }

    func backWithCrossButton(action: Selector?) {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = createCrossButton(action)
    }

    func createCrossButton(_ action: Selector?) -> UIBarButtonItem {
        let imageName = "close_page_icon"
        let newBackButton = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self,
                                            action: action ?? #selector(customBackButtonPressed))
        newBackButton.tintColor = AppColor.whiteDefault
        newBackButton.accessibilityLabel = "VoiceOver.BackButton".resource()
        return newBackButton
    }

    @objc func customBackButtonPressed() {
        if let baseVC = self as? BaseVC {
            baseVC.closePage()
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    func addFilterButton(action: Selector) {
        getNavigationItem().titleView = nil
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter_icon"), style: .plain, target: self,
                                           action: action)
        getNavigationItem().rightBarButtonItems = [filterButton]
    }

    func addRightSearchButton(action: Selector) {
        getNavigationItem().titleView = nil
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_white"), style: .plain, target: self,
                                           action: action)
        getNavigationItem().rightBarButtonItems = [searchButton]
    }

    func getNavigationItem() -> UINavigationItem {
        return view.parentContainerViewController()?.navigationItem ?? navigationItem
    }
}

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}

extension BaseVC {
    func openConfirmationPage(confirmable: ConfirmableProcess,
                              completionActions: [String] = ["CommonTransactions.ApprovalButton".resource()],
                              contractApproveActionTitle: String = "CommonTransactions.ContractApprovalButton".resource(),
                              contractCancelActionTitle: String = "CommonTransactions.ContractCancelButton".resource(),
                              clearNavigationStack: Bool? = nil,
                              replaceCurrentPage: Bool = false,
                              confirmMenuEnum: MenuEnum? = nil,
                              gaEventBag: [String: Any]? = nil,
                              topSupplementaryViewSupplier: ((UIView) -> Void)? = nil,
                              supplementaryViewSupplier: ((UIView) -> Void)? = nil) {
        guard confirmable.getConfirmResponse().type.hasPrefix("Confirm") else { return }
        if let topViewController = navigationController?.topViewController, type(of: topViewController) == ConfirmationVC.self {
            return
        }
        stopLoading()

        let pageMenuEnum = confirmMenuEnum ?? self.pageMenuEnum
        let confirmationPageViewModel = ConfirmationViewModel(
            title: confirmable.getResultTitle(),
            confirmResponse: confirmable.getConfirmResponse(),
            completionActions: completionActions,
            contractApproveActionTitle: contractApproveActionTitle,
            contractCancelActionTitle: contractCancelActionTitle,
            onFailed: showFatalError,
            completion: nil
        )

        confirmationPageViewModel.process = confirmable
        RoutingEnum.confirmation(
            vm: confirmationPageViewModel,
            transactionMenuEnum: pageMenuEnum,
            screenViewEvent: nil,
            gaEventBag: gaEventBag,
            supplementaryViewSupplier: supplementaryViewSupplier,
            topSupplementaryViewSupplier: topSupplementaryViewSupplier
        ).navigate(clearNavigationStack: clearNavigationStack, replace: replaceCurrentPage,
                   animated: !(confirmable.getConfirmResponse().isAutoConfirmActive || replaceCurrentPage))
    }

    func confirm(_ confirmable: ConfirmableProcess?,
                 completionActions: [String] = ["CommonTransactions.ApprovalButton".resource()],
                 clearNavigationStack: Bool? = nil,
                 replaceCurrentPage: Bool = false,
                 confirmMenuEnum: MenuEnum? = nil,
                 gaEventBag _: [String: Any]? = nil,
                 topSupplementaryViewSupplier: ((UIView) -> Void)? = nil,
                 supplementaryViewSupplier: ((UIView) -> Void)? = nil) {
        guard let confirmable = confirmable else { return }

        let pageMenuEnum = confirmMenuEnum ?? self.pageMenuEnum

        if confirmable.getConfirmResponse().type == "Completed" {
            openResultPage(confirmable, confirmMenuEnum: pageMenuEnum)
        } else if confirmable.getConfirmResponse().type == "ConfirmSms" {
            openConfirmationPage(confirmable: confirmable, confirmMenuEnum: pageMenuEnum, supplementaryViewSupplier: supplementaryViewSupplier)
        } else if confirmable.getConfirmResponse().isAutoConfirmActive {
            confirmable.send(token: confirmable.getConfirmResponse().token,
                             eTag: confirmable.getConfirmResponse().eTag,
                             approvedContracts: nil,
                             otp: nil,
                             completion: tryShowGeneralError)
        } else {
            openConfirmationPage(confirmable: confirmable,
                                 completionActions: completionActions,
                                 clearNavigationStack: clearNavigationStack,
                                 replaceCurrentPage: replaceCurrentPage,
                                 confirmMenuEnum: pageMenuEnum,
                                 topSupplementaryViewSupplier: topSupplementaryViewSupplier,
                                 supplementaryViewSupplier: supplementaryViewSupplier)
        }
    }

    func openResultPage(_ confirmable: ConfirmableProcess, confirmMenuEnum: MenuEnum? = nil) {
        let pageMenuEnum = confirmMenuEnum ?? self.pageMenuEnum
        openResultPage(title: confirmable.getResultTitle(), confirmable.getConfirmResponse(), confirmMenuEnum: pageMenuEnum)
    }

    func openResultPage(title: String, _ confirmResponse: ConfirmResponse, confirmMenuEnum: MenuEnum? = nil) {
        if let topViewController = navigationController?.topViewController,
           type(of: topViewController) == ResultVC.self || type(of: topViewController) == OTPPageVC.self || type(of: topViewController) == ConfirmationVC.self {
            return
        }
        let pageMenuEnum = confirmMenuEnum ?? self.pageMenuEnum
        let resultViewModel = ResultViewModel(title: title, confirmResponse: confirmResponse)
        RoutingEnum.result(vm: resultViewModel,
                           transactionMenuEnum: pageMenuEnum,
                           screenViewEvent: nil,
                           gaEventBag: nil,
                           supplementaryViewSupplier: nil).navigate()
    }
}

// MARK: Rx

extension BaseVC {
    func bindPageLoadingStatusToLoadingIndicator(_ status: BehaviorRelay<PageLoadingStatus>,
                                                 _ disposeBag: DisposeBag,
                                                 stopLoadingDelay: TimeInterval = 0.3) {
        status
            .observeOn(MainScheduler())
            .map { $0.isLoading() }
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self, self.isLoading() != isLoading else { return }
                if isLoading {
                    self.startLoading()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + stopLoadingDelay, execute: self.stopLoading)
                }
            })
            .disposed(by: disposeBag)
    }

    func bindPageLoadingStatus(status: BehaviorRelay<PageLoadingStatus>,
                               contentView: UIView? = nil,
                               contentViews: [UIView?]? = nil,
                               contenInfoView: CustomizableInfoView? = nil,
                               hideContentWhenEror: Bool = false,
                               showContentWhenEror: Bool = false,
                               closePageWhenComplete: Bool = false,
                               contenVisiblityDelay: TimeInterval = 0.3,
                               manageLoading: Bool = true,
                               closePageWhenFatal: Bool = true,
                               disposeBag: DisposeBag) {
        if manageLoading {
            bindPageLoadingStatusToLoadingIndicator(status, disposeBag, stopLoadingDelay: contenVisiblityDelay)
        }
        status
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                if let error = status.getError() {
                    if let contenInfoView = contenInfoView, status.isError() {
                        contenInfoView.setMessage(error.message)
                    } else {
                        self?.tryShowGeneralError(status.getError(), isFatal: status.isFatal() && closePageWhenFatal)
                    }
                    if hideContentWhenEror {
                        contentView?.isHidden = true
                        contentViews?.forEach { $0?.isHidden = true }
                    } else if showContentWhenEror {
                        contentView?.isHidden = false
                        contentViews?.forEach { $0?.isHidden = false }
                    }
                } else {
                    contenInfoView?.setMessage(nil)
                }

                if status.isSuccess() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + contenVisiblityDelay) {
                        contentView?.setIsHidden(false, animated: true)
                        contentViews?.forEach { $0?.setIsHidden(false, animated: true) }
                    }
                } else if status.isComplete() {
                    if let message = status.getCompleteMessage() {
                        let alert = WarningView(title: message.title, message: message.body, type: message.type)
                        alert.popBack = closePageWhenComplete
                        alert.show()
                    } else if closePageWhenComplete {
                        self?.closePage()
                    }
                } else if case let PageLoadingStatus.askQuestion(title, message, type, actions) = status {
                    WarningView(title: title, message: message, type: type, buttonActions: actions).show()
                }
            })
            .disposed(by: disposeBag)
    }

    func bindTitle(_ title: BehaviorRelay<String>, _ disposeBag: DisposeBag) {
        title.bind(to: getNavigationItem().rx.title).disposed(by: disposeBag)
    }
}

enum BackActionType {
    case arrow
    case cross
}
