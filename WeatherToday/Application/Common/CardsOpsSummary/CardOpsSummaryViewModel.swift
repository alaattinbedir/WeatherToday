//
//  CardOpsSummaryViewModel.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation

enum CardOpsSummaryViewState: ViewState {
    case openOtp(LoginOTPViewModelData)
    case proceedResult(CardOpsResultViewModelData)
    case transactionCompleted
    case popWithHandler
}

enum SummaryWidget {
    case card(String, CardDetail, Bool = false, Bool = false, Bool = false)
    case checkBox(Int, String, Bool, String, String? = "")
    case warningInfoView(WarningInfoType, [String], Bool = false, UIFont? = nil)
    case paymentInfo(String, [KeyValuePair])
    case paymentPlan(String, [PaymentPlan])
    case paymentTable(String, [PaymentsTable])
    case balanceInfo(BalanceInfo)
    case confirmation(String)
}

class CardOpsSummaryViewModelData: ViewModelData {
    var summaryObject: SummaryObject?
    var otpType: OtpType? = .cardOps
    var plateNumber: String? = ""
    var handler: (() -> Void)?

    init(object: SummaryObject,
         otpType: OtpType? = .cardOps,
         plateNumber: String? = "",
         handler: (() -> Void)? = nil) {
        summaryObject = object
        self.otpType = otpType
        self.plateNumber = plateNumber
        self.handler = handler
    }
}

class SummaryObject {
    var title: String = ""
    var stepNumber: String? = ""
    var description: String = ""
    var summaries: [KeyValuePair] = []
    var topWidgets: [SummaryWidget] = []
    var widgets: [SummaryWidget] = []
    var confirmResponse: ConfirmResponse?
    var approveKey: String = ""
    var requestDict: [String: Any]?
    var headerParams: [String: String]?
    var endPoint: String = ""
    var recordData: [String: Any]?
    var checkboxHeightControlDisable: Bool = false
    var backButtonDisable: Bool = false
    var isPatch: Bool = false
    var summariesWithToolTip: [KeyValuePairWithToolTip]?

    init(title: String = "",
         stepNumber: String = "",
         description: String,
         summaries: [KeyValuePair],
         topWidgets: [SummaryWidget] = [],
         widgets: [SummaryWidget] = [],
         confirmResponse: ConfirmResponse? = nil,
         approveKey: String,
         requestDict: [String: Any]? = nil,
         headerParams: [String: String]? = nil,
         endPoint: String = "",
         recordData: [String: Any]? = nil,
         checkboxHeightControlDisable: Bool = false,
         backButtonDisable: Bool = false,
         isPatch: Bool = false,
         summariesWithToolTip: [KeyValuePairWithToolTip]? = nil) {
        self.title = title
        self.stepNumber = stepNumber
        self.description = description
        self.summaries = summaries
        self.topWidgets = topWidgets
        self.widgets = widgets
        self.confirmResponse = confirmResponse
        self.approveKey = approveKey
        self.requestDict = requestDict
        self.headerParams = headerParams
        self.endPoint = endPoint
        self.recordData = recordData
        self.checkboxHeightControlDisable = checkboxHeightControlDisable
        self.backButtonDisable = backButtonDisable
        self.isPatch = isPatch
        self.summariesWithToolTip = summariesWithToolTip
    }
}

class CardOpsSummaryViewModel: BaseCardOpsViewModel {
    var summaryObject: SummaryObject?
    var loginApi = LoginAPI()
    var paymentApi = PaymentsAPI()
    var fraudOtp: String?
    var selectedCheckBoxCount: Int = 0 {
        didSet {
            canContinueEnabled.value = canContinue()
        }
    }

    var succesfulOperationCount: Int = 0 {
        didSet {
            canContinueEnabled.value = canContinue()
        }
    }

    var otpType: OtpType = .cardOps
    var canContinueEnabled = Observable<Bool?>(nil)
    var cardGuid: String = ""
    var plateNumber: String = ""
    var isAlreadySavedMtv: Bool = false
    var handler: (() -> Void)?
    var recordName: String = ""

    required convenience init() {
        self.init(api: CardsAPI())
    }

    override init(api: CardsAPI) {
        super.init(api: api)
    }

    public func canContinue() -> Bool {
        for contractIndex in 0 ..< getContractCount() {
            guard let contract = getContract(index: contractIndex) else { continue }
            if !contract.isApproved, !contract.isOptional {
                return false
            }
        }
        return selectedCheckBoxCount == succesfulOperationCount
    }

    func approveOperation() {
        if let _ = handler {
            state.send(CardOpsSummaryViewState.popWithHandler)
            return
        }
        if summaryObject?.endPoint == Endpoints.applyTechnoCard ||
            summaryObject?.endPoint == Endpoints.processRestructure {
            summaryObject?.requestDict?["approvedContracts"] = getApprovedContractIds()
        }
        cardsAPI.approveSummaryOperation(headerParams: summaryObject?.headerParams,
                                         params: summaryObject?.requestDict,
                                         endPoint: summaryObject?.endPoint ?? "",
                                         otp: fraudOtp,
                                         isPatch: summaryObject?.isPatch ?? false,
                                         succeed: parseApproveoperation,
                                         failed: handleFailure)
    }

    func getApprovedContractIds() -> [String] {
        var ids: [String] = []
        for contractIndex in 0 ..< getContractCount() {
            guard let contract = getContract(index: contractIndex) else { continue }
            if contract.isApproved, !contract.id.isEmpty {
                ids.append(contract.id)
            }
        }
        return ids
    }

    func parseApproveoperation(_ response: ConfirmResponse) {
        NotificationCenter.default.post(name: .sendEvent, object: nil)
        summaryObject?.confirmResponse = response
        if summaryObject?.approveKey == ResultButton.createPrepaidVirtualCard {
            summaryObject?.summaries = response.summaries
                .map { KeyValuePair(key: $0.label, value: $0.value) }
        }
        goToNextStep(response: response)
    }

    private func goToNextStep(response: ConfirmResponse) {
        if response.type == "ConfirmSms" {
            let expiresData = response.message.components(separatedBy: "-")
            var expiresIn = 0
            if expiresData.count > 1 {
                expiresIn = Int(expiresData[1]) ?? 0
            }
            let data = LoginOTPViewModelData(type: otpType,
                                             summaryObject: summaryObject,
                                             handler: handleOtpResponse,
                                             expiresIn: expiresIn)
            state.send(CardOpsSummaryViewState.openOtp(data))
        } else {
            guard let summaryObject = summaryObject else { return }
            var data = CardOpsResultViewModelData(object: summaryObject)
            if summaryObject.approveKey == ResultButton.paymentsMTVNewPayment {
                data = CardOpsResultViewModelData(object: summaryObject,
                                                  plate: plateNumber,
                                                  isAlreadySavedMtv: isAlreadySavedMtv)
            }
            state.send(CardOpsSummaryViewState.proceedResult(data))
        }
    }

    func handleOtpResponse(response: ConfirmResponse?) {
        guard let response = response else { return }
        parseApproveoperation(response)
    }

    func recordMtvTransaction(recordName: String) {
        var obj = summaryObject?.recordData
        obj?["reusabilityData"] = ["reusableAction": "Save",
                                   "TransactionRecordName": recordName]
        paymentApi.recordMtvTransaction(params: obj,
                                        succeed: parseMtvRecordOrder,
                                        failed: handleFailure)
    }

    private func parseMtvRecordOrder(_: PaymentRecordTransaction) {
        isAlreadySavedMtv = true
        state.send(CardOpsSummaryViewState.transactionCompleted)
    }

    func recordPaymentOrder(recordName: String) {
        guard var recordData = summaryObject?.recordData else { return }
        self.recordName = recordName
        recordData["Alias"] = recordName
        recordData["TransactionType"] = "INSERT"
        paymentApi.recordOrder(recordFields: recordData,
                               succeed: parseRecordOrder,
                               failed: handleFailure)
    }

    private func parseRecordOrder(_ response: ConfirmResponse) {
        guard var recordData = summaryObject?.recordData else { return }
        recordData["Alias"] = recordName
        recordData["TransactionType"] = "INSERT"
        var headerParams: [String: String] = [:]
        headerParams[HeaderParams.xTransactionToken.rawValue] = response.token
        headerParams[HeaderParams.ifMatch.rawValue] = response.eTag
        cardsAPI.approveSummaryOperation(headerParams: headerParams,
                                         params: recordData,
                                         endPoint: Endpoints.payments + "/application-process",
                                         otp: fraudOtp,
                                         isPatch: summaryObject?.isPatch ?? false,
                                         succeed: parseApproveoperationRecordOrder,
                                         failed: handleFailure)
    }

    func parseApproveoperationRecordOrder(_: ConfirmResponse) {
        succesfulOperationCount += 1
        state.send(CardOpsSummaryViewState.transactionCompleted)
    }

    func recordPaymentTransaction(recordName: String) {
        guard var recordData = summaryObject?.recordData else { return }
        recordData["reusabilityData"] = ["reusableAction": "Save",
                                         "TransactionRecordName": recordName]
        paymentApi.recordTransaction(recordFields: recordData,
                                     succeed: parseRecordPayment,
                                     failed: handleFailure)
    }

    private func parseRecordPayment(_: PaymentRecordTransaction) {
        succesfulOperationCount += 1
        state.send(CardOpsSummaryViewState.transactionCompleted)
    }
}

extension CardOpsSummaryViewModel {
    func getContractCount() -> Int {
        guard let confirmResponse = summaryObject?.confirmResponse else { return 0 }
        return confirmResponse.contracts.count
    }

    func getContract(index: Int) -> ConfirmContract? {
        guard let confirmResponse = summaryObject?.confirmResponse else { return nil }
        guard getContractCount() > index else {
            return nil
        }
        return confirmResponse.contracts[index]
    }
}
