//
//  LandingVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 6.06.2022.
//

import Foundation

class LandingVC: MDViewController {

    private func appendAction(actions: inout [(title: String, action: () -> Void)], titleKey: String?, rawValue: String?) -> [(title: String, action: () -> Void)] {
        if let titleKey = titleKey {
            actions.append((titleKey, {
                print("heyyyooo")
            }))
        }
        return actions
    }

    @IBAction func getWeather(_ sender: Any) {

//        WarningView(title: "AccountCard.Main.InformTitle",
//                    message: "Transactions.CardTrx.ApplyCard.EcomWarning",
//                    type: .inform).show()
        
        WarningView(title: "Iste bu",
                    message: "Mesaj boyle hosterilir hurrrraa",
                    type: .inform,
                    buttonActions: [("OkButton", {print("OkButton")}),("CancelButton", { print("CancellButton") }) ])
        .show()

        var actions: [(title: String, action: () -> Void)] = []
        actions.append(("OkButton", { print("OkButton") }))
        actions.append(("CancelButton", { print("CancellButton") }))

        RoutingEnum.popup(title: "Iste bu",
                          message: "Mesaj boyle hosterilir hurrrraa",
                          type: .inform,
                          buttonActions: actions)
        .navigate()
    }

    @IBAction func getLandingPage(_ sender: Any) {
        RoutingEnum.landingWelcome.navigate()
    }

    @IBAction func popUp(_ sender: Any) {
        RoutingEnum.securityQuestionInfoPopUp.navigate(isPopup: true, popupCompletion: nil, transitionStyle: .modal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension LandingVC: RoutingConfiguration {

    // pop up olarak kullaniliyor
    static func transitionStyle(for _: RoutingEnum) -> (isModal: Bool, transitionStyle: RoutingTransitionStyle) {
        return (true, RoutingTransitionStyle.none)
    }

    static func getNavigationInfo() -> NavigationRouterEnum {
        return NavigationRouterEnum.toViewController(toVCType: Self.self, hidesBottomBarWhenPushed: true)
    }
}
