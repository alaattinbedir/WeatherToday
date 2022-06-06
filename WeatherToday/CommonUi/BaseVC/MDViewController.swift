//
//  MDViewController.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation
import UIKit

class MDViewController: UIViewController {

    var data: Any?
    var routingEnum: RoutingEnum?

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if routingEnum?.getNavigationInfo(fromVC: nil).isHidesBottomBarWhenPushed() ?? false || hidesBottomBarWhenPushed {
            tabBarController?.tabBar.alpha = 0.0
            hidesBottomBarWhenPushed = false
        } else {
            tabBarController?.tabBar.alpha = 1.0
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
