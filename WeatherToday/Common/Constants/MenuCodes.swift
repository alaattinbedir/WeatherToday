//
//  MenuCodes.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import ReactiveKit

enum MenuCode: Int {
    case unknown = 0
    case payBill = 4
    case mtv = 5
    case mtvNewPayment = 6
    case mtvAutomatic = 7
    case paymentWithMemberBusiness = 9
    case paymentWithQr = 10
    case lastMtvPayments = 13
    case debtPayment = 14
    case campaignPage = 15
    case createOrderedPayment = 21
    case customerIncome = 30
    case cashAdvance = 38
    case cashAdvanceWI = 39
    case installmentAfterAdvance = 41
    case intermTransaction = 43
    case extractAndDebtInfo = 45
    case cardPassword = 46
    case cardPermission = 47
    case lostStolen = 48
    case creditCardLimit = 50
    case regularLimitUpdate = 51
    case virtualCardLimit = 52
    case extendCardLimit = 53
    case cardDetail = 54
    case temporaryCloseCard = 55
    case virtualCardCancel = 56
    case statementFragment = 57
    case autoInstallment = 58
    case addTransportationCard = 59
    case addMoneyTransportation = 60
    case queryTransportation = 61
    case orderedPayment = 62
    case createExtendCard = 63
    case createVirtualCard = 64
    case extractDemand = 65
    case createCommitment = 67
    case displayCommitment = 68
    case transactionGroup = 69
    case recordedMtv = 70
    case updateMtv = 71
    case decreaseLimit = 72
    case updateCvv = 73
    case cardApplicationAfterLogin = 80
    case takeCardPassword = 82
    case qrPaymentOrRefund = 84
    case supCardLimitRestriction = 88
    case masterpassIntegration = 89
    case technoCardApplication = 92
    case businessCardLoan = 93
    case personalInfo = 101
    case notificationSettings = 102
    case referrer = 103
    case aboutApp = 104
    case createDotLockPattern = 106
    case fastPaySettings = 107
    case walkAndEarn = 108
    case showAllUnsuccessfulLogin = 111
    case profileAndSettings = 121
    case updateAddressesInfo = 123
    case securityQuestion = 130
    case securityWarnings = 131
    case operationMenu = 200
    case deliveryDetails = 10010
    case benefitTracking = 292
    case shopping = 300
    case campaignDetail = 320
    case showWebSite = 340
    case trafficPenalty = 350
    case useCardAllBonus = 351
    case exitFee = 360
    case recordedBills = 370
    case taxPayments = 380
    case sharedPayment = 411
    case viewSharedPayments = 412
    case pendingSharedPayments = 413
    case igapass = 500
    case domesticDepartures = 501
    case internationalDepartures = 502
    case internationalArrival = 503
    case igapassTermOfUse = 504
    case transitPassengers = 505
    case mainGateTransit = 506
    case addInstallment = 526
    case creditCardDebtRestructuring = 561
    case creditCardDebtRestructuringPayment = 562
    case cardDebtSafety = 600
    case inbox = 997
    case limitIncrease = 998
    case notifications = 999
    case gamificationOnBoarding = 1000
    case tutorial = 1001
    case waitingApproval = 1002
    case reverseOperations = 1003
    case mainPage = 1004
    case updateInfo = 1005
    case existingDocuments = 1006
    case omissions = 1007
    case secureDevices = 1009
    case qrcode = 1010
    case cardsPage = 1011
    case createUser = 1013
    case financialInfoPermission = 1015
    case extracts = 1017
    case extractPreferences = 1018
    case passaportFee = 1019
    case mobilePhoneFee = 1020
    case municipalPayment = 1021
    case otherTaxPayment = 1023
    case shoppingItem = 10020
    case gamification = 10030
    case bonusBusinessCardApplication = 10091
    case bonusBusinessMainCardApplication = 10092
    case bonusBusinessExtendCardApplication = 10093
    case createPrepaidVirtualCard = 10094
    case prepaidVirtualCardOperations = 10095
    case loadMoneyToOwnPrepaidVirtualCard = 10096
    case loadMoneyToOtherPrepaidVirtualCard = 10097
    case updatePrepaidVirtualCardCvv = 10100
    case loadMoneyToVepasCard = 10098
    case loadMoneyToPaycellCard = 10099
    case updateDebitCvv = 20202
    case updateVirtualDebitLimit = 20205
    case createVirtualDebit = 20207
    case updateDebitCardsLimit = 20209
    case updateDebitCardsAccount = 20210
    case seekerFinder = 20211
    case createDebitCard = 20212
    case createExtendedDebitCard = 20214
    case pazaryeri = 100_001
    case pazaryeriShop = 100_002
    case bonusBusinessCardLimitIncrease = 20301
    case businessCardLimitIncrease = 20302
    case bonusBusinessCardLimitDecrease = 20304
    case businessCardLimitDecrease = 20305
}

extension MenuModel {
    func navigate(source controller: BaseDataViewController? = nil,
                  presenter presenterController: UIViewController? = nil,
                  data: ViewModelData? = nil,
                  loggedInViaMenu: Bool = false,
                  navigationCompletion: (() -> Void)? = nil) {
        MenuNavigationController.shared.set(menu: self,
                                            source: controller,
                                            presenter: presenterController,
                                            data: data,
                                            loggedInViaMenu: loggedInViaMenu,
                                            navigationCompletion: navigationCompletion)
//        if !isLoginRequired(source: controller, presenter: presenterController, data: data) {
            switch menuId {
//            case .cashAdvance:
//                let pageData = CashAdvanceViewModelData(type: .noInstallment)
//                if let data = data as? CardOPSViewModelData {
//                    pageData.guid = data.guid
//                }
//                NavigationRouter.present(from: presenterController,
//                                         to: CashAdvanceVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: pageData)
//            case .payBill:
//                NavigationRouter.present(from: presenterController,
//                                         to: BillPayment1VC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .recordedBills:
//                NavigationRouter.present(from: presenterController,
//                                         to: RecordedBillsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .taxPayments:
//                NavigationRouter.present(from: presenterController,
//                                         to: TaxPaymentsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .sharedPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: SharePaymentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .viewSharedPayments:
//                NavigationRouter.present(from: presenterController,
//                                         to: ViewSharedPaymentsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .pendingSharedPayments:
//                NavigationRouter.present(from: presenterController,
//                                         to: PendingSharedPaymentsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .cashAdvanceWI:
//                let pageData = CashAdvanceViewModelData(type: .withInstallment)
//                if let data = data as? CardOPSViewModelData {
//                    pageData.guid = data.guid
//                }
//                NavigationRouter.present(from: presenterController,
//                                         to: CashAdvanceVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: pageData)
//            case .cardPassword:
//                NavigationRouter.present(from: presenterController,
//                                         to: CardPasswordVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .cardPermission:
//                NavigationRouter.present(from: presenterController,
//                                         to: CardPermissionVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .lostStolen:
//                NavigationRouter.present(from: presenterController,
//                                         to: LostStolenCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .virtualCardLimit:
//                NavigationRouter.present(from: presenterController,
//                                         to: VirtualCardLimitVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .virtualCardCancel:
//                NavigationRouter.present(from: presenterController,
//                                         to: VirtualCancelVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .creditCardLimit:
//                if tag != nil {
//                    let data = LimitIncreaseViewModelData(menuModel: self)
//                    NavigationRouter.present(from: presenterController,
//                                             to: LimitIncreaseVC(),
//                                             menu: self,
//                                             presentationStyle: .overCurrentContext,
//                                             data: data)
//                } else {
//                    NavigationRouter.present(from: presenterController,
//                                             to: CreditCardLimitVC(),
//                                             menu: self,
//                                             in: BaseRootVC(),
//                                             presentationStyle: .overCurrentContext)
//                }
//            case .regularLimitUpdate:
//                NavigationRouter.present(from: presenterController,
//                                         to: RegularLimitUpdateVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .debtPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: DebtPaymentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .temporaryCloseCard:
//                NavigationRouter.present(from: presenterController,
//                                         to: TemporaryCloseCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .extendCardLimit:
//                NavigationRouter.present(from: presenterController,
//                                         to: ExtendCardLimitUpdateVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .showAllUnsuccessfulLogin:
//                NavigationRouter.present(from: presenterController,
//                                         to: UnsuccessfulLoginsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .extractDemand:
//                NavigationRouter.present(from: presenterController,
//                                         to: ExtractDemandVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .cardDetail, .intermTransaction:
//                NavigationRouter.present(from: presenterController,
//                                         to: CardDetailVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .notifications:
//                NavigationRouter.present(from: presenterController,
//                                         to: NotificationsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .createVirtualCard:
//                NavigationRouter.present(from: presenterController,
//                                         to: VirtualCardCreateVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .installmentAfterAdvance:
//                NavigationRouter.present(from: presenterController,
//                                         to: InstallmentAfterAdvanceVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .extractAndDebtInfo:
//                NavigationRouter.present(from: presenterController,
//                                         to: DisplayReceiptVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .paymentWithMemberBusiness:
//                NavigationRouter.present(from: presenterController,
//                                         to: PaymentWithMerchantVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .paymentWithQr:
//                NavigationRouter.present(from: presenterController,
//                                         to: PaymentWithQrVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .mtvAutomatic:
//                NavigationRouter.present(from: presenterController,
//                                         to: MtvAutomaticPaymentInstructionVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .mtvNewPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: MTVNewVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .orderedPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: OrderedBillPaymentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .referrer:
//                NavigationRouter.present(from: presenterController,
//                                         to: ReferrerVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .createExtendCard:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreateExtendCard1VC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .statementFragment:
//                NavigationRouter.present(from: presenterController,
//                                         to: StatementFragment1VC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .personalInfo:
//                NavigationRouter.present(from: presenterController,
//                                         to: PersonalInfoVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .aboutApp:
//                NavigationRouter.present(from: presenterController,
//                                         to: AboutAppVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//
//            case .createDotLockPattern:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreateDotlockPatternVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .fastPaySettings:
//                NavigationRouter.present(from: presenterController,
//                                         to: FastPaySettingsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .addTransportationCard:
//                let viewModelData = SelectTransportationCardViewModelData(isShowCardName: true)
//                NavigationRouter.present(from: presenterController,
//                                         to: SelectTransportationCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: viewModelData)
//            case .addMoneyTransportation:
//                let viewModelData = AddQueryTransportationCardViewModelData(isAddMoney: true)
//                NavigationRouter.present(from: presenterController,
//                                         to: AddQueryTransportationCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: viewModelData)
//            case .queryTransportation:
//                let viewModelData = AddQueryTransportationCardViewModelData(isAddMoney: false)
//                NavigationRouter.present(from: presenterController,
//                                         to: AddQueryTransportationCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: viewModelData)
//            case .createOrderedPayment:
//                let data = BillPayment1ViewModelData(fromOrderedPayment: true)
//                NavigationRouter.present(from: presenterController,
//                                         to: BillPayment1VC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .customerIncome:
//                NavigationRouter.present(from: presenterController,
//                                         to: CustomerIncomeVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .profileAndSettings:
//                NavigationRouter.present(from: presenterController,
//                                         to: ProfileAndSettingsVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext)
//            case .updateAddressesInfo:
//                NavigationRouter.present(from: presenterController,
//                                         to: UpdateAddressesInfoVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .transactionGroup:
//                NavigationRouter.present(from: presenterController,
//                                         to: TransactionGroupVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .decreaseLimit:
//                let data = CreditCardLimitViewModelData(isDecrease: true)
//                NavigationRouter.present(from: presenterController,
//                                         to: CreditCardLimitVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .updateCvv:
//                var guid = ""
//                if let data = data as? CardOPSViewModelData {
//                    guid = data.guid~
//                }
//                let viewModelData = UpdateCvvViewModelData(virtualCardType: .creditCardVirtual,
//                                                           guid: guid)
//                NavigationRouter.present(from: presenterController,
//                                         to: UpdateCvvVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: viewModelData)
//            case .autoInstallment:
//                NavigationRouter.present(from: presenterController,
//                                         to: AutoInstallmentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .createCommitment:
//                NavigationRouter.present(from: presenterController,
//                                         to: CommitmentCampaignVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .displayCommitment:
//                NavigationRouter.present(from: presenterController,
//                                         to: CommitmentListVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .walkAndEarn:
//                NavigationRouter.present(from: presenterController,
//                                         to: WalkAndEarnVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .addInstallment:
//                NavigationRouter.present(from: presenterController,
//                                         to: AddInstallmentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .creditCardDebtRestructuring:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreditCardDebtSelectionForRestructuringVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .creditCardDebtRestructuringPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreditCardDebtRestructuringPaymentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .cardDebtSafety:
//                NavigationRouter.present(from: presenterController,
//                                         to: CardDebtSafetyVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .gamificationOnBoarding:
//                NavigationRouter.present(from: presenterController,
//                                         to: GamificationOnBoardingVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .gamification:
//                NavigationRouter.present(from: presenterController,
//                                         to: GamificationVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .lastMtvPayments:
//                NavigationRouter.present(from: presenterController,
//                                         to: LastMtvPaymentsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .recordedMtv:
//                NavigationRouter.present(from: presenterController,
//                                         to: RecordedMtvVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .updateMtv:
//                NavigationRouter.present(from: presenterController,
//                                         to: AutoMtvPaymentsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .cardApplicationAfterLogin:
//                if !KeychainKeeper.shared.isUserRegistered {
//                    NavigationRouter.present(from: presenterController,
//                                             to: AnonymCardApplicationVC(),
//                                             menu: self,
//                                             in: BaseRootVC(),
//                                             presentationStyle: .overCurrentContext)
//                } else {
//                    NavigationRouter.present(from: presenterController,
//                                             to: CreditCardApplicationFirstStepVC(),
//                                             menu: self,
//                                             in: BaseRootVC(),
//                                             presentationStyle: .overCurrentContext)
//                }
//            case .takeCardPassword:
//                NavigationRouter.present(from: presenterController,
//                                         to: TakeCardPasswordVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .qrPaymentOrRefund:
//                NavigationRouter.present(from: presenterController,
//                                         to: QrPaymentOrRefundVC(),
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .supCardLimitRestriction:
//                NavigationRouter.present(from: presenterController,
//                                         to: SupCardLimitRestrictionVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .masterpassIntegration:
//                NavigationRouter.present(from: presenterController,
//                                         to: MasterpassIntegrationVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .technoCardApplication:
//                NavigationRouter.present(from: presenterController,
//                                         to: TechnoCardApplicationVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .businessCardLoan:
//                NavigationRouter.present(from: presenterController,
//                                         to: BusinessCardLoanVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .campaignDetail:
//                NavigationRouter.present(from: presenterController,
//                                         to: CampaignDetailsVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .deliveryDetails:
//                if !SessionKeeper.shared.isUserLoggedIn {
//                    NavigationRouter.present(from: presenterController,
//                                             to: CardApplicationTrackingAnonymousLoginVC(),
//                                             menu: self,
//                                             in: BaseRootVC(),
//                                             presentationStyle: .overCurrentContext)
//                } else {
//                    NavigationRouter.present(from: presenterController,
//                                             to: CardApplicationTrackingVC(),
//                                             menu: self,
//                                             in: BaseRootVC(),
//                                             presentationStyle: .overCurrentContext)
//                }
//            case .shoppingItem:
//                break
//            case .mainPage:
//                NotificationCenter.default.post(name: .tabChanged, object: 0)
//            case .campaignPage:
//                NotificationCenter.default.post(name: .tabChanged, object: 1)
//            case .operationMenu:
//                NavigationRouter.present(from: presenterController,
//                                         to: OperationMenuVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .cardsPage:
//                NotificationCenter.default.post(name: .tabChanged, object: 3)
//            case .shopping:
//                NotificationCenter.default.post(name: .tabChanged, object: 4)
//            case .createUser:
//                NavigationRouter.present(from: presenterController,
//                                         to: IdentifyVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: CreateUserViewModelData(createType: .user))
//            case .showWebSite:
//                NavigationRouter.present(from: presenterController,
//                                         to: WebSiteVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .igapass:
//                NavigationRouter.present(from: presenterController,
//                                         to: IGAServiceSelectionVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext)
//            case .domesticDepartures,
//                 .internationalDepartures,
//                 .internationalArrival,
//                 .transitPassengers,
//                 .mainGateTransit:
//                let data = IGAPassViewModelData(isFromOperation: true, menuId: menuId)
//                NavigationRouter.present(from: presenterController,
//                                         to: IGAPassVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         data: data)
//            case .igapassTermOfUse:
//                NavigationRouter.present(to: IGAPassTermsOfUseVC())
//            case .tutorial:
//                let data = TutorialViewModelData(type: .video,
//                                                 name: .tutorialv3,
//                                                 hiddenCloseButton: false)
//                NavigationRouter.present(from: presenterController,
//                                         to: TutorialVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .notificationSettings:
//                NavigationRouter.present(from: presenterController,
//                                         to: NotificationSettingsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .trafficPenalty:
//                NavigationRouter.present(from: presenterController,
//                                         to: TrafficTicketPaymentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .useCardAllBonus:
//                NavigationRouter.present(from: presenterController,
//                                         to: TransferBonusPointsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .reverseOperations:
//                NavigationRouter.present(from: presenterController,
//                                         to: ReverseOperationsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .limitIncrease:
//                NavigationRouter.present(from: presenterController,
//                                         to: LimitIncreaseVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .exitFee:
//                NavigationRouter.present(from: presenterController,
//                                         to: OverseasExitFeeVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .mobilePhoneFee:
//                NavigationRouter.present(from: presenterController,
//                                         to: MobilePhoneFeeWithPassengersVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .passaportFee:
//                NavigationRouter.present(from: presenterController,
//                                         to: PassaportFeeVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .municipalPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: MunicipalPaymentVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .otherTaxPayment:
//                NavigationRouter.present(from: presenterController,
//                                         to: OtherTaxPaymentsLandingVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .securityQuestion:
//                NavigationRouter.present(from: presenterController,
//                                         to: SecurityQuestionVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .updateInfo:
//                NavigationRouter.present(from: presenterController,
//                                         to: ExtractDemandVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .securityWarnings:
//                NavigationRouter.present(from: presenterController,
//                                         to: SecurityWarningsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .waitingApproval:
//                NavigationRouter.present(from: presenterController,
//                                         to: WaitingApprovalVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .existingDocuments:
//                NavigationRouter.present(from: presenterController,
//                                         to: ExistingDocumentsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .omissions:
//                NavigationRouter.present(from: presenterController,
//                                         to: OmissionListVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .inbox:
//                let inboxData = NotificationsViewModelData()
//                NavigationRouter.present(from: presenterController,
//                                         to: NotificationsVC(),
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: inboxData)
//            case .extracts:
//                NavigationRouter.present(from: presenterController,
//                                         to: ExtractsVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .extractPreferences:
//                NavigationRouter.present(from: presenterController,
//                                         to: ExtractPreferencesVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .secureDevices:
//                NavigationRouter.present(from: presenterController,
//                                         to: SecureDevicesMenuVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .qrcode:
//                NavigationRouter.present(from: presenterController,
//                                         to: QRCodeIBLoginVC(),
//                                         menu: self,
//                                         presentationStyle: .overCurrentContext)
//            case .financialInfoPermission:
//                NavigationRouter.present(from: presenterController,
//                                         to: FinancialInfoPermissionVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .pazaryeri:
//                let pazaryeriVC = PazaryeriViewController(applicationId: 2,
//                                                          appVersion: Bundle.main.versionNumber ?? "Unknown",
//                                                          customerNo: SessionKeeper.shared.customerNo,
//                                                          url: PazaryeriSdk.url)
//                pazaryeriVC.modalPresentationStyle = .fullScreen
//                presenterController?.present(pazaryeriVC, animated: true)
//            case .pazaryeriShop:
//                break
//            case .createPrepaidVirtualCard:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreatePrepaidVirtualCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .loadMoneyToOwnPrepaidVirtualCard:
//                let data = LoadMoneyToPrepaidVirtualCardViewModelData(prepaidCardType: .ownCard)
//                NavigationRouter.present(from: presenterController,
//                                         to: LoadMoneyToPrepaidVirtualCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .loadMoneyToOtherPrepaidVirtualCard:
//                let data = LoadMoneyToPrepaidVirtualCardViewModelData(prepaidCardType: .otherCard)
//                NavigationRouter.present(from: presenterController,
//                                         to: LoadMoneyToPrepaidVirtualCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .updatePrepaidVirtualCardCvv:
//                var guid = ""
//                if let data = data as? CardOPSViewModelData {
//                    guid = data.guid~
//                }
//                let viewModelData = UpdateCvvViewModelData(virtualCardType: .prepaidVirtual,
//                                                           guid: guid)
//                NavigationRouter.present(from: presenterController,
//                                         to: UpdateCvvVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: viewModelData)
//            case .loadMoneyToVepasCard:
//                let data = LoadMoneyToPrepaidVirtualCardViewModelData(prepaidCardType: .vepas)
//                NavigationRouter.present(from: presenterController,
//                                         to: LoadMoneyToPrepaidVirtualCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .loadMoneyToPaycellCard:
//                let data = LoadMoneyToPrepaidVirtualCardViewModelData(prepaidCardType: .paycell)
//                NavigationRouter.present(from: presenterController,
//                                         to: LoadMoneyToPrepaidVirtualCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .benefitTracking:
//                NavigationRouter.present(from: presenterController,
//                                         to: BenefitTrackingVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .updateVirtualDebitLimit:
//                NavigationRouter.present(from: presenterController,
//                                         to: VirtualDebitCardUpdateLimitVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .createVirtualDebit:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreateVirtualDebitCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .updateDebitCvv:
//                NavigationRouter.present(from: presenterController,
//                                         to: UpdateVirtualDebitCardCvvVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .updateDebitCardsLimit:
//                NavigationRouter.present(from: presenterController,
//                                         to: DebitCardLimitVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .updateDebitCardsAccount:
//                NavigationRouter.present(from: presenterController,
//                                         to: DebitCardAccountUpdateVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .bonusBusinessMainCardApplication:
//                NavigationRouter.present(from: presenterController,
//                                         to: BonusBusinessCardApplicationVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .bonusBusinessExtendCardApplication:
//                NavigationRouter.present(from: presenterController,
//                                         to: BonusBusinessExtendCardApplicationVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .seekerFinder:
//                NavigationRouter.present(from: presenterController,
//                                         to: SeekerFinderVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
//            case .createDebitCard:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreateDebitCardFirstVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .createExtendedDebitCard:
//                NavigationRouter.present(from: presenterController,
//                                         to: CreateExtendedDebitCardVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext)
//            case .businessCardLimitIncrease,
//                 .bonusBusinessCardLimitIncrease,
//                 .businessCardLimitDecrease,
//                 .bonusBusinessCardLimitDecrease:
//                let data = BusinessCardLimitViewModelData(menuId: menuId)
//                NavigationRouter.present(from: presenterController,
//                                         to: BusinessCardLimitVC(),
//                                         menu: self,
//                                         in: BaseRootVC(),
//                                         presentationStyle: .overCurrentContext,
//                                         data: data)
            default:
                guard let controller = controller else { return }
//                NavigationRouter.push(from: controller,
//                                      to: CashAdvanceVC(),
//                                      data: data)
            }
            navigationCompletion?()
//        }
    }
}

class MenuNavigationController {
    static let shared = MenuNavigationController()
    private let bag = DisposeBag()

    var menu: MenuModel?
    var presenter: UIViewController?
    var source: BaseDataViewController?
    var data: ViewModelData?
    var loggedInViaMenu: Bool = false
    var navigationCompletion: (() -> Void)?

    private init() {
        let notificationNames: [NSNotification.Name] = [.loginDidComplete]
        notificationNames.forEach { notification in
            NotificationCenter.default.reactive.notification(name: notification).observeNext { [weak self] _ in
                guard let self = self else { return }
                guard let menu = self.menu else { return }
                menu.navigate(source: self.source,
                              presenter: self.presenter,
                              data: self.data,
                              navigationCompletion: self.navigationCompletion)
            }.dispose(in: bag)
        }
    }

    func set(menu: MenuModel?,
             source sourceController: BaseDataViewController?,
             presenter presenterController: UIViewController?,
             data: ViewModelData?,
             loggedInViaMenu: Bool,
             navigationCompletion: (() -> Void)?) {
        self.menu = menu
        source = sourceController
        presenter = presenterController
        self.data = data
        self.loggedInViaMenu = loggedInViaMenu
        self.navigationCompletion = navigationCompletion
    }
}
