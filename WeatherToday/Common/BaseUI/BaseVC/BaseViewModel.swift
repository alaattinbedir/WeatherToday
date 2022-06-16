//
//  BaseViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import ReactiveKit
import UIKit

protocol ViewState {}

enum BaseViewState: ViewState {
    case sessionTimeout
}

class BaseViewModel {
    var bag = DisposeBag()
    var alert = PassthroughSubject<AlertModel, Never>()
    var fieldAlert = PassthroughSubject<FieldAlertModel?, Never>()
    var state = PassthroughSubject<ViewState, Never>()
    var isTimeout = false
    var isOtherDevice = false

    func handleEmptyResponse(_: EmptyResponse) {
        // Intentionally unimplemented
    }

    func handleFailure(_ model: ErrorMessage) {
        DispatchQueue.main.async {
            ScreenActivityIndicator.shared.stopAnimating()
        }
        var alertIcon: UIImage?
        switch model.breakFlowType {
        case .info:
            alertIcon = StatusType.inform.icon
        case .warning:
            alertIcon = StatusType.warning.icon
        case .error:
            alertIcon = StatusType.error.icon
        }
        let alertModel = AlertModel(title: model.title,
                                    message: model.message,
                                    icon: alertIcon,
                                    code: (model.errorCode)~)
        isTimeout = false
        isOtherDevice = false
        if model.responseType == ResponseTypeEnum.otherDeviceLogin.rawValue {
            isOtherDevice = true
        }
        if model.responseType == ResponseTypeEnum.sessionExpire.rawValue ||
            model.responseType == ResponseTypeEnum.logOffSession.rawValue ||
            model.responseType == ResponseTypeEnum.securityError.rawValue {
            isTimeout = true
        }
        if alertModel.field~.isEmpty {
            alert.send(alertModel)
        } else {
            fieldAlert.send(FieldAlertModel(field: alertModel.field~, message: alertModel.message~))
        }
    }

    required init() {
        // Intentionally unimplemented
    }

    func disposeBag() {
        bag.dispose()
    }

    deinit {
        print("*** \(String(describing: type(of: self))) deinitialized")
    }
}
