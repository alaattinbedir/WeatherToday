//
//  BaseRootVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Bond
import CoreMotion
import SnapKit
import UIKit

class BaseRootVC: BaseDataViewController {
    @IBOutlet var viewTitleWithLogo: UIView!
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var lblTitleWithLogo: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var leftBarButtonContainer: UIStackView!
    @IBOutlet var rightBarButtonContainer: UIStackView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var navigationBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var navBarBg: UIImageView!

    @IBOutlet var viewPageTitleAndStep: UIView!
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var lblStep: UILabel!

    let motionManager = CMMotionManager()
    var lastDeviceOrientation: UIDeviceOrientation?
    var pageLogo = Observable<UIImage?>(nil)
    var pageTitle = Observable<String?>("")
    var pageStep = Observable<String?>("")
    var pageBackgroundColor = Observable<UIColor>(.white)
    var leftBarButtonItems = Observable<[NavigationBarButton]>([])
    var rightBarButtonItems = Observable<[NavigationBarButton]>([])
    var navBarBackgroundImage = Observable<UIImage>(UIImage())
    var navBarBackgroundColor = Observable<UIColor>(.azureThree)
    var willShowNavigationBar = Observable<Bool>(true)
    var willShowTitleStepView = Observable<Bool>(false)
    var willShowLogo = Observable<Bool>(false)

    var viewControllers: [UIViewController] = []
    var activeNavigationController: UINavigationController? {
        didSet {
            activeNavigationController?.delegate = self
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addContentController()
        addViewControllers()
        setAccessibilityIdentifiers()
        bind()
    }

    private func addContentController() {
        let baseNC = BaseNC(rootViewController: UIViewController())
        addChild(baseNC)
        baseNC.view.frame = containerView.bounds
        containerView.addSubview(baseNC.view)
        baseNC.didMove(toParent: self)
        activeNavigationController = navigationController
    }

    private func bind() {
        pageStep.bind(to: lblStep.reactive.text)
        pageBackgroundColor.bind(to: self) { $0.setBackgroundColor($1) }.dispose(in: bag)
        leftBarButtonItems.bind(to: self) { $0.setLeftBarButtonItems($1) }.dispose(in: bag)
        rightBarButtonItems.bind(to: self) { $0.setRightBarButtonItems($1) }.dispose(in: bag)
        willShowNavigationBar.bind(to: self) { $0.setWillShowNavigationBar($1) }.dispose(in: bag)
        navBarBackgroundImage.bind(to: self) { $0.setNavigationBarBgImage($1) }.dispose(in: bag)
        navBarBackgroundColor.bind(to: self) { $0.setNavigationBarBgColor($1) }.dispose(in: bag)
        willShowTitleStepView.bind(to: self) { $0.setWillShowTitleStep($1) }.dispose(in: bag)
        willShowLogo.bind(to: self) { $0.setWillShowLogo($1) }.dispose(in: bag)
    }

    private func reconfigureBarButtonItems(_ barButtonItems: [NavigationBarButton]?,
                                           container: UIStackView,
                                           position: NavigationBarButtonPosition) {
        container.removeAllArrangedSubviews()

        guard let barButtonItems = barButtonItems else { return }

        for (index, item) in barButtonItems.enumerated() {
            let barButton = UIButton(type: .custom)
            barButton.setImage(item.icon, for: .normal)
            barButton.setTitle(item.title, for: .normal)
            barButton.setTitleColor(item.titleColor, for: .normal)
            barButton.titleLabel?.font = AppFont.semibold17
            barButton.tintColor = .white
            barButton.tag = index + (position.rawValue * 10)
            barButton.accessibilityKey = item.accessibilityKey
            barButton.addTarget(self, action: #selector(navigationBarButtonItemPressed), for: .touchUpInside)
            container.addArrangedSubview(barButton)
            barButton.snp.makeConstraints { $0.width.height.equalTo(44) }
            view.layoutIfNeeded()
            barButton.centerVertically()
        }
    }

    @objc
    func navigationBarButtonItemPressed(_ button: UIButton) {
        let buttons = (button.tag / 10) == 1 ? leftBarButtonItems.value : rightBarButtonItems.value
        let index = button.tag % 10

        switch buttons.isEmpty ? .back(nil) : buttons[index] {
        case let .back(handler):
            guard let handler = handler else {
                if let navigationController = activeNavigationController {
                    navigationController.popViewController(animated: true)
                }
                return
            }
            handler()
        case let .close(handler):
            guard let handler = handler else {
                NavigationRouter.dismiss()
                return
            }
            handler()
        case let .custom(buttonData):
            buttonData.handler?(button)
        default:
            break
        }
    }

    private func addViewControllers() {
        if let navigationController = children.first as? UINavigationController {
            navigationController.viewControllers = viewControllers
        }
    }

    private func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }

    private func setLeftBarButtonItems(_ leftBarButtonItems: [NavigationBarButton]) {
        var buttonItems = leftBarButtonItems
        if let navigationController = activeNavigationController, navigationController.viewControllers.count > 1,
           !leftBarButtonItems.contains(where: { $0 == .back(nil) }) {
            buttonItems.insert(.back(nil), at: 0)
        }
        reconfigureBarButtonItems(buttonItems,
                                  container: leftBarButtonContainer,
                                  position: .left)
        view.layoutIfNeeded()
    }

    private func setRightBarButtonItems(_ rightBarButtonItems: [NavigationBarButton]) {
        reconfigureBarButtonItems(rightBarButtonItems,
                                  container: rightBarButtonContainer,
                                  position: .right)
    }

    private func setWillShowNavigationBar(_ willShowNavigationBar: Bool) {
        navigationBarHeightConstraint.constant = willShowNavigationBar ? 48 : 0
        view.layoutIfNeeded()
    }

    private func setWillShowTitleStep(_ willShowTitleStep: Bool) {
        viewPageTitleAndStep?.isHidden = !willShowTitleStep
        view.layoutIfNeeded()
    }

    private func setWillShowLogo(_ willShowLogo: Bool) {
        viewTitleWithLogo.isHidden = !willShowLogo
        view.layoutIfNeeded()
        if willShowLogo {
            viewPageTitleAndStep?.isHidden = true
            pageLogo.bind(to: imgLogo.reactive.image)
            pageTitle.bind(to: lblTitleWithLogo.reactive.text)
        } else {
            if let menuPageTitle = menuPageTitle,
               !menuPageTitle.isEmpty {
                lblPageTitle.text = menuPageTitle
            } else {
                pageTitle.bind(to: lblPageTitle.reactive.text)
            }
        }
    }

    private func setNavigationBarBgImage(_ image: UIImage) {
        navBarBg.image = image
    }

    private func setNavigationBarBgColor(_ color: UIColor) {
        navBarBg.backgroundColor = color
    }

    private func setAccessibilityIdentifiers() {
        imgLogo.accessibilityKey = .barLogo
        lblTitle.accessibilityKey = .barTitle
        lblPageTitle.accessibilityKey = .title
        lblStep.accessibilityKey = .stepNumber
    }
}

extension BaseRootVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow _: UIViewController,
                              animated _: Bool) {
        if activeNavigationController == navigationController,
           navigationController.viewControllers.count <= 1,
           leftBarButtonItems.value.count < leftBarButtonContainer.arrangedSubviews.count {
            leftBarButtonContainer.arrangedSubviews.first?.removeFromSuperview()
        }
    }
}
