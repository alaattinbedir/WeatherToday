//
//  SecurityQuestionInfoPopUpVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 8.06.2022.
//

import Foundation
import UIKit

class SecurityQuestionInfoPopUpVC: BaseVC {
    @IBOutlet var infoMesage: UILabel! {
        didSet {
            infoMesage.backgroundColor = .clear
            infoMesage.text = "Hi this a security question"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func prepareViews() {
        view.backgroundColor = .clear
    }

    @IBAction func createSecurityQuestion() {
//        dismiss(animated: true) {
//            RoutingEnum.securityQuestionValidation.navigate(isPopup: true, transitionStyle: .modal)
//        }
    }

    @IBAction func createAfter() {
        dismiss(animated: true, completion: nil)
    }

//    override func refreshPageMenuEnum() {
//        pageMenuEnum = .securityQuestionInfoPopUp
//    }
}

// MARK: - RoutingConfiguration

extension SecurityQuestionInfoPopUpVC: RoutingConfiguration {
    static func transitionStyle(for _: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle) {
        return (true, .modal)
    }
}
