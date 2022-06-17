//
//  BaseCreateUserVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

class BaseCreateUserVC<T>: BaseChildVC<T> where T: BaseViewModel {
    override func getNavigationBarBgColor() -> UIColor { return .azureThree }

    override func getWillShowTitleAndStep() -> Bool { return true }

    override func getRightBarButtonItems() -> [NavigationBarButton] {
        let data = NavigationBarButtonData(image: #imageLiteral(resourceName: "closeWhite")) { _ in
            NavigationRouter.dismiss()
        }
        return [.custom(data)]
    }

    override func onAlertButtonPressed(_ code: Alert?, buttonIdentifier: AlertButtonIdentifier) {
        super.onAlertButtonPressed(code, buttonIdentifier: buttonIdentifier)
        NavigationRouter.dismiss(viewController: self)
    }
}
