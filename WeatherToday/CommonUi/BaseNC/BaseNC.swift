//
//  BaseNC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//
import UIKit

class BaseNC: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationBar.tintColor = AppColor.whiteDefault
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
    }
}

extension BaseNC: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController, willShow viewController: UIViewController, animated _: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name.mdPushAnimationWillStart, object: viewController)
    }

    func navigationController(_: UINavigationController, didShow viewController: UIViewController, animated _: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name.mdPushAnimationEnded, object: viewController)
    }
}
