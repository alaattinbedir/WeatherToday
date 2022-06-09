//
//  BaseVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 7.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BaseVC: BaseViewController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNavigationBarStyle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNavigationBarStyle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func loadNavigationBarStyle() {

    }

    @objc func loadingEnded(not _: Notification) {
        NotificationCenter.default
            .removeObserver(self, name: NSNotification.Name.mdScreenActivityIndicatorEnded, object: nil)
    }


    // MARK: -


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
//        let navigationItem = getNavigationItem()
//        navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(image: ImageResource.backArrowWhite.toUIImage(),
//                                            style: UIBarButtonItem.Style.plain,
//                                            target: self,
//                                            action: action ?? #selector(customBackButtonPressed))
//        newBackButton.accessibilityLabel = "VoiceOver.BackButton".resource()
//        navigationItem.leftBarButtonItem = newBackButton
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
//        newBackButton.accessibilityLabel = "VoiceOver.BackButton".resource()
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
//        getNavigationItem().titleView = nil
//        let filterButton = UIBarButtonItem(image: UIImage(named: "filter_icon"), style: .plain, target: self,
//                                           action: action)
//        getNavigationItem().rightBarButtonItems = [filterButton]
    }

    func addRightSearchButton(action: Selector) {
//        getNavigationItem().titleView = nil
//        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_white"), style: .plain, target: self,
//                                           action: action)
//        getNavigationItem().rightBarButtonItems = [searchButton]
    }

}

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}

// MARK: Rx

extension BaseVC {
    func bindTitle(_ title: BehaviorRelay<String>, _ disposeBag: DisposeBag) {
//        title.bind(to: getNavigationItem().rx.title).disposed(by: disposeBag)
    }
}

enum BackActionType {
    case arrow
    case cross
}

