//
//  Constants.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import UIKit

struct Key {
    #if STORE
        static let AppGroupId = "group.denizkartim"
    #else
        static let AppGroupId = "group.denizkartim.internal"
    #endif

    enum UserDefaults {
        static let hasAppRunBefore = "hasAppRunBefore"
        static let hasOnBoardingShownBefore = "hasOnBoardingShownBefore"
        static let localeVersion = "localeVersion"
        static let langDict = "langDict"
        static let langCode = "langCode"
        static let userIdentifier = "userIdentifier"
        static let activeRemindedUser = "activeRemindedUser"
        static let profilPicture = "profilePicture"
        static let lastCheckedAppVersion = "lastCheckedAppVersion"
        static let isFirstLogin = "isFirstLogin"
        static let isJailBroken = "isJailBroken"
        static let shouldCheckMsisdn = "shouldCheckMsisdn"
        static let favoriteCardMaskNumber = "favoriteCardMaskNumber"
        static let isLoginBefore = "isLoginBefore"
        static let isDotLockSuccess = "isDotLockSuccess"
        static let pushNotificationRegisterId = "pushNotificationRegisterId"
        static let currentEnvironment = "currentEnvironment"
        static let pushBadgeCount = "pushBadgeCount"
        static let isRemoveVascoBefore = "isRemoveVascoBefore"
        static let plateNumber = "plateNumber"
        static let hasHealthkitPermission = "hasHealthkitPermission"
        static let userFeedBackArray = "UserFeedBackArray"
        static let secureDeviceOtp = "secureDeviceOtp"
        static let testMsisdnModeOpen = "TestMsisdnModeOpen"
        static let isDeletedDevice = "isDeletedDevice"
        static let isSelectNoForAddDevice = "isSelectNoForAddDevice"
        static let autoLoginUser = "AutoLoginUser"
        static let autoLoginPass = "AutoLoginPass"
        static let pushNotificationFirebaseToken = "pushNotificationFirebaseToken"
        static let isPayFast = "PayFast"
        static let isLandscapeQR = "LandscapeQR"
    }

    enum Keychain {
        static let serviceName = "com.intertech.DenizKartim.keychainservice"
        static let customUrl = "CustomUrl"
        static let uniqueDeviceId = "UniqueDeviceID"
        static let userId = "userId"
        static let userIdentifier = "UserIdentifier"
        static let userDotlockIdentifier = "userDotlockIdentifier"
        static let isUserRegistered = "IsUserRegistered"
        static let profilePicture = "profilePicture"
        static let userName = "UserName"
        static let isRequireChangePassword = "ChangePassword"
        static let secureDeviceOtp = "secureDeviceOtp"
    }
}

enum AppFont {
    static let regular = "Muli"
    static let medium = "Muli-Light"
    static let semibold = "Muli-Semibold"
    static let bold = "Muli-Bold"
    static let black = "Muli-Black"
    static let extraBold = "Muli-ExtraBold"
    static let extraLight = "Muli-ExtraLight"

    static let regular12 = UIFont(name: AppFont.regular, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    static let regular14 = UIFont(name: AppFont.regular, size: 12.0) ?? UIFont.systemFont(ofSize: 14.0)
    static let regular16 = UIFont(name: AppFont.regular, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    static let medium14 = UIFont(name: AppFont.medium, size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    static let semibold12 = UIFont(name: AppFont.semibold, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    static let semibold14 = UIFont(name: AppFont.semibold, size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    static let semibold15 = UIFont(name: AppFont.semibold, size: 15.0) ?? UIFont.systemFont(ofSize: 15.0)
    static let semibold16 = UIFont(name: AppFont.semibold, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    static let semibold17 = UIFont(name: AppFont.semibold, size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
    static let bold10 = UIFont(name: AppFont.bold, size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)
    static let bold12 = UIFont(name: AppFont.bold, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    static let bold14 = UIFont(name: AppFont.bold, size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    static let bold16 = UIFont(name: AppFont.bold, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    static let bold17 = UIFont(name: AppFont.bold, size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
    static let button = UIFont(name: AppFont.bold, size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
    static let black30 = UIFont(name: AppFont.black, size: 30.0) ?? UIFont.systemFont(ofSize: 30.0)
    static let black40 = UIFont(name: AppFont.black, size: 40.0) ?? UIFont.systemFont(ofSize: 40.0)
    static let black51 = UIFont(name: AppFont.black, size: 51.0) ?? UIFont.systemFont(ofSize: 51.0)
    static let extraBold10 = UIFont(name: AppFont.extraBold, size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)
    static let extraBold18 = UIFont(name: AppFont.extraBold, size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
    static let extraBold20 = UIFont(name: AppFont.extraBold, size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
    static let extraBold24 = UIFont(name: AppFont.extraBold, size: 24.0) ?? UIFont.systemFont(ofSize: 24.0)
    static let extraBold30 = UIFont(name: AppFont.extraBold, size: 30.0) ?? UIFont.systemFont(ofSize: 30.0)
    static let extraLight14 = UIFont(name: AppFont.extraLight, size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

enum DateFormat: String {
    case ddMMyyyy = "dd/MM/yyyy"
    case ddMMyyyyDotted = "dd.MM.yyyy"
    case ddMMyyyyHHmm = "dd/MM/yyyy HH:mm"
    case ddMMyy = "dd/MM/yy"
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyy2 = "dd-MM-yyyy"
    case dMMMMyyyy = "d MMMM yyyy"
    case ddMMMMyyyy = "dd MMMM yyyy"
    case yyyy
    case MMMM
    case hhmm = "HH:mm"
    case gitiso = "YYYY-MM-DD hh:mm:ss Z"
    case HHmmEEEE = "HH:mm EEEE"
    case serviceResponseFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
    case serviceResponseFormat2 = "yyyy-MM-dd'T'HH:mm:ss.SSSSSZ"
    case serviceRequestFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case ddMMMM = "dd MMMM"
    case ddMMyyyyWithSpace = "dd / MM / yyyy"
    case documentDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    case yyyyMMddWithSlash = "yyyy/MM/dd"
    case yyyyMMMM = "yyyy - MMMM"
    case yyyyMMddWithoutSpecialChar = "yyyyMMdd"
}

enum PageName: String {
    case mtvPayment
    case autoInstallment
    case lostStolen
    case createVirtual
    case cancelVirtual
    case cardApplication
    case changeCardPassword
    case eExtractDemand
    case cashAdvance
    case installmentCashAdvance
    case addTransportationCard
    case debtPayment
    case createExtendCard
    case creditCardLimitUpdate
    case virtualCardLimitUpdate
    case extendCardLimitUpdate
    case commitmentCampaign
    case orderedBillPaymentUpdate
    case orderedBillPaymentCancel
    case takeCardPassword
    case regularLimitUpdate
    case installmentAfterAdvance
    case cardPermission
    case temporaryClose
    case billPayment
    case autoBillPayment
    case addMoneyTransportationCard
    case trafficTicketPayment
    case overseasExitFee
    case otherTaxPaymentLanding
    case otherTaxPaymentsOffline
    case otherTaxPaymentsOnline
    case passaportFee
    case cardDebtSafety
    case statementFragment
    case mtvAutoPayment
    case transferBonusPoints
    case qrPaymentOrRefund
}

enum ResultButton {
    static let addMoney = "Summary.Button.AddMoney"
    static let addTransportationCard = "Summary.Button.AddTransportationCard"
    static let queryTransportationCard = "Summary.Button.QueryTransportationCard"
    static let checkBoxQueryTransportation = "CheckBox.QueryTransportation"
    static let checkBoxAddMoneyTransportation = "CheckBox.AddMoneyTransportation"
    static let cardPermission = "Summary.Button.ApproveCardPermission"
    static let commitmentCampaign = "CommitmentCampaign.Approve"
    static let cardDebtSafety = "CardInsurance.Save"
    static let checkBoxMtvSave = "CheckBox.MTVSave"
    static let checkBoxAddRegisteredInstruction = "CheckBox.AddRegisteredInstruction"
    static let checkboxAddPaymentOrder = "CheckBox.AddPaymentOrder"
    static let deptPayment = "Summary.Button.DebtPayment"
    static let extendCardLimitUpdate = "Summary.Button.ExtendCardLimitUpdate"
    static let mtvAutomaticPayment = "Summary.Button.mtvAutomaticPayment"
    static let approvedDocuments = "DigitalApprove.TrxDocInfoTaken"
    static let omissionDocuments = "DigitalApprove.NonExistingContinue"
    static let virtualCardCreate = "VirtualCardCreate"
    static let updateCvv = "UpdateCvv"
    static let emailButtons = "Summary.Button.EmailOtp"
    static let backToProfileAndSettings = "General.BacktoProfileAndSettings"
    static let transferBonus = "Summary.Button.TransferBonus"
    static let updateAddressInfo = "AddressUpdate.SummaryApproveButton"
    static let qrPayment = "QRPayment.CommitmentButton"
    static let debitCardLimit = "Summary.Button.UpdateDebitCardLimit"
    static let createVirtualDebitCard = "Summary.Button.CreateVirtualDebit"
    static let debitLostStolen = "Summary.Button.LostStolenDebit"
    static let creditCardRestructuring = "Summary.Button.CreditCardRestructuring"
    static let sharePayment = "SharePayment"
    static let sharePaymentConfirm = "SharePaymentConfirm"
    static let cardsAndMainPage = "Summary.Button.CardsAndMainPage"
    static let paymentsMTVNewPayment = "Summary.Button.paymentsMTVNewPayment"
    static let creditCardLimitApprove = "Summary.Button.CreditCardLimit"
    static let createPrepaidVirtualCard = "Summary.Button.CreatePrepaidVirtualCard"
    static let cancelVirtualCard = "Summary.Button.VirtualCardCancel"
    static let loadMoneyToPrepaidVirtualCard = "Summary.Button.LoadMoneyToPrepaidVirtualCard"
}

enum SummaryKey {
    static let cashAdvanceMaskedCardNumber = "Janus.SummaryCashAdvance.CashAdvanceSummary.Label.MaskedCardNumber"
}
