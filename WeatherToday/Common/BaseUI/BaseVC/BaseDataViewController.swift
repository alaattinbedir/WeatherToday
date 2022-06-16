//
//  BaseDataViewController.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

class BaseDataViewController: UIViewController {
    var menuPageTitle: String?

    var data: ViewModelData? {
        didSet { dataUpdated() }
    }

    func showAlert(with _: AlertModel) {
        // Intentionally unimplemented
    }

    func getRootVC() -> BaseRootVC? {
        nil
    }

    func getRootPageVC() -> BasePageVC? {
        nil
    }

    func getNavVC() -> UINavigationController? {
        nil
    }

    func dataUpdated() {
        // Intentionally unimplemented
    }
}
