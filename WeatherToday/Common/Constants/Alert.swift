//
//  Alert.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation


enum Alert: Int {
    // Server codes
    case closeError = 0
    case basimBlokeKart = 19_250_000
    case noContract = 2_013_005
    case insufficientBalance = 57
    case codeNotReachBonusInfo = 873_873
    case notReachTCKNsystem = 100_102
    case noRecord = 5555
    case wrongUsernameOrPassword = 1_912_201_262
    case wrongCaptcha = 60035
    case blockedAccount = 99_671_522
    case noCampaignForSelectedCard = 2_016_009
    case wrongBirthDate = 2_021_072_602
    case checkPinError = 1_234_592

    // Client codes
    case unknownError = 100_000
    case localIP
    case noConnection
    case appUpdate
    case otpExpired
    case closeCardPermission
    case areYouSureToExit
    case minPatternAlert
    case patternNotSame
    case threeWrongPattern
    case removeBlockedUser
    case cancelRegularLimitUpdate
    case selectRegularLimitUpdate
    case softLogout
    case hardLogout
    case askCameraPermission
    case askLocationPermission
    case cameraPermissionDenied
    case updateTransportationCard
    case sameTransportationCard
    case sameTransportationCardForQuery
    case healthKitPermission
    case pdfDownloaded
    case taxPdfDownloaded
    case deleteTransactionGroup
    case showPrizeDescription
    case noCommitment
    case referrer
    case cvv
    case ecommerceInfo
    case mtvPaymentOther
    case jailbreakDetection
    case igaPassWarning
    case statementFragment
    case statementFragmentInfo
    case removeBlock
    case limitIncrease
    case answerOldSecurityQuestion
    case plateTCKNWarning
    case securityQuestionInfo
    case customerNoCardMessage
    case customerNoOptionsMessage
    case noDocument
    case documentDowloaded
    case documentDownloadFailed
    case inboxDateWarning
    case inboxAddressWarning
    case inboxDownloaded
    case inboxDownloadError
    case countryApproveError
    case cellularCheck
    case countrySameError
    case secureDeviceRemove
    case secureDeviceAdded
    case inappTimeIsUp
    case deviceCameraFailure
    case qrcodeLoginSuccess
    case qrcodeLoginFailure
    case qrcodeLoginCancel
    case extractDownloaded
    case bonusTransferNoCard
    case bonusTransferMinTwoCard
    case bonusTransferNoAvailableCards
    case cashAdvanceRestrictedBonusBusinessExtend
    case addInstallmentRestrictedBonusBusinessExtend
    case installmentAfterAdvanceRestrictedBonusBusinessExtend
    case goToOffline
    case lostStolenCardSelectedHomeAddress
    case updateDeliveryAddressCompletedWithoutResult
    case masterpassIntegrationResult
    case masterpassCardAddingDetailInfo
    case qrPaymentNoCardError
    case existBonusBusinessCard
    case bonusBusinessIndividualCustomerInfo
    case bonusBusinessNoMainCard
    case bonusBusinessCardSelectedHomeAddress
    case authorizationPopupMessage
    case bonusBusinessHasNoApplyPermission
    case businessCardLimitDecreaseLimitWarning
    case businessCardLimitNoAvailableCard
    case autoInstallmentCampaignMessage
    case qrCodeSecureDeviceWarningMessage
    case isNotShownPaymentTable
    case generalNotSuitableCardWarning
    case cardRestructuringNotSuitableCardWarning
    case cardRestructuringNotSuitableAccountWarning
    case restructuredCreditCardWarning
    case restructuredCreditCardWarningNoApplyCreditCard
    case contactsAreNotCustomersWarning
    case sharedPaymentConfirm
    case sharedPaymentCancel
    case invalidContactsWarning
    case showLogOffAlert
    case basicInfo

    var model: AlertModel {
        switch self {
        case .noConnection:
            return AlertModel(message: .generalNoInternet,
                              icon: StatusType.error.icon,
                              code: rawValue)
        case .localIP:
            return AlertModel(title: "Hay aksi!",
                              message: "IP adresini girmen gerekiyor.",
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .showLogOffAlert:
            return AlertModel(title: .warningTitle,
                              message: .timeOutMessage,
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .otpExpired:
            return AlertModel(title: "Otp",
                              message: "Otp Warning",
                              buttons: [.ok, .cancel],
                              code: rawValue)
        case .areYouSureToExit:
            return AlertModel(title: .warningTitle,
                              message: .loginExitApproveWarningMessage,
                              buttons: [.generalYes, .cardPermissionClosePermissionCancel],
                              code: rawValue)
        case .minPatternAlert:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.patternDefinitionMinPatternWarningMessage.value,
                              buttons: [.ok],
                              code: rawValue)
        case .patternNotSame:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.patternDefinitionWrongPatternWarningMessage.value,
                              buttons: [.ok],
                              code: rawValue)
        case .threeWrongPattern:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.patternDefinitionThreeWrongPatternWarningMessage.value,
                              buttons: [.createNewPattern],
                              code: rawValue)
        case .cancelRegularLimitUpdate:
            return AlertModel(title: ResourceKey.cardPermissionClosePermissionHeader.value,
                              message: ResourceKey.regularlyLimitUpdateLimitUpdateCancellationInfo.value,
                              buttons: [.referrerYesButton, .cancel],
                              code: rawValue)
        case .selectRegularLimitUpdate:
            return AlertModel(title: ResourceKey.cardPermissionClosePermissionHeader.value,
                              message: ResourceKey.mainCardLimitUpdateRegularlyLimitUpdateInfo.value,
                              buttons: [.referrerYesButton, .remindLater],
                              code: rawValue)
        case .softLogout:
            return AlertModel(title: .warningTitle,
                              message: .profileAndSettingsLogOutWarningMessage,
                              buttons: [.exitApproveOkButton,
                                        .cardPermissionClosePermissionCancel],
                              code: rawValue)
        case .hardLogout:
            return AlertModel(title: .warningTitle,
                              message: .profileAndSettingsForgetMeWarningMessage,
                              buttons: [.exitApproveOkButton,
                                        .cardPermissionClosePermissionCancel],
                              code: rawValue)
        case .askCameraPermission:
            return AlertModel(message: .transportationCardCameraPermissionTitle,
                              buttons: [.transportationCardCameraPermissionAllowButton,
                                        .transportationCardCameraPermissionDisallowButton],
                              code: rawValue)
        case .askLocationPermission:
            return AlertModel(title: .fastPayMerchantPaymentLocationPermissionTitle,
                              message: .fastPayMerchantPaymentLocationPermissionText,
                              icon: #imageLiteral(resourceName: "location"),
                              buttons: [.locationPermissionAllowButton,
                                        .locationPermissionNotNowButton],
                              code: rawValue)
        case .cameraPermissionDenied:
            return AlertModel(title: .warningTitle,
                              message: .profilCameraPermissionText,
                              buttons: [.cameraApproveGoSettingsButton,
                                        .cancel],
                              code: rawValue)
        case .updateTransportationCard:
            return AlertModel(title: .transportationCardAddUpdateCardNamePopUpTitle,
                              message: .transportationCardAddUpdateCardNamePopUpText,
                              icon: StatusType.inform.icon,
                              buttons: [.generalContinue,
                                        .cancel],
                              code: rawValue)
        case .sameTransportationCard:
            return AlertModel(title: .transportationCardSameCardWarningTitle,
                              message: .transportationCardLoadSameCardWarningText,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .sameTransportationCardForQuery:
            return AlertModel(title: .transportationCardSameCardWarningTitle,
                              message: .transportationCardInquirySameCardWarningText,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .healthKitPermission:
            return AlertModel(title: ResourceKey.walkAndEarnPermissionWarningHeader,
                              message: ResourceKey.walkAndEarnPermissionWarningMessage,
                              buttons: [.ok],
                              code: rawValue)
        case .pdfDownloaded:
            return AlertModel(title: ResourceKey.statementViewPDFDownloadedHead.value,
                              message: ResourceKey.documentDownloadSuccess.value,
                              buttons: [.ok],
                              code: rawValue)
        case .taxPdfDownloaded:
            return AlertModel(title: ResourceKey.paymentsAllTaxPaymentsPDFDownloadedHead.value,
                              message: ResourceKey.paymentsAllTaxPaymentsPDFDownloaded.value,
                              buttons: [.ok],
                              code: rawValue)
        case .deleteTransactionGroup:
            return AlertModel(title: ResourceKey.transactionGroupDeleteGroupWarningPopUpTitle,
                              message: ResourceKey.transactionGroupDeleteGroupWarningPopUpText,
                              buttons: [.deleteTransactionGroup],
                              code: rawValue,
                              enableCloseButton: true)
        case .noCommitment:
            return AlertModel(title: .warningTitle,
                              message: .commitmentCampaignNoCommitment,
                              code: rawValue)
        case .cvv:
            return AlertModel(title: .anonymousCardPasswordInfoTitle,
                              message: .anonymousCardPasswordInfoText,
                              code: rawValue)
        case .ecommerceInfo:
            return AlertModel(title: .customerCardApplySummaryECommercePermissionPopUpTitle,
                              message: .customerCardApplySummaryECommercePermissionPopUpText,
                              buttons: [.ok],
                              code: rawValue)
        case .jailbreakDetection:
            return AlertModel(message: "Cihazınızın rootlu olduğu tespit edildi. Yine de devam etmek istiyor musunuz?",
                              buttons: [.ok, .cancel],
                              code: rawValue)
        case .igaPassWarning:
            return AlertModel(title: .warningTitle,
                              message: .igaPassError,
                              buttons: [.ok],
                              code: rawValue)
        case .statementFragment:
            return AlertModel(title: .statementFragmentHeader,
                              message: .statementFragmentFirstInformation,
                              textAlignment: .left,
                              textFont: AppFont.semibold17,
                              buttons: [],
                              code: rawValue,
                              enableCloseButton: true)
        case .statementFragmentInfo:
            return AlertModel(title: .statementFragmentHeader,
                              message: .statementFragmentInformationDetail,
                              textAlignment: .left,
                              textFont: AppFont.semibold17,
                              buttons: [],
                              code: rawValue,
                              enableCloseButton: true,
                              isHtml: true)
        case .removeBlock:
            return AlertModel(title: .warningTitle,
                              header: .loginBlockRemovalButton,
                              message: .loginMaxWrongPasswordWarningMessage,
                              buttons: [.ok, .removeBlock],
                              code: rawValue,
                              enableCloseButton: true)
        case .answerOldSecurityQuestion:
            return AlertModel(title: .warningTitle,
                              header: .warningTitle,
                              message: .magicQuestionWrongAnswer,
                              buttons: [.ok],
                              code: rawValue,
                              enableCloseButton: true)
        case .securityQuestionInfo:
            return AlertModel(title: .warningTitle,
                              header: .warningTitle,
                              message: .magicQuestionCustomerNoOptionsLoginMessage,
                              buttons: [.magicQuestionFirstLoginPopupButton],
                              code: rawValue)
        case .customerNoCardMessage:
            return AlertModel(title: .warningTitle,
                              header: .warningTitle,
                              message: .magicQuestionCustomerNoCardMessage,
                              buttons: [.ok],
                              code: rawValue)
        case .customerNoOptionsMessage:
            return AlertModel(title: .warningTitle,
                              header: .warningTitle,
                              message: .magicQuestionCustomerNoOptionsMessage,
                              buttons: [.ok],
                              code: rawValue)
        case .inboxDateWarning:
            return AlertModel(title: .warningTitle,
                              message: .inboxDateError,
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .inboxAddressWarning:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.inboxNoAddresses.value,
                              icon: StatusType.error.icon,
                              buttons: [.mainPage, .mailUpdate],
                              code: rawValue)
        case .inboxDownloaded:
            return AlertModel(message: ResourceKey.inboxDownloadSuccess.value,
                              icon: StatusType.success.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .inboxDownloadError:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.inboxDownloadError.value,
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .cellularCheck:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.msisdnCheck.value,
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .documentDowloaded:
            return AlertModel(message: ResourceKey.documentDownloadSuccess.value,
                              icon: StatusType.success.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .documentDownloadFailed:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.inboxDownloadError.value,
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .countrySameError:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.crsSameCountry.value,
                              icon: StatusType.error.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .secureDeviceRemove:
            return AlertModel(title: ResourceKey.loginSafeDeviceRemoveSelectedDeviceEnsurement.value,
                              message: ResourceKey.loginSafeDeviceRemoveSelectedDeviceEnsureInfo.value,
                              icon: StatusType.warning.icon,
                              buttons: [.generalContinue, .cancel],
                              code: rawValue)
        case .secureDeviceAdded:
            return AlertModel(title: ResourceKey.loginSafeDeviceResultPageSubTitle.value,
                              message: ResourceKey.loginSafeDeviceFifthInfo.value + "\n\n" + ResourceKey.loginSafeDeviceSuccessGuide.value,
                              icon: StatusType.inform.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .deviceCameraFailure:
            return AlertModel(message: ResourceKey.qrloginCamNotDet.value,
                              icon: StatusType.inform.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .qrcodeLoginSuccess:
            return AlertModel(message: ResourceKey.qrloginSuc.value,
                              icon: StatusType.success.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .qrcodeLoginFailure:
            return AlertModel(message: ResourceKey.qrloginDis.value,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .qrcodeLoginCancel:
            return AlertModel(message: ResourceKey.qrloginCancel.value,
                              icon: StatusType.inform.icon,
                              buttons: [.ok, .cancel],
                              code: rawValue)
        case .extractDownloaded:
            return AlertModel(title: ResourceKey.statementsStatementPDFDownloadedHead.value,
                              message: ResourceKey.statementsStatementPDFDownloaded.value,
                              buttons: [.ok],
                              code: rawValue)
        case .bonusTransferNoCard:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusTransferNoCard.value,
                              buttons: [.ok],
                              code: rawValue)
        case .bonusTransferMinTwoCard:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusTransferMinTwoCard.value,
                              buttons: [.ok],
                              code: rawValue)
        case .bonusTransferNoAvailableCards:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusTransferNoAvailableCards.value,
                              buttons: [.ok],
                              code: rawValue)
        case .masterpassCardAddingDetailInfo:
            return AlertModel(title: ResourceKey.masterpassCardAddingInfoTextPopup,
                              message: ResourceKey.masterpassCardAddingInfoDetailedText,
                              icon: #imageLiteral(resourceName: "infoIcon"),
                              buttons: [.ok],
                              code: rawValue)
        case .lostStolenCardSelectedHomeAddress:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.lostStolenCardDeliveryAddressLabelHomeAdressWarningMassage.value,
                              buttons: [.ok],
                              code: rawValue)
        case .qrPaymentNoCardError:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.qrPaymentNoCardError.value,
                              buttons: [.cardApplication, .returnMainPage],
                              code: rawValue)
        case .existBonusBusinessCard:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusBusinessOneBonusBusinessCardPopupWarning.value,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .bonusBusinessIndividualCustomerInfo:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusBusinessMainCardApplicationMessage.value,
                              icon: StatusType.inform.icon,
                              buttons: [.generalContinue, .cancel],
                              code: rawValue)
        case .bonusBusinessNoMainCard:
            return AlertModel(title: ResourceKey.bonusBusinessSupCardApplicationPopup1.value,
                              message: ResourceKey.bonusBusinessSupCardApplicationPopup2.value,
                              icon: StatusType.warning.icon,
                              buttons: [.openBonusBusinessAplication, .cancel],
                              code: rawValue)
        case .bonusBusinessCardSelectedHomeAddress:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusBusinessCardDeliveryAddressLabelHomeAdressWarningMassage.value,
                              icon: StatusType.inform.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .authorizationPopupMessage:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.autoInstallmentAuthorizationPopupMessage.value,
                              buttons: [.ok],
                              code: rawValue)
        case .bonusBusinessHasNoApplyPermission:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.bonusBusinessSupCardApplicationHasPermissionPopUp.value,
                              icon: StatusType.inform.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .businessCardLimitDecreaseLimitWarning:
            return AlertModel(title: ResourceKey.updateRequestCardLimitWarningDialogHeader.value,
                              message: ResourceKey.updateRequestCardLimitWarningDialogMessage.value,
                              icon: StatusType.confirm.icon,
                              buttons: [.generalContinue, .cancel],
                              code: rawValue)
        case .businessCardLimitNoAvailableCard:
            return AlertModel(title: ResourceKey.updateCardLimitNoAvailableCardHeader.value,
                              message: ResourceKey.updateCardLimitNoAvailableCardMessage.value,
                              icon: StatusType.inform.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .autoInstallmentCampaignMessage:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.autoInstallmentNoCampaign.value,
                              buttons: [.ok],
                              code: rawValue)

        case .qrCodeSecureDeviceWarningMessage:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.qrCodeSecureDeviceLoginWarningMessage.value,
                              buttons: [.ok],
                              code: rawValue)
        case .isNotShownPaymentTable:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.cardRestructuringViewPaymentSummary.value,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .generalNotSuitableCardWarning:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.generalNotSuitableCardWarningMessage.value,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .cardRestructuringNotSuitableCardWarning:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.cardRestructuringNotSuitableCardWarningMessage.value,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .cardRestructuringNotSuitableAccountWarning:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.cardRestructuringAccountMessage.value,
                              icon: StatusType.warning.icon,
                              buttons: [.ok],
                              code: rawValue)
        case .restructuredCreditCardWarning:
            return AlertModel(title: ResourceKey.cardRestructuringCardDeptPopupMessageTitle.value,
                              message: ResourceKey.cardRestructuringCardDeptPopupMessageInfo.value,
                              icon: StatusType.warning.icon,
                              buttons: [.openCreditCardDebtRestructuringPayment, .cancel],
                              code: rawValue)
        case .restructuredCreditCardWarningNoApplyCreditCard:
            return AlertModel(title: ResourceKey.warningTitle.value,
                              message: ResourceKey.restructedCardPaymentNoApplyCreditCardPopupWarning.value,
                              icon: StatusType.warning.icon,
                              buttons: [.openCreditCardDebtRestructuringPayment, .cancel],
                              code: rawValue)
        case .basicInfo:
            return AlertModel(title: ResourceKey.masterpassCardAddingInfoTextPopup.value,
                              message: ResourceKey.masterpassCardAddingInfoTextPopup.value,
                              icon: StatusType.inform.icon,
                              textAlignment: .center,
                              buttons: [.ok])
        default:
            return AlertModel()
        }
    }

    func with(_ model: AlertModel) -> AlertModel {
        model.code = rawValue
        switch self {
        default:
            break
        }
        return model
    }

    func navigate(with tag: AlertButtonIdentifier) {
//        switch (self, tag) {
//        case (.unknownError, .ok):
//            NavigationRouter.go(to: SplashVC(),
//                                transitionOptions: TransitionOptions(direction: .fade))
//        default:
//            break
//        }
    }
}

enum AlertButtonTag {
    case ok
    case cancel
    case forceUpdateUpdate
    case forceUpdateLater
    case generic(String)
    case loginWarningButtonOK
    case cardPermissionClosePermissionYes
    case cardPermissionClosePermissionCancel
    case generalYes
    case createNewPattern
    case removeBlock
    case approve
    case want
    case remindLater
    case referrerCancelButton
    case referrerYesButton
    case exitApproveOkButton
    case exitApproveCancelButton
    case transportationCardCameraPermissionAllowButton
    case transportationCardCameraPermissionDisallowButton
    case transportationCardAddUpdateCardNamePopUpYesButton
    case transportationCardAddUpdateCardNamePopUpNoButton
    case cameraApproveGoSettingsButton
    case locationPermissionAllowButton
    case locationPermissionNotNowButton
    case deleteTransactionGroup
    case patternDefinitionOKButton
    case generalContinue
    case magicQuestionFirstLoginPopupButton
    case mainPage
    case mailUpdate
    case menuCardPermissionLimitedTransactionPermissionPopupButton
    case cardApplication
    case returnMainPage
    case openBonusBusinessAplication
    case openCreditCardDebtRestructuringPayment
    case sharePaymentCancel

    var resource: ResourceKey {
        switch self {
        case .ok:
            return .okButton
        case .cancel:
            return .cancel
        case .forceUpdateUpdate:
            return .popupButtonVersionControlUpdate
        case .forceUpdateLater:
            return .popupButtonVersionControlLater
        case let .generic(identifier):
            return .resource("PopUpButton.\(identifier)")
        case .loginWarningButtonOK:
            return .loginWarningButtonOK
        case .cardPermissionClosePermissionYes:
            return .cardPermissionClosePermissionYes
        case .cardPermissionClosePermissionCancel:
            return .cardPermissionClosePermissionCancel
        case .generalYes:
            return .loginExitApproveOKButton
        case .createNewPattern:
            return .patternDefinitionNewPatternCreateButton
        case .removeBlock:
            return .loginBlockRemovalButton
        case .approve:
            return .approveButton
        case .want:
            return .want
        case .remindLater:
            return .remindLater
        case .referrerCancelButton:
            return .referrerCancelButton
        case .referrerYesButton:
            return .referrerYesButton
        case .exitApproveOkButton:
            return .loginExitApproveOKButton
        case .exitApproveCancelButton:
            return .loginExitApproveCancelButton
        case .transportationCardCameraPermissionAllowButton:
            return .transportationCardCameraPermissionAllowButton
        case .transportationCardCameraPermissionDisallowButton:
            return .transportationCardCameraPermissionDisallowButton
        case .transportationCardAddUpdateCardNamePopUpYesButton:
            return .transportationCardAddUpdateCardNamePopUpYesButton
        case .transportationCardAddUpdateCardNamePopUpNoButton:
            return .transportationCardAddUpdateCardNamePopUpNoButton
        case .cameraApproveGoSettingsButton:
            return .cameraApproveGoSettingsButton
        case .locationPermissionAllowButton:
            return .fastPayMerchantPaymentLocationPermissionAllowButton
        case .locationPermissionNotNowButton:
            return .fastPayMerchantPaymentLocationPermissionNotNowButton
        case .deleteTransactionGroup:
            return .transactionGroupDetailDeleteGroupButton
        case .patternDefinitionOKButton:
            return .patternDefinitionOKButton
        case .generalContinue:
            return .generalButtonContinue
        case .magicQuestionFirstLoginPopupButton:
            return .magicQuestionFirstLoginPopupButton
        case .mainPage:
            return .newOtoMTVFinishPageBackToMainPageButton
        case .mailUpdate:
            return .inboxMailUpdateButton
        case .menuCardPermissionLimitedTransactionPermissionPopupButton:
            return .menuCardPermissionLimitedTransactionPermissionPopupButton
        case .cardApplication:
            return .generalButtonCardApply
        case .returnMainPage:
            return .mainPage
        case .openBonusBusinessAplication:
            return .bonusBusinessSupCardApplicationWarningButton
        case .openCreditCardDebtRestructuringPayment:
            return .cardRestructuringCardDebtRestructuringPaymentMenu
        case .sharePaymentCancel:
            return .sharePaymentCancel
        }
    }

    var identifier: AlertButtonIdentifier {
        switch self {
        case .ok:
            return .ok
        case .cancel:
            return .cancel
        case .forceUpdateUpdate:
            return .forceUpdateUpdate
        case .forceUpdateLater:
            return .forceUpdateLater
        case let .generic(identifier):
            return AlertButtonIdentifier(rawValue: identifier) ?? .none
        case .loginWarningButtonOK:
            return .loginWarningButtonOK
        case .cardPermissionClosePermissionYes:
            return .cardPermissionClosePermissionYes
        case .cardPermissionClosePermissionCancel:
            return .cardPermissionClosePermissionCancel
        case .generalYes:
            return .generalYes
        case .createNewPattern:
            return .createNewPattern
        case .removeBlock:
            return .removeBlock
        case .approve:
            return .approve
        case .want:
            return .want
        case .remindLater:
            return .remindLater
        case .referrerCancelButton:
            return .referrerCancelButton
        case .referrerYesButton:
            return .referrerYesButton
        case .exitApproveOkButton:
            return .exitApproveOkButton
        case .exitApproveCancelButton:
            return .cardPermissionClosePermissionCancel
        case .transportationCardCameraPermissionAllowButton:
            return .transportationCardCameraPermissionAllowButton
        case .transportationCardCameraPermissionDisallowButton:
            return .transportationCardCameraPermissionDisallowButton
        case .transportationCardAddUpdateCardNamePopUpYesButton:
            return .transportationCardAddUpdateCardNamePopUpYesButton
        case .transportationCardAddUpdateCardNamePopUpNoButton:
            return .transportationCardAddUpdateCardNamePopUpNoButton
        case .cameraApproveGoSettingsButton:
            return .cameraApproveGoSettingsButton
        case .locationPermissionAllowButton:
            return .locationPermissionAllowButton
        case .locationPermissionNotNowButton:
            return .locationPermissionNotNowButton
        case .deleteTransactionGroup:
            return .deleteTransactionGroupButton
        case .patternDefinitionOKButton:
            return .patternDefinitionOKButton
        case .generalContinue:
            return .generalContinue
        case .magicQuestionFirstLoginPopupButton:
            return .magicQuestionFirstLoginPopupButton
        case .mainPage:
            return .mainPage
        case .mailUpdate:
            return .mailUpdate
        case .menuCardPermissionLimitedTransactionPermissionPopupButton:
            return .menuCardPermissionLimitedTransactionPermissionPopupButton
        case .cardApplication:
            return .cardApplication
        case .returnMainPage:
            return .returnMainPage
        case .openBonusBusinessAplication:
            return .openBonusBusinessAplication
        case .openCreditCardDebtRestructuringPayment:
            return .openCreditCardDebtRestructuringPayment
        case .sharePaymentCancel:
            return .sharePaymentCancel
        }
    }

    var style: FormButtonStyle {
        switch self {
        case .cancel:
            return .secondaryStyle
        case .cardPermissionClosePermissionCancel:
            return .secondaryStyle
        case .transportationCardCameraPermissionDisallowButton:
            return .secondaryStyle
        case .transportationCardAddUpdateCardNamePopUpNoButton:
            return .secondaryStyle
        case .locationPermissionNotNowButton:
            return .secondaryStyle
        case .referrerCancelButton:
            return .secondaryStyle
        case .forceUpdateLater:
            return .secondaryStyle
        case .removeBlock:
            return .secondaryStyle
        case .remindLater:
            return .secondaryStyle
        case .returnMainPage:
            return .secondaryStyle
        case .sharePaymentCancel:
            return .secondaryStyle
        default:
            return .primaryStyle
        }
    }
}

enum AlertButtonIdentifier: String {
    case none
    case ok
    case cancel
    case forceUpdateUpdate
    case forceUpdateLater
    case loginWarningButtonOK = "LoginWarning.ButtonOK"
    case cardPermissionClosePermissionYes
    case cardPermissionClosePermissionCancel
    case generalYes
    case createNewPattern
    case removeBlock
    case approve
    case want
    case remindLater
    case referrerCancelButton
    case referrerYesButton
    case exitApproveOkButton
    case exitApproveCancelButton
    case transportationCardCameraPermissionAllowButton
    case transportationCardCameraPermissionDisallowButton
    case transportationCardAddUpdateCardNamePopUpYesButton
    case transportationCardAddUpdateCardNamePopUpNoButton
    case cameraApproveGoSettingsButton
    case locationPermissionAllowButton
    case locationPermissionNotNowButton
    case deleteTransactionGroupButton
    case patternDefinitionOKButton
    case generalContinue
    case magicQuestionFirstLoginPopupButton
    case mainPage
    case mailUpdate
    case menuCardPermissionLimitedTransactionPermissionPopupButton
    case cardApplication
    case returnMainPage
    case openBonusBusinessAplication
    case openCreditCardDebtRestructuringPayment
    case sharePaymentCancel
}

enum FieldAlert: String {
    case unknown
    case invalidPin
    case invalidRePin

    var model: FieldAlertModel {
        switch self {
        case .invalidPin:
            return FieldAlertModel(field: rawValue, message: "Yanlis Pin")
        case .invalidRePin:
            return FieldAlertModel(field: rawValue, message: "Yanlis Pin 2")
        default:
            return FieldAlertModel(field: rawValue, message: "")
        }
    }

    func with(_ model: FieldAlertModel) -> FieldAlertModel {
        return model
    }
}
