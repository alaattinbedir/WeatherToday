//
//  DKWarningViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import IQKeyboardManagerSwift
import TextAttributes

class DKWarningViewModelData: ViewModelData {
    var attributes: TextAttributes?
    var model: AlertModel?
    var buttonTappedHandler: ((Int) -> Void)?

    init(attributes: TextAttributes? = nil,
         model: AlertModel,
         handler: ((Int) -> Void)?) {
        self.attributes = attributes
        self.model = model
        buttonTappedHandler = handler
    }
}

class DKWarningViewModel: BaseViewModel {
    var attributes: TextAttributes?
    var model: AlertModel?
    var buttonTappedHandler: ((Int) -> Void)?

    required init() {
        super.init()
    }
}
