//
//  CardOpsSummaryVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import inter_eCommerce
import UIKit

class CardOpsSummaryVC: BaseChildVC<CardOpsSummaryViewModel> {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var lblDescription: UILabel! {
        didSet {
            if descriptionFont != nil {
                lblDescription.font = descriptionFont
            }
        }
    }

    @IBOutlet var stackView: PairStackView!
    @IBOutlet var btnContinue: FormButton!

    var checkBoxView: CheckBoxView?
    var isCardWidgetTitleBold: Bool = false
    var descriptionFont: UIFont?
    var otpType: OtpType = .cardOps
    var leftBarButtons: [NavigationBarButton] = [.back(nil)]
    var checkboxIndex = 0
    var stackViewBackgroundColor: UIColor = .white
    let screenWidth = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data as? CardOpsSummaryViewModelData {
            viewModel.summaryObject = data.summaryObject
            viewModel.otpType = data.otpType ?? .cardOps
            viewModel.plateNumber = data.plateNumber ?? ""
            viewModel.handler = data.handler
            isButtonEnable(summaryObject: data.summaryObject)
            if data.summaryObject?.backButtonDisable ?? false {
                leftBarButtons = []
            }
        }
        NotificationCenter.default
            .reactive
            .notification(name: .sendEvent).observeNext { [weak self] _ in
                self?.sendSuccessEvent()
            }.dispose(in: bag)
        addSummaryEvent()
    }

    func isButtonEnable(summaryObject: SummaryObject?) {
        btnContinue.isEnabled = true
        guard let summaryObject = summaryObject else { return }
        let widgets = summaryObject.widgets
        for widget in widgets {
            switch widget {
            case .checkBox:
                btnContinue.isEnabled = viewModel.summaryObject?.confirmResponse?.contracts.count ?? 0 < 1
            default:
                break
            }
        }
    }

    override func bind() {
        super.bind()
        btnContinue.reactive.tap.bind(to: self) { $0.viewModel.approveOperation() }.dispose(in: bag)
        viewModel.canContinueEnabled.observeNext { [weak self] value in
            guard let value = value else { return }
            self?.btnContinue.isEnabled = value
        }.dispose(in: bag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updatePage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.isHidden = true
    }

    override func onStateChanged(_ state: ViewState) {
        super.onStateChanged(state)
        guard let state = state as? CardOpsSummaryViewState else { return }
        switch state {
        case let .openOtp(data):
            NavigationRouter.present(from: getRootVC(),
                                     to: LoginOTPVC(),
                                     in: BaseRootVC(),
                                     presentationStyle: .overCurrentContext,
                                     data: data)
        case let .proceedResult(viewModelData):
            NavigationRouter.push(from: self,
                                  to: CardOpsResultVC(),
                                  navigationOption: .popAll,
                                  data: viewModelData)
        case .transactionCompleted:
            checkBoxView?.changeRecordButtonImage()
        case .popWithHandler:
            if let handler = viewModel.handler {
                handler()
                NavigationRouter.pop()
            }
        }
    }

    override func getLeftBarButtonItems() -> [NavigationBarButton] {
        return leftBarButtons
    }

    override func getRightBarButtonItems() -> [NavigationBarButton] {
        let data = NavigationBarButtonData(image: #imageLiteral(resourceName: "closeWhite")) { _ in
            NavigationRouter.dismiss()
        }
        return [.custom(data)]
    }

    override func getNavigationBarBgColor() -> UIColor {
        return .azureThree
    }

    override func getWillShowTitleAndStep() -> Bool {
        return true
    }

    func updatePage() {
        pageTitle.value = viewModel.summaryObject?.title
        pageStep.value = viewModel.summaryObject?.stepNumber
        if viewModel.summaryObject?.description != "" {
            lblDescription.text = viewModel.summaryObject?.description
        } else {
            lblDescription.isHidden = true
        }
        let approveKey = viewModel.summaryObject?.approveKey ?? ""
        if approveKey.contains("CommitmentDetail") {
            btnContinue.isHidden = true
        } else if approveKey.isEmpty ||
            approveKey.contains("Summary.Button") ||
            approveKey.contains("Commitment") ||
            approveKey.contains("NonExistingContinue") {
            btnContinue.resource = .approveButton
        } else if approveKey == "CardInsurance.Save" {
            btnContinue.resource = .cardInsuranceSave
        } else if approveKey == ResultButton.updateCvv {
            btnContinue.resource = .updateCVVButton
        } else if approveKey == ResultButton.virtualCardCreate {
            btnContinue.resource = .virtualCardApproveButton
        } else if approveKey == ResultButton.qrPayment {
            btnContinue.resource = .qrPaymentCommitmentButton
        } else if approveKey == ResultButton.updateAddressInfo {
            btnContinue.resource = .addressUpdateSummaryApproveButton
        } else {
            btnContinue.setTitle(approveKey, for: .normal)
        }
        stackView.removeAllArrangedSubviews()
        addWidgets(widgets: viewModel.summaryObject?.topWidgets)
        addPairStackViews()
        addWidgets(widgets: viewModel.summaryObject?.widgets)
        scrollView.isHidden = false
    }

    private func refreshContractButtonStatus() {
        viewModel.canContinueEnabled.value = viewModel.canContinue()
    }

    private func setStackView() -> UIStackView {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        return stack
    }

    private func addStackView(_ pair: KeyValuePair, _ stack: UIStackView) {
        guard let summaryPairView = SummaryPairView.loadFromNib() else { return }
        if let pairWithToolTip = viewModel.summaryObject?.summariesWithToolTip?.first(where: { $0 == pair }) {
            summaryPairView.updatePairView(key: pairWithToolTip.key, value: pairWithToolTip.value, toolTipValue: pairWithToolTip.tooltipData)
        } else {
            summaryPairView.updatePairView(key: pair.key, value: pair.value)
        }
        stack.addArrangedSubview(summaryPairView)
        stackView.addArrangedSubview(stack)
        summaryPairView.backgroundColor = stackViewBackgroundColor
        stackViewBackgroundColor = stackViewBackgroundColor == .white ? .paleGrey : .white
    }

    private func addStackViewHorizontal(_ summaries: [KeyValuePair],
                                        _ index: Int,
                                        _ pair: KeyValuePair,
                                        _ stack: UIStackView) {
        guard let preSummaryPairView = SummaryPairView.loadFromNib() else { return }
        if let pairWithToolTip = viewModel.summaryObject?.summariesWithToolTip?.first(where: { $0 == summaries[index - 1] }) {
            preSummaryPairView.updatePairView(key: pairWithToolTip.key, value: pairWithToolTip.value, toolTipValue: pairWithToolTip.tooltipData)
        } else {
            preSummaryPairView.updatePairView(key: summaries[index - 1].key,
                                              value: summaries[index - 1].value)
        }
        guard let summaryPairView = SummaryPairView.loadFromNib() else { return }
        if let pairWithToolTip = viewModel.summaryObject?.summariesWithToolTip?.first(where: { $0 == pair }) {
            summaryPairView.updatePairView(key: pairWithToolTip.key, value: pairWithToolTip.value, toolTipValue: pairWithToolTip.tooltipData)
        } else {
            summaryPairView.updatePairView(key: pair.key, value: pair.value)
        }
        stack.addArrangedSubview(preSummaryPairView)
        stack.addArrangedSubview(summaryPairView)
        summaryPairView.snp.makeConstraints { make in
            make.width.equalTo(preSummaryPairView.snp.width)
        }
        stackView.addArrangedSubview(stack)
        stack.backgroundColor = stackViewBackgroundColor
        preSummaryPairView.backgroundColor = stackViewBackgroundColor
        summaryPairView.backgroundColor = stackViewBackgroundColor
        stackViewBackgroundColor = stackViewBackgroundColor == .white ? .paleGrey : .white
    }

    private func addStackViewVertical(_ summaries: [KeyValuePair],
                                      _ index: Int,
                                      _ stack: UIStackView) {
        let prePair = summaries[index - 1]
        guard let presummaryPairView = SummaryPairView.loadFromNib() else { return }
        if let pairWithToolTip = viewModel.summaryObject?.summariesWithToolTip?.first(where: { $0 == prePair }) {
            presummaryPairView.updatePairView(key: pairWithToolTip.key, value: pairWithToolTip.value, toolTipValue: pairWithToolTip.tooltipData)
        } else {
            presummaryPairView.updatePairView(key: prePair.key, value: prePair.value)
        }
        stack.addArrangedSubview(presummaryPairView)
        presummaryPairView.backgroundColor = stackViewBackgroundColor
        stackViewBackgroundColor = stackViewBackgroundColor == .white ? .paleGrey : .white
        stackView.addArrangedSubview(stack)
        let stack2 = setStackView()
        let pair = summaries[index]
        guard let summaryPairView = SummaryPairView.loadFromNib() else { return }
        if let pairWithToolTip = viewModel.summaryObject?.summariesWithToolTip?.first(where: { $0 == pair }) {
            summaryPairView.updatePairView(key: pairWithToolTip.key, value: pairWithToolTip.value, toolTipValue: pairWithToolTip.tooltipData)
        } else {
            summaryPairView.updatePairView(key: pair.key, value: pair.value)
        }
        stack2.addArrangedSubview(summaryPairView)
        stackView.addArrangedSubview(stack2)
        summaryPairView.backgroundColor = stackViewBackgroundColor
        stackViewBackgroundColor = stackViewBackgroundColor == .white ? .paleGrey : .white
    }

    private func getKeyWidth(_ pair: KeyValuePair) -> CGFloat {
        let keyWidth = pair.key.width(withConstrainedHeight: .greatestFiniteMagnitude,
                                      font: AppFont.semibold15)
        return keyWidth
    }

    private func getValueWidth(_ pair: KeyValuePair) -> CGFloat {
        let valueWidth = pair.value.width(withConstrainedHeight: .greatestFiniteMagnitude,
                                          font: AppFont.bold16)
        return valueWidth
    }

    private func setPreviourPair(_ pair: KeyValuePair,
                                 _ index: Int,
                                 _ summaries: [KeyValuePair],
                                 _ stack: UIStackView) {
        if getKeyWidth(pair) < (screenWidth / 2 - 40), getValueWidth(pair) < (screenWidth / 2 - 40) {
            addStackViewHorizontal(summaries, index, pair, stack)
        } else {
            addStackViewVertical(summaries, index, stack)
        }
    }

    func addPairStackViews() {
        guard let summaries = viewModel.summaryObject?.summaries else { return }
        var userPerivousPair = false
        for (index, pair) in summaries.enumerated() {
            let stack = setStackView()
            if summaries.count == 1 || (index == summaries.count - 1 && !userPerivousPair) {
                addStackView(pair, stack)
            } else if userPerivousPair {
                setPreviourPair(pair, index, summaries, stack)
                userPerivousPair = false
            } else {
                if getKeyWidth(pair) > (screenWidth / 2 - 40) || getValueWidth(pair) > (screenWidth / 2 - 40) {
                    addStackView(pair, stack)
                } else {
                    userPerivousPair = true
                }
            }
        }
    }

    func addWidgets(widgets: [SummaryWidget]?) {
        guard let widgets = widgets else { return }
        checkboxIndex = 0
        for widget in widgets {
            switch widget {
            case let .card(title, cardDetail, isAmountHidden, isShowBonus, isShowBalance):
                cardWidget(title: title,
                           cardDetail: cardDetail,
                           isAmountHidden: isAmountHidden,
                           isShowBonus: isShowBonus,
                           isShowBalance: isShowBalance)
                viewModel.cardGuid = cardDetail.guid
            case let .balanceInfo(balanceInfo):
                if viewModel.summaryObject?.approveKey == ResultButton.addMoney {
                    return
                }
                guard let widgetView = BalanceInfoView.loadFromNib() else { return }
                widgetView.balanceInfo = balanceInfo
                setWidgetView(widgetView)
            case let .checkBox(index, title, hasRecord, keyword, record):
                checkboxWidget(index: index, title: title, hasRecord: hasRecord, keyword: keyword, record: record)
            case let .warningInfoView(type, textList, isHtmlText, fontName):
                warningInfoViewWidget(type: type,
                                      textList: textList,
                                      isHtmlText: isHtmlText,
                                      font: fontName)
            case let .paymentInfo(title, keyValuePairs):
                guard let paymentInfoView = PaymentInfoView.loadFromNib() else { return }
                paymentInfoView.lblTitle.text = title
                setWidgetView(paymentInfoView)
                stackView.addPairsToStack(pairs: keyValuePairs,
                                          removeAllViews: false)
            case let .paymentPlan(title, paymentPlan):
                paymentPlanWidget(title: title, paymentPlan: paymentPlan)
            case let .paymentTable(title, paymentTable):
                paymentTableWidget(title: title, paymentTable: paymentTable)
            case let .confirmation(title):
                confirmationWidget(title: title)
            }
        }
    }

    private func cardWidget(title: String,
                            cardDetail: CardDetail,
                            isAmountHidden: Bool,
                            isShowBonus _: Bool = false,
                            isShowBalance: Bool = false) {
        guard let widgetView = SummaryCardWidget.loadFromNib() else { return }
        widgetView.card = cardDetail
        if viewModel.summaryObject?.approveKey == "Summary.Button.ApproveCashAdvance" {
            widgetView.configureView(title: title, limitTitle: .availableCashLimit)
        } else if viewModel.summaryObject?.approveKey == "Summary.Button.TransferBonus" {
            widgetView.configureView(title: title, limitTitle: .bonusTransferAvailableBonus, isShowBonus: true)
        } else if widgetView.card?.cardType == .debit || widgetView.card?.cardType == .extendedDebit || widgetView.card?.cardType == .virtualDebit {
            widgetView.configureView(title: title, limitTitle: .cardDetailAccountBalanceWithKmh, isShowBalance: isShowBalance)
        } else {
            widgetView.configureView(title: title)
        }
        if isCardWidgetTitleBold {
            widgetView.lblTitle.font = AppFont.bold14
        }
        if isAmountHidden {
            widgetView.lblLimitTitle.removeFromSuperview()
            widgetView.lblLimit.removeFromSuperview()
            widgetView.seperatorView.removeFromSuperview()
        }
        setWidgetView(widgetView)
    }

    private func warningInfoViewWidget(type: WarningInfoType,
                                       textList: [String],
                                       isHtmlText: Bool = false,
                                       font: UIFont? = nil) {
        if viewModel.summaryObject?.approveKey == ResultButton.addMoney ||
            viewModel.summaryObject?.approveKey == ResultButton.createPrepaidVirtualCard {
            return
        }
        guard let widgetView = WarningInfoAlertView.loadFromNib() else { return }
        var labels: [UILabel] = []
        for (index, text) in textList.enumerated() {
            let label = UILabel.createModel1(text: text, font: font)
            if isHtmlText {
                label.setHTMLFromString(htmlText: text)
            }

            label.accessibilityIdentifier = "\(AccessibilityKey.label.rawValue)\(index).warning"
            labels.append(label)
        }
        widgetView.configureView(type: type, labels: labels)
        setWidgetView(widgetView)
    }

    private func paymentPlanWidget(title: String, paymentPlan: [PaymentPlan]) {
        let paymentPlanTitle = UILabel()
        paymentPlanTitle.text = title
        paymentPlanTitle.textColor = .blackEight
        paymentPlanTitle.font = AppFont.bold16
        setWidgetView(paymentPlanTitle)

        let paymentPlanView = UIView()
        paymentPlanView.layer.borderWidth = 1
        paymentPlanView.layer.borderColor = UIColor.lightGreyBlueTwo.cgColor
        paymentPlanView.layer.cornerRadius = 10
        paymentPlanView.clipsToBounds = true

        guard let paymentPlanArray = paymentPlan.first else { return }
        let height = (paymentPlanArray.value.count * 25) + 36

        paymentPlanView.snp.makeConstraints { $0.height.equalTo(height) }
        setWidgetView(paymentPlanView)

        let paymentPlanStackView = UIStackView()
        paymentPlanStackView.axis = .vertical
        paymentPlanStackView.distribution = .fill
        paymentPlanStackView.alignment = .fill

        guard let header = PaymentPlanHeaderView.loadFromNib() else { return }
        header.snp.makeConstraints { $0.height.equalTo(36) }
        header.configureView()
        paymentPlanStackView.addArrangedSubview(header)

        for i in paymentPlan {
            for plan in i.value {
                guard let row = PaymentPlanRowView.loadFromNib() else { return }
                row.snp.makeConstraints { $0.height.equalTo(25) }
                row.plan = plan
                paymentPlanStackView.addArrangedSubview(row)
            }
        }
        paymentPlanStackView.frame.size.height = CGFloat(height)
        paymentPlanStackView.frame.size.width = stackView.frame.size.width - 40
        paymentPlanView.addSubview(paymentPlanStackView)
    }

    private func paymentTableWidget(title: String, paymentTable: [PaymentsTable]) {
        let paymentPlanTitle = UILabel()
        paymentPlanTitle.text = title
        paymentPlanTitle.textColor = .blackEight
        paymentPlanTitle.textAlignment = .center
        paymentPlanTitle.font = AppFont.bold16
        setWidgetView(paymentPlanTitle)

        let paymentPlanView = UIView()
        paymentPlanView.layer.borderWidth = 1
        paymentPlanView.layer.borderColor = UIColor.lightGreyBlueTwo.cgColor
        paymentPlanView.clipsToBounds = true

        guard let paymentPlanArray = paymentTable.first?.value.first?.items else { return }
        guard let paymentPlanFooter = paymentTable.first?.value.first?.footer else { return }
        let height = (paymentPlanArray.count * 25) + 36

        paymentPlanView.snp.makeConstraints { $0.height.equalTo(height) }
        setWidgetView(paymentPlanView)

        let paymentPlanStackView = UIStackView()
        paymentPlanStackView.axis = .vertical
        paymentPlanStackView.distribution = .fill
        paymentPlanStackView.alignment = .fill

        paymentPlanStackView.addArrangedSubview(getPaymentTableSeperator())
        guard let header = PaymentTableHeaderView.loadFromNib() else { return }
        header.snp.makeConstraints { $0.height.equalTo(36) }
        header.configureView()
        paymentPlanStackView.addArrangedSubview(header)
        paymentPlanStackView.addArrangedSubview(getPaymentTableSeperator())

        for plan in paymentPlanArray {
            guard let row = PaymentTableRowView.loadFromNib() else { return }
            row.snp.makeConstraints { $0.height.equalTo(25) }
            row.paymentTableInstallment = plan
            paymentPlanStackView.addArrangedSubview(row)
            paymentPlanStackView.addArrangedSubview(getPaymentTableSeperator())
        }

        guard let footer = PaymentTableFooterView.loadFromNib() else { return }
        footer.snp.makeConstraints { $0.height.equalTo(36) }
        footer.paymentTableInstallmentFooter = paymentPlanFooter
        setWidgetView(footer)

        paymentPlanStackView.frame.size.height = CGFloat(height)
        paymentPlanStackView.frame.size.width = stackView.frame.size.width - 40
        paymentPlanView.addSubview(paymentPlanStackView)
    }

    func getPaymentTableSeperator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGreyBlueTwo
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }

    private func checkboxWidget(index: Int, title: String, hasRecord: Bool, keyword: String, record: String? = nil) {
        if viewModel.summaryObject?.approveKey == ResultButton.addMoney {
            return
        }
        let checkBoxView = CheckBoxView.loadFromNib()
        if !(viewModel.summaryObject?.checkboxHeightControlDisable ?? false) {
            checkBoxView?.snp.makeConstraints { $0.height.equalTo(index == 0 ? 55 : 40) }
        }
        checkBoxView?.index = checkboxIndex
        checkboxIndex += 1
        let handler = getCheckBoxHandler(index: index, hasRecord: hasRecord, keyword: keyword, checkBoxView: checkBoxView)
        let handlerRecord: ((String?) -> Void)? = { [weak self] record in
            self?.checkBoxView = checkBoxView
            if keyword == ResultButton.checkBoxMtvSave {
                self?.viewModel.recordMtvTransaction(recordName: record~)
            } else if keyword == ResultButton.checkBoxAddRegisteredInstruction {
                self?.viewModel.recordPaymentTransaction(recordName: record~)
            } else if keyword == ResultButton.checkboxAddPaymentOrder {
                self?.viewModel.recordPaymentOrder(recordName: record~)
            }
        }
        if index == 0 {
            guard let response = viewModel.summaryObject?.confirmResponse else { return }
            let contract = viewModel.summaryObject?.confirmResponse?.contracts[checkboxIndex - 1]
            if let installmentResponse = response as? InstallmentConfirmResponse,
               checkboxIndex - 1 == 0 {
                contract?.payments = installmentResponse.payments
            }
            checkBoxView?.configureView(hasPaymentPlan: true,
                                        response: response,
                                        rootPageVC: getRootVC(),
                                        selectedImg: #imageLiteral(resourceName: "checkboxA"),
                                        unSelectedImg: #imageLiteral(resourceName: "checkboxP"),
                                        title: title,
                                        contract: contract,
                                        handler: handler)
        } else {
            var recordTitle = ""
            var recordPlaceHolder = ""
            if keyword == ResultButton.checkBoxMtvSave {
                recordTitle = ResourceKey.paymentsMTVNewPaymentRecordName.value
                recordPlaceHolder = ResourceKey.paymentsMTVNewPaymentRecordNameExample.value
            } else if keyword == ResultButton.checkBoxAddRegisteredInstruction {
                recordTitle = ResourceKey.paymentNewInstructionRegisteredName.value
                recordPlaceHolder = ResourceKey.paymentNewInstructionDescriptionText.value
            } else if keyword == ResultButton.checkboxAddPaymentOrder {
                recordTitle = ResourceKey.paymentNewInstructionPaymentOrder.value
                recordPlaceHolder = ResourceKey.paymentNewInstructionDescriptionText.value
            }
            checkBoxView?.configureView(selectedImg: #imageLiteral(resourceName: "checkboxA"),
                                        unSelectedImg: #imageLiteral(resourceName: "checkboxP"),
                                        title: title,
                                        handler: handler,
                                        hasRecord: hasRecord,
                                        recordTitle: recordTitle,
                                        recordPlaceHolder: recordPlaceHolder,
                                        handlerRecord: handlerRecord)
        }
        if let checkBoxView = checkBoxView {
            setWidgetView(checkBoxView)
        }
    }

    private func getCheckBoxHandler(index: Int, hasRecord: Bool, keyword: String, checkBoxView: CheckBoxView?) -> ((Bool?, Int?) -> Void)? {
        let handler: ((Bool?, Int?) -> Void)? = { isSelected, selectedCheckboxIndex in
            if index == 0 {
                self.viewModel.summaryObject?.confirmResponse?
                    .contracts[selectedCheckboxIndex ?? 0].isApproved = isSelected ?? false
                self.refreshContractButtonStatus()
            }
            checkBoxView?.isSelected = isSelected ?? false
            if isSelected~, hasRecord~ {
                self.btnContinue.isEnabled = false
                if index != 0 {
                    self.mtvEnableButton(keyword: keyword, isAdd: true)
                    self.viewModel.selectedCheckBoxCount += 1
                }
                if !(self.viewModel.summaryObject?.checkboxHeightControlDisable ?? false) {
                    checkBoxView?.snp.updateConstraints { $0.height.equalTo(140) }
                }
            } else {
                var isOptional = false
                if !(self.viewModel.summaryObject?
                    .confirmResponse?.contracts.isEmpty)~ {
                    isOptional = (self.viewModel.summaryObject?
                        .confirmResponse?
                        .contracts[selectedCheckboxIndex ?? 0]
                        .isOptional)~
                }
                if !isOptional~, !isSelected~, index != 0 {
                    self.mtvEnableButton(keyword: keyword, isAdd: false)
                    self.viewModel.selectedCheckBoxCount -= 1
                }
                if !(self.viewModel.summaryObject?.checkboxHeightControlDisable ?? false) {
                    checkBoxView?.snp.updateConstraints { $0.height.equalTo(index == 0 ? 55 : 40) }
                }
            }
            self.stackView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
        return handler
    }

    private func confirmationWidget(title: String) {
        let checkBoxView = CheckBoxView.loadFromNib()

        btnContinue.isEnabled = false

        let handler: ((Bool?, Int?) -> Void)? = { isSelected, _ in
            self.btnContinue.isEnabled = isSelected~
        }
        checkBoxView?.configureView(selectedImg: #imageLiteral(resourceName: "checkboxA"),
                                    unSelectedImg: #imageLiteral(resourceName: "checkboxP"),
                                    title: title,
                                    handler: handler,
                                    confirmation: true)
        if let checkBoxView = checkBoxView {
            setWidgetView(checkBoxView)
        }
    }

    private func mtvEnableButton(keyword: String, isAdd: Bool) {
        if keyword == ResultButton.checkBoxMtvSave {
            viewModel.succesfulOperationCount += isAdd ? 1 : -1
        }
    }

    private func sendSuccessEvent() {
        guard let summaryObject = viewModel.summaryObject else { return }
        let endPoint = summaryObject.endPoint
        switch endPoint {
        case "\(Endpoints.payments)/process/transportation-card":
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.transportationCardTransactions.rawValue,
                                             eventAction: "ulasim_kart_yukle_3_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.transportationPaid.rawValue)
        case Endpoints.bonusPromiseCommitmentSet:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.commitmentJoin.rawValue)
        case Endpoints.multiTransaction:
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "taksitlendir_4_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel,
                                             eventValue: SessionKeeper.shared.eventValue)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.installment.rawValue)
        case Endpoints.cashAdvance:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.cashAdvanceSucceed.rawValue)
        case Endpoints.cashAdvanceWithInstallment:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.installmentCashAdvance.rawValue)
        case Endpoints.changeCardPin:
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "kart_sifresi_degistir_3_basarili")
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.cardPassword.rawValue)
        case Endpoints.completeCardApp:
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "kart_basvuru_4_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.cardApplication.rawValue)
        case Endpoints.applyTechnoCard:
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "isletme_kart_basvuru_2_basarili")
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.technoCardApplication.rawValue)
        case Endpoints.requestLimit:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.limitIncreaseDemand.rawValue)
        case Endpoints.autoeppApprove:
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "otomatik_taksitlendir_3_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.automaticInstallment.rawValue)
        case Endpoints.cardInsurance:
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "kart_borcum_guvende_3_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.cardDebtSafe.rawValue)
        case Endpoints.payments + "/process-mvt-payment":
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.paymentTransactions.rawValue,
                                             eventAction: "mtv_odeme_4_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel,
                                             eventValue: SessionKeeper.shared.eventValue)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.mtvPayment.rawValue)
        case Endpoints.payments + "/process":
            sendBillPaymentSuccessEvent(isAutoPay: false)
            setAdjustEvent(isAutoPay: false)
        case Endpoints.payments + "/application-process":
            if !SessionKeeper.shared.isUpdateApplicationProcess {
                sendBillPaymentSuccessEvent(isAutoPay: true)
                setAdjustEvent(isAutoPay: true)
            } else {
                AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.updateBillDemand.rawValue)
            }
        case Endpoints.cardsBonusTransfer:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.transferBonusPoints.rawValue)
        case Endpoints.paymentsPayPassaportTax:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.passportFeePayment.rawValue)
        case Endpoints.paymentsPayInternationalDepartureFee:
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.overseasDepartureFeePayment.rawValue)
        default:
            break
        }
        checkEndpoints(endPoint)
    }

    private func setAdjustEvent(isAutoPay: Bool) {
        switch SessionKeeper.shared.associationCode {
        case AssociationCode.phone.rawValue:
            AnalyticsHelper.sendAdjustEvent(adjustToken: isAutoPay ? AdjustToken.automaticPayPhone.rawValue
                : AdjustToken.payPhone.rawValue)
        case AssociationCode.gas.rawValue:
            AnalyticsHelper.sendAdjustEvent(adjustToken: isAutoPay ? AdjustToken.automaticPayNaturalGas.rawValue
                : AdjustToken.payNaturalGas.rawValue)
        case AssociationCode.electric.rawValue:
            AnalyticsHelper.sendAdjustEvent(adjustToken: isAutoPay ? AdjustToken.automaticPayElectric.rawValue
                : AdjustToken.payElectric.rawValue)
        case AssociationCode.water.rawValue:
            AnalyticsHelper.sendAdjustEvent(adjustToken: isAutoPay ? AdjustToken.automaticPayWater.rawValue
                : AdjustToken.payWater.rawValue)
        case AssociationCode.telecom.rawValue:
            AnalyticsHelper.sendAdjustEvent(adjustToken: isAutoPay ? AdjustToken.automaticPayTelecom.rawValue
                : AdjustToken.payTelecom.rawValue)
        default:
            break
        }
    }

    private func checkEndpoints(_ endPoint: String) {
        if endPoint.contains(turkishString: Endpoints.cardDebtPayment, caseSensitive: false) {
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.debtPayment.rawValue)
        } else if endPoint.contains(turkishString: Endpoints.virtualCardCreate, caseSensitive: false) {
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "sanal_kart_olusturma_3_basarili")
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.createVirtualCard.rawValue)
        } else if endPoint.contains(turkishString: Endpoints.virtualCardCancel, caseSensitive: false) {
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "sanal_kart_kapatma_3_basarili")
        } else if endPoint.contains(turkishString: Endpoints.extendCards, caseSensitive: false) {
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.extendCardApplication.rawValue)
        } else if endPoint.contains(turkishString: Endpoints.lostCard, caseSensitive: false) {
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: "kayip_calinti_bildir_4_basarili",
                                             eventLabel: SessionKeeper.shared.eventLabel)
        } else if endPoint.contains(turkishString: Endpoints.virtualCardUpdateCvv, caseSensitive: false) {
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.virtualCardCvvUpdate.rawValue)
        } else if endPoint.contains(turkishString: Endpoints.processQrTransaction, caseSensitive: false) {
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.paymentWithQrcode.rawValue)
        } else if endPoint.contains(turkishString: Endpoints.closeCard, caseSensitive: false) {
            guard let summaryObject = viewModel.summaryObject else { return }
            let requestType = summaryObject.requestDict?["requestType"] as? TemporaryCloseCardRequestType
            let action = requestType == .open ? "kapali_kart_acma_3_basarili" : "gecici_kart_kapatma_3_basarili"
            AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                             eventAction: action,
                                             eventLabel: SessionKeeper.shared.eventLabel)
            AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.openClosedCard.rawValue)
            if requestType == .close {
                AnalyticsHelper.sendAdjustEvent(adjustToken: AdjustToken.closeTemporaryCard.rawValue)
            }
        }
    }

    private func sendBillPaymentSuccessEvent(isAutoPay: Bool) {
        var eventAction = !isAutoPay ? "cep_telefonu_faturasi_odeme_6_basarili" : "cep_telefonu_otomatik_odeme_5_basarili"
        switch SessionKeeper.shared.associationCode {
        case AssociationCode.phone.rawValue:
            eventAction = !isAutoPay ? "cep_telefonu_faturasi_odeme_6_basarili" : "cep_telefonu_otomatik_odeme_5_basarili"
        case AssociationCode.gas.rawValue:
            eventAction = !isAutoPay ? "dogalgaz_faturasi_odeme_6_basarili" : "dogalgaz_otomatik_odeme_5_basarili"
        case AssociationCode.electric.rawValue:
            eventAction = !isAutoPay ? "elektrik_faturasi_odeme_6_basarili" : "elektrik_otomatik_odeme_5_basarili"
        case AssociationCode.water.rawValue:
            eventAction = !isAutoPay ? "su_faturasi_odeme_6_basarili" : "su_otomatik_odeme_5_basarili"
        case AssociationCode.telecom.rawValue:
            eventAction = !isAutoPay ? "telekom_faturasi_odeme_6_basarili" : "telekom_otomatik_odeme_5_basarili"
        default:
            break
        }
        AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.invoiceTransactions.rawValue,
                                         eventAction: eventAction,
                                         eventLabel: SessionKeeper.shared.eventLabel,
                                         eventValue: SessionKeeper.shared.eventValue)
    }

    private func addSummaryEvent() {
        if let pageName = SessionKeeper.shared.eventPageName {
            switch pageName {
            case .mtvPayment:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.paymentTransactions.rawValue,
                                                 eventAction: "mtv_odeme_3")
            case .autoInstallment:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                                 eventAction: "otomatik_taksitlendir_2")
            case .lostStolen:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                                 eventAction: "kayip_calinti_bildir_3")
            case .createVirtual:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                                 eventAction: "sanal_kart_olusturma_2")
            case .cancelVirtual:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                                 eventAction: "sanal_kart_kapatma_2")
            case .cardApplication:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                                 eventAction: "kart_basvuru_3")
            case .changeCardPassword:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.cardTransactions.rawValue,
                                                 eventAction: "kart_sifresi_degistir_2")
            case .eExtractDemand:
                break
            case .addTransportationCard:
                AnalyticsHelper.sendNetmeraEvent(eventCategory: EventCategory.transportationCardTransactions.rawValue,
                                                 eventAction: "ulasim_kart_ekleme_2")
            default:
                break
            }
        }
    }

    private func setWidgetView(_ widgetView: UIView) {
        let viewCustom: UIView = UIView()
        viewCustom.addSubview(widgetView)
        widgetView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        stackView.addArrangedSubview(viewCustom)
    }

    override func setAccessibilityIdentifiers() {
        lblDescription.accessibilityKey = .description
        btnContinue.accessibilityKey = .continueButton
    }
}
