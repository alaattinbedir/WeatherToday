//
//  LandingWelcomeVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 7.06.2022.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa


class LandingWelcomeVC: BaseViewController {

    @IBOutlet weak var landingWelcomeLabel: UILabel!

    @IBAction func getLandingWelcome2Page(_ sender: Any) {
        RoutingEnum.weather.navigate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landingWelcomeLabel.text = "Welcome to Landing Page Hurrraaaa!"
    }    
}

extension LandingWelcomeVC: RoutingConfiguration {
    static func getNavigationInfo() -> NavigationRouterEnum {
        return NavigationRouterEnum.toStoryBoard(toStoryboard: .landingWelcome, toVC: .landingWelcomeVC, toVCType: Self.self)
    }
}
