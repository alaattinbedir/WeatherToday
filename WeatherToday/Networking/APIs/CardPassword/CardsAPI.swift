//
//  CardsAPI.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation
import UIKit

enum HeaderParams: String {
    case ifMatch = "if-Match"
    case xTransactionToken = "X-Transaction-Token"
}

class CardsAPI {
    func getCards(succeed: @escaping (CardsResponse) -> Void,
                  areCancelledCardsIncluded: Bool,
                  isBusinessCardInclude: Bool,
                  isDebitCardInclude: Bool,
                  failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if areCancelledCardsIncluded {
            params["areCancelledCardsIncluded"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cards,
                               lockScreen: true, succeed: {
                                   succeed(CardsHelper.sortFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getWelcomeCards(lockScreen: Bool = true,
                         willResumeProgress: Bool = false,
                         isBusinessCardInclude: Bool,
                         isDebitCardInclude: Bool,
                         isProducerCardInclude: Bool = true,
                         parallelRequest: Bool = false,
                         urlPath: String = Endpoints.welcomeCards,
                         succeed: @escaping (WelcomeCardResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: urlPath,
                               lockScreen: lockScreen,
                               parallelRequest: parallelRequest,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getWelcomeCardsCache(lockScreen: Bool = true,
                              willResumeProgress: Bool = false,
                              isDebitCardInclude: Bool,
                              isBusinessCardInclude: Bool = false,
                              isPrepaidCardInclude: Bool = false,
                              succeed: @escaping (WelcomeCardResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["isDebitCardInclude"] = isDebitCardInclude
        params["isPrepaidCardInclude"] = isPrepaidCardInclude
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = isBusinessCardInclude
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.getCardInfoList,
                               lockScreen: lockScreen,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getCardDetail(lockScreen: Bool = true,
                       guid: String,
                       cardType: Int,
                       succeed: @escaping (CardDetailResponse2) -> Void,
                       failed: @escaping (ErrorMessage) -> Void) {
        var path = ""
        if !guid.isEmpty {
            path += "/\(guid)"
        }
        var params: [String: Any] = [:]
        params["type"] = cardType
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cardDetail + path,
                               lockScreen: lockScreen,
                               succeed: succeed,
                               failed: failed)
    }

    func prepareForLostStolenCards(isDebitCardInclude: Bool,
                                   succeed: @escaping (LostCardResponse) -> Void,
                                   failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.lostCard,
                               lockScreen: true,
                               willResumeProgress: true,
                               succeed: succeed,
                               failed: failed)
    }

    func prepareForVirtualCardLimitUpdate(guid: String,
                                          succeed: @escaping (VirtualCardLimitUpdateResponse) -> Void,
                                          failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.virtualCardUpdate + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    private func setHeaderParams(_ token: String? = nil, _ eTag: String? = nil) -> [String: String]? {
        var headerParams: [String: String]?
        if let token = token, let eTag = eTag {
            headerParams = [HeaderParams.ifMatch.rawValue: eTag, HeaderParams.xTransactionToken.rawValue: token]
        }
        return headerParams
    }

    func updateVirtualCardLimit(guid: String,
                                params: [String: Any]?,
                                eTag: String? = nil,
                                token: String? = nil,
                                succeed: @escaping (ConfirmResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.virtualCardUpdate + "/\(guid)",
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func getVirtualCards(succeed: @escaping (VirtualCardCancelResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.virtualCardUpdateCvv,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func updateVirtualCardCvv(guid: String,
                              params: [String: Any]?,
                              succeed: @escaping (ConfirmResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.virtualCardUpdateCvv + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getExtendCards(isProducerCardInclude: Bool? = false,
                        succeed: @escaping (ExtendedCardResponse) -> Void,
                        failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isProducerCardInclude~ {
            params["isProducerCardInclude"] = true
            params["allExtendedCard"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.extendCards,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getExtractCardList(lockScreen: Bool = true,
                            isBusinessCardInclude: Bool,
                            succeed: @escaping (WelcomeCardResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cardExtractCardList,
                               lockScreen: lockScreen,
                               willResumeProgress: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardsExtractList(guid: String,
                             succeed: @escaping (CardStatementPeriodListResponse) -> Void,
                             failed: @escaping (ErrorMessage) -> Void) {
        let path = "/\(guid)"
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.displayReceipt + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardsExtractDetail(params: [String: Any]?,
                               succeed: @escaping (StatementDetailResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cardExtractDetail,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getStatementDetailDocument(documentId: Int,
                                    succeed: @escaping (StatementDetailDocumentResponse) -> Void,
                                    failed: @escaping (ErrorMessage) -> Void) {
        let path = "/\(documentId)"
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.statementDetailDocument + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func sendExtractToEmail(params: [String: Any]?,
                            succeed: @escaping (SendExtractResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cardExtractToEmail,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getTransactionList(guid: String,
                            cardType: CardType,
                            succeed: @escaping (TransactionListResponse) -> Void,
                            failure: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["cardType"] = cardType.hashValue
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.editableTransaction + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failure)
    }

    func editableExtraTransactions(guid: String,
                                   succeed: @escaping (TransactionListResponse) -> Void,
                                   failure: @escaping (ErrorMessage) -> Void) {
        let path = "/\(guid)"
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.editableExtraTransactions + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failure)
    }

    func getInstallments(params: [String: Any]?,
                         succeed: @escaping (TransactionInstallmentsResponse) -> Void,
                         failure: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.editableTransactionInstallments,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failure)
    }

    func getExtraInstallments(params: [String: Any]?,
                              succeed: @escaping (TransactionInstallmentsResponse) -> Void,
                              failure: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.editableTransactionExtraInstallments,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failure)
    }

    func selectInstallment(params: [String: Any]?,
                           succeed: @escaping (InstallmentConfirmResponse) -> Void,
                           failure: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.multiTransactionSimulate,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failure)
    }

    func editableTransactionSimulate(params: [String: Any]?,
                                     succeed: @escaping (InstallmentConfirmResponse) -> Void,
                                     failure: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.editableTransactionSimulate,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failure)
    }

    func getCashAdvanceInfo(type: CashAdvanceType,
                            guid: String,
                            isProducerCardInclude: Bool = true,
                            succeed: @escaping (CashAdvanceInfoResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        var path = ""
        if !guid.isEmpty {
            path += "/\(guid)"
        }
        path += "?type=\(type.rawValue)"
        path += "&isProducerCardInclude=\(isProducerCardInclude)"
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.cashAdvance + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func summaryCashAdvance(params: [String: Any]?,
                            succeed: @escaping (InstallmentConfirmResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cashAdvanceSummary,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func simulateCashAdvance(params: [String: Any]?,
                             succeed: @escaping (InstallmentConfirmResponse) -> Void,
                             failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cashAdvanceSimulate,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getInstallmentsForCashAdvance(params: [String: Any]?,
                                       succeed: @escaping (CashAdvanceInstallmentsResponse) -> Void,
                                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cashAdvanceInstallments,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func approveSummaryOperation(headerParams: [String: String]? = nil,
                                 params: [String: Any]? = nil,
                                 endPoint: String = "",
                                 otp: String?,
                                 isQueryString: Bool = false,
                                 isPatch: Bool = false,
                                 succeed: @escaping (InstallmentConfirmResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        var paramFields = params
        var path = endPoint
        if let otp = otp {
            if isQueryString {
                path = endPoint + "?otp=\(otp)"
            } else {
                paramFields?["otp"] = otp
                if paramFields == nil {
                    paramFields = ["otp": otp]
                }
            }
        }
        BaseAPI.shared.request(methotType: isPatch ? .patch : .post,
                               params: paramFields,
                               urlPath: path,
                               lockScreen: true,
                               headerParams: headerParams,
                               succeed: succeed,
                               failed: failed)
    }

    func prepareForVirtualCardCancel(guid: String,
                                     isDebitCardInclude: Bool,
                                     succeed: @escaping (VirtualCardCancelResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.virtualCardCancel + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func cancelVirtualCard(guid: String,
                           eTag: String? = nil,
                           token: String? = nil,
                           succeed: @escaping (ConfirmResponse) -> Void,
                           failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: ["guid": guid],
                               urlPath: Endpoints.virtualCardCancel + "/\(guid)",
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func getLimitPreferences(isRegularLimitIncrease: Bool,
                             isIncrease: Bool? = nil,
                             succeed: @escaping (GetCardLimitResponse) -> Void,
                             failed: @escaping (ErrorMessage) -> Void) {
        var path = "?isRegularLimitIncrease=\(isRegularLimitIncrease)"
        if let isIncrease = isIncrease {
            path += "&isLimitIncreaseAndDecrease=\(isIncrease)"
        }
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.regularLimitPreference + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func checkCardPin(params: [String: Any]?,
                      succeed: @escaping (CardPasswordValidResponse) -> Void,
                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.checkCardPin,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func changeCardPinCvv(params: [String: Any]?,
                          succeed: @escaping (CardPasswordValidResponse) -> Void,
                          failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.changeCardPinCvv,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func changeCardPin(params: [String: Any]?,
                       succeed: @escaping (ConfirmResponse) -> Void,
                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.changeCardPin,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func changeRegularLimitIncreasePreference(headerParams: [String: String]? = nil,
                                              params: [String: Any]?,
                                              succeed: @escaping (ConfirmResponse) -> Void,
                                              failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.regularLimitPreference,
                               lockScreen: true,
                               headerParams: headerParams,
                               succeed: succeed,
                               failed: failed)
    }

    func requestLimitForSummary(params: [String: Any]?,
                                succeed: @escaping (ConfirmResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.requestLimit,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func decreaseLimit(params: [String: Any]?,
                       succeed: @escaping (ConfirmResponse) -> Void,
                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.decreaseLimit,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func preparePermanentCardClosure(guid: String,
                                     isDebitCardInclude: Bool,
                                     succeed: @escaping (PermanentCloseCardPrepareResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.lostCard + "/\(guid)",
                               lockScreen: true,
                               willResumeProgress: false,
                               succeed: succeed,
                               failed: failed)
    }

    func permanentlyCloseCard(guid: String,
                              params: [String: Any]?,
                              eTag: String? = nil,
                              token: String? = nil,
                              succeed: @escaping (ConfirmResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.lostCard + "/\(guid)",
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func prepareTemporarilyCloseCard(isDebitCardInclude: Bool,
                                     succeed: @escaping (TemporaryCloseCardPrepareResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.closeCard,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func changeCardFrozenStatus(guid: String,
                                params: [String: Any]?,
                                succeed: @escaping (ConfirmResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.closeCard + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func prepareCardDebtPayment(guid: String,
                                isBusinessCardInclude: Bool,
                                succeed: @escaping (CardDebtPaymentResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cardDebtPayment + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func makeDebtPayment(guid: String,
                         params: [String: Any]?,
                         succeed: @escaping (ConfirmResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cardDebtPayment + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func makeProducerDebtPayment(params: [String: Any]?,
                                 succeed: @escaping (ConfirmResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.producerCardDebtPayment,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func emailUpdateInfo(params: [String: Any]?,
                         succeed: @escaping (EmailUpdateInfoResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.emailUpdateInfo,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func setEmailInfo(params: [String: Any]?,
                      succeed: @escaping (ConfirmResponse) -> Void,
                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.setEmailInfo,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getAccountsForCardDebtPayment(currencyCode: Int,
                                       succeed: @escaping (CardDebtPaymentAccountResponse) -> Void,
                                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.cardDebtPaymentAccounts + "/\(currencyCode)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getAccounts(parallelRequest: Bool = false,
                     willResumeProgress: Bool = false,
                     succeed: @escaping (AccountsResponse) -> Void,
                     failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.accounts,
                               lockScreen: true,
                               parallelRequest: parallelRequest,
                               willResumeProgress: willResumeProgress,
                               succeed: succeed,
                               failed: failed)
    }

    func prepareForVirtualCardCreate(guid: String,
                                     isProducerCardInclude: Bool = true,
                                     succeed: @escaping (VirtualCardCreateResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.virtualCardCreate + "/\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func createVirtualCard(guid: String,
                           params: [String: Any]?,
                           eTag: String? = nil,
                           token: String? = nil,
                           succeed: @escaping (ConfirmResponse) -> Void,
                           failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.virtualCardCreate + "/\(guid)",
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func getCardsProvision(cardType: CardType,
                           guid: String,
                           subProductCode: String? = nil,
                           succeed: @escaping (CardsTermInfoListResponse) -> Void,
                           failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = ["cardType": cardType.rawValue]
        if let subProductCode = subProductCode {
            params["subProductCode"] = subProductCode
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cardsProvision + "/\(guid)",
                               lockScreen: false,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardsTermInfo(cardType: CardType,
                          guid: String,
                          subProductCode: String? = nil,
                          lockScreen: Bool,
                          succeed: @escaping (CardsTermInfoListResponse) -> Void,
                          failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = ["type": PageType.intermPage.rawValue, "cardType": cardType.rawValue]
        if let subProductCode = subProductCode {
            params["subProductCode"] = subProductCode
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cardsTermInfo + "/\(guid)",
                               lockScreen: lockScreen,
                               succeed: succeed,
                               failed: failed)
    }

    func getDebitCardsTermInfo(guid: String,
                               type: String,
                               lockScreen: Bool,
                               succeed: @escaping (CardsTermInfoListResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        let params: [String: Any] = ["type": type]
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.debitCardTransactions + "/\(guid)",
                               lockScreen: lockScreen,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardsWaitingInstallments(cardType: CardType,
                                     guid: String,
                                     subProductCode: String? = nil,
                                     succeed: @escaping (CardWaitingInstallmentsResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = ["cardType": cardType.rawValue]
        if let subProductCode = subProductCode {
            params["subProductCode"] = subProductCode
        }
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.cardWaitingInstallments + "/\(guid)",
                               lockScreen: false,
                               succeed: succeed,
                               failed: failed)
    }

    func processOrder(paymentFields: [String: Any],
                      succeed: @escaping (ConfirmResponse) -> Void,
                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: paymentFields,
                               urlPath: Endpoints.payments + "/application-process",
                               lockScreen: true,
                               willShowFailure: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getNextStatementSummaryInfoWithFragmentOptions(params: [String: Any]?,
                                                        succeed: @escaping (
                                                            NextStatementFragmentOptionsResponse
                                                        ) -> Void,
                                                        failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.nextStatementFragmentOptions,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func saveStatementFragment(params: [String: Any]?,
                               eTag: String? = nil,
                               token: String? = nil,
                               succeed: @escaping (ConfirmResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.saveStatementFragment,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func processMtvPayment(params: [String: Any]?,
                           succeed: @escaping (ConfirmResponse) -> Void,
                           failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.payments + "/process-mvt-payment",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getMerchants(succeed: @escaping (GetMerchantsResponse) -> Void,
                      failed: @escaping (ErrorMessage) -> Void,
                      query: String,
                      lockScreen: Bool = true,
                      headerParams: [String: String]?) {
        var path: String = ""
        if !query.isEmpty {
            path = "?keyword=\(query)"
        }
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.merchants + path,
                               lockScreen: lockScreen,
                               headerParams: headerParams,
                               succeed: succeed,
                               failed: failed)
    }

    func getMerchantInstallments(params: [String: Any],
                                 succeed: @escaping (MerchantInstallmentsResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.merchantInstallments,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func merchantPayment(params: [String: Any],
                         succeed: @escaping (ConfirmResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.merchantPayment,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getAutoeppCampains(guid: String,
                            succeed: @escaping (AutoEppCampaignResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getCampains + "/\(guid)",
                               lockScreen: true,
                               willResumeProgress: false,
                               willShowFailure: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getAutoeppSummary(params: [String: Any]?,
                           succeed: @escaping (InstallmentConfirmResponse) -> Void,
                           failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.autoeppSummary,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func cardTransactionGroups(succeed: @escaping (CardTransactionGroupsResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: nil,
                               urlPath: Endpoints.cardTransactionGroups,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func accountTransactionGroups(succeed: @escaping (AccountTransactionGroupsResponse) -> Void,
                                  failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: nil,
                               urlPath: Endpoints.accountTransactionGroups,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func deleteCardTransactionGroup(params: [String: Any]?,
                                    eTag: String? = nil,
                                    token: String? = nil,
                                    succeed: @escaping (ConfirmResponse) -> Void,
                                    failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.deleteCardTransactionGroup,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func updateCardTransactionGroup(params: [String: Any]?,
                                    eTag: String? = nil,
                                    token: String? = nil,
                                    succeed: @escaping (ConfirmResponse) -> Void,
                                    failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateCardTransactionGroup,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func createCardTransactionGroup(params: [String: Any]?,
                                    eTag: String? = nil,
                                    token: String? = nil,
                                    succeed: @escaping (ConfirmResponse) -> Void,
                                    failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.createCardTransactionGroup,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func deleteAccountTransactionGroup(params: [String: Any]?,
                                       eTag: String? = nil,
                                       token: String? = nil,
                                       succeed: @escaping (ConfirmResponse) -> Void,
                                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.deleteAccountTransactionGroup,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func updateAccountTransactionGroup(params: [String: Any]?,
                                       eTag: String? = nil,
                                       token: String? = nil,
                                       succeed: @escaping (ConfirmResponse) -> Void,
                                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateAccountTransactionGroup,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func createAccountTransactionGroup(params: [String: Any]?,
                                       eTag: String? = nil,
                                       token: String? = nil,
                                       succeed: @escaping (ConfirmResponse) -> Void,
                                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.createAccountTransactionGroup,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func applyTechnoCard(eTag: String? = nil,
                         token: String? = nil,
                         succeed: @escaping (ConfirmResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: ["isEnabled": true],
                               urlPath: Endpoints.applyTechnoCard,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func generateQrCode(params: [String: Any]?,
                        lockScreen: Bool,
                        succeed: @escaping (GenerateQrCodeResponse) -> Void,
                        failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.generateQrCode,
                               lockScreen: lockScreen,
                               succeed: succeed,
                               failed: failed)
    }

    func getBonusCommitmentList(id: String,
                                succeed: @escaping (BonusPromiseCommitmentsResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.bonusCommitmentCiroList + "/\(id)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func setBonusPromiseCommitment(params: [String: Any]?,
                                   eTag: String? = nil,
                                   token: String? = nil,
                                   succeed: @escaping (ConfirmResponse) -> Void,
                                   failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.bonusPromiseCommitmentSet,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func getAllUserCommitments(succeed: @escaping (CommitmentCampaignsResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.bonusPromiseCardDetailList,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardTypes(income: Int,
                      succeed: @escaping (CardTypeResponse) -> Void,
                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.cardTypes + "?income=\(income)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getAllMainCards(succeed: @escaping (CardTypeResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.allMainCard,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getBusinessCardLoanParameter(succeed: @escaping (BusinessCardLoanParameterResponse) -> Void,
                                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.businessCardLoanInstallmentList,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func approveBusinessCardLoan(params: [String: Any]?,
                                 eTag: String? = nil,
                                 token: String? = nil,
                                 succeed: @escaping (BusinessCardTableResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.businessCardLoan,
                               lockScreen: true,
                               headerParams: setHeaderParams(token, eTag),
                               succeed: succeed,
                               failed: failed)
    }

    func getCardApplicationForm(succeed: @escaping (CreditCardApplicationFormResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.cardApplicationForm,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func anonymCardApply(params: [String: Any],
                         path: String,
                         succeed: @escaping (AnonymCardApplicationResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getBranches(succeed: @escaping (BranchesResponse) -> Void,
                     failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.brances,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func generateCaptcha(succeed: @escaping (GenerateCaptchaResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: nil,
                               urlPath: Endpoints.generateCaptcha,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func nonCustomerInitiateChangePin(params: [String: Any],
                                      succeed: @escaping (OTPResponse) -> Void,
                                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.nonCustomerInitiateChangePin,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func nonCustomerChangePinVerification(params: [String: Any],
                                          succeed: @escaping (PinVerificationResponse) -> Void,
                                          failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.nonCustomerChangePinVerification,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func nonCustomerChangePin(params: [String: Any],
                              succeed: @escaping (PinChangedResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.nonCustomerChangePin,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardsWBBMainAndExtendCardFilter(lockScreen: Bool = true,
                                            willResumeProgress: Bool = false,
                                            isBusinessCardInclude: Bool,
                                            isDebitCardInclude: Bool,
                                            isProducerCardInclude: Bool = true,
                                            succeed: @escaping (WelcomeCardResponse) -> Void,
                                            failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.pageBonusBussinessMainAndExtendCardFilter,
                               lockScreen: lockScreen,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getPageBonusBussinessMainCardFilter(lockScreen: Bool = true,
                                             willResumeProgress: Bool = false,
                                             isBusinessCardInclude: Bool,
                                             isDebitCardInclude: Bool,
                                             isProducerCardInclude: Bool = true,
                                             isBonusBusinessCardInclude: Bool = true,
                                             parallelRequest: Bool = false,
                                             succeed: @escaping (WelcomeCardResponse) -> Void,
                                             failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        params["isBonusBusinessCardInclude"] = isBonusBusinessCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.pageBonusBussinessMainCardFilter,
                               lockScreen: lockScreen,
                               parallelRequest: parallelRequest,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getPageBonusBussinessAndBusinessCardFilter(lockScreen: Bool = true,
                                                    willResumeProgress: Bool = false,
                                                    isBusinessCardInclude: Bool,
                                                    isDebitCardInclude: Bool,
                                                    isProducerCardInclude: Bool = true,
                                                    succeed: @escaping (WelcomeCardResponse) -> Void,
                                                    failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.pageBonusBussinessAndBusinessCardFilter,
                               lockScreen: lockScreen,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func checkBonusBusinessRelation(guid: String,
                                    succeed: @escaping (BonusBusinessRelationResponse) -> Void,
                                    failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.checkBonusBusinessRelation + "/\(guid)",
                               lockScreen: true,
                               willResumeProgress: false,
                               willShowFailure: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getPageCardFilterBonusAndExtendCard(lockScreen: Bool = true,
                                             willResumeProgress: Bool = false,
                                             isBusinessCardInclude: Bool,
                                             isDebitCardInclude: Bool,
                                             isProducerCardInclude: Bool = true,
                                             succeed: @escaping (WelcomeCardResponse) -> Void,
                                             failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.pageCardFilterBonusAndExtendCard,
                               lockScreen: lockScreen,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getPageCardFilterExtendCard(lockScreen: Bool = true,
                                     willResumeProgress: Bool = false,
                                     isBusinessCardInclude: Bool,
                                     isDebitCardInclude: Bool,
                                     isProducerCardInclude: Bool = true,
                                     succeed: @escaping (WelcomeCardResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.pageCardFilterExtendCard,
                               lockScreen: lockScreen,
                               willResumeProgress: willResumeProgress, succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getPageBonusBusinessAndBusinessCardFilter(lockScreen: Bool = true,
                                                   isBusinessCardInclude: Bool? = false,
                                                   isDebitCardInclude: Bool? = false,
                                                   isProducerCardInclude: Bool? = false,
                                                   succeed: @escaping (WelcomeCardResponse) -> Void,
                                                   failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isBusinessCardInclude~ {
            params["isBusinessCardInclude"] = true
        }
        if isDebitCardInclude~ {
            params["isDebitCardInclude"] = true
        }
        params["isProducerCardInclude"] = isProducerCardInclude
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.pageBonusBusinessAndBusinessCardFilter,
                               lockScreen: lockScreen,
                               succeed: {
                                   succeed(CardsHelper.sortWelcomeFavoriteCard(res: $0))
                               }, failed: failed)
    }

    func getInsurableCards(succeed: @escaping (InsurableCardsResponse) -> Void,
                           failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.insurableCards,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCardInsurance(params: [String: Any],
                          isAutoRenewal: Bool,
                          succeed: @escaping (ConfirmResponse) -> Void,
                          failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cardInsurance + "/?isAutoRenewalFlag=\(isAutoRenewal)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func increaseCardLimitFromPush(succeed: @escaping (LimitIncreasePushResponse) -> Void,
                                   failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: ["approved": true],
                               urlPath: Endpoints.limitIncreasePush,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getEducationAndJob(succeed: @escaping (EducationAndJobResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.educationAndJob,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func calculateScoreCardApp(params: [String: Any],
                               succeed: @escaping (CalculateScoreCardAppResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.calculateScoreCardApp,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func completeCardApp(params: [String: Any],
                         succeed: @escaping (ConfirmResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.completeCardApp,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func limitWaitingRequests(succeed: @escaping (LimitWaitingResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.limitWaitingRequest,
                               lockScreen: false,
                               succeed: succeed,
                               failed: failed)
    }

    func getEmailStatus(succeed: @escaping (EmailStatusResponse) -> Void,
                        failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getEmailStatus,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func transferBonus(succeed: @escaping (ConfirmResponse) -> Void,
                       failed: @escaping (ErrorMessage) -> Void,
                       params: [String: Any]?) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.cardsBonusTransfer,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getBonusBusinessAuthCardInfo(guid: String,
                                      succeed: @escaping (CardRestrictionAuthorizationResponse) -> Void,
                                      failed: @escaping (ErrorMessage) -> Void) {
        var path = ""
        if !guid.isEmpty {
            path += "/\(guid)"
        }
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getBonusBusinessAuthCardInfo + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func updateBonusBusinessAuth(params: [String: Any],
                                 succeed: @escaping (EmptyResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateBonusBusinessAuth,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getDeliveryDetails(succeed: @escaping (CardApplicationTrackingResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getDeliveryDetails,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getDeliveryDetailsAnonymous(params: [String: Any]?,
                                     succeed: @escaping (CardApplicationTrackingResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.getDeliveryDetailsAnonymous,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func insertMasterpass(params: [String: Any]?,
                          succeed: @escaping (InsertMasterpassResponse) -> Void,
                          failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.insertMasterpass,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getAllowedDebitCards(lockScreen: Bool = true,
                              cardType: Int,
                              succeed: @escaping (DebitCardTypeResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["type"] = cardType
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.debitCardsAllowedTypes,
                               lockScreen: lockScreen,
                               succeed: succeed,
                               failed: failed)
    }

    func getAccountsForDebitCardCreation(guid: String,
                                         isCameFromSmartAccount: Bool,
                                         succeed: @escaping (DebitAccountsResponse) -> Void,
                                         failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        if isCameFromSmartAccount {
            params["isCameFromArarBulur"] = isCameFromSmartAccount
        }
        params["guid"] = guid
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.getAccountList,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCustomerAddress(isExtendedDebit: Bool,
                            succeed: @escaping (AddressResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["isExtendedDebit"] = isExtendedDebit
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.getCustomerAddress2,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func completeDebitCardCreation(params: [String: Any]?,
                                   succeed: @escaping (ConfirmResponse) -> Void,
                                   failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.completeDebitCardCreation,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getDebitCardForLimit(lockScreen: Bool = true,
                              cardType: Int,
                              succeed: @escaping (WelcomeCardResponse) -> Void,
                              failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["cardType"] = cardType
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.getDebitCardsForLimit,
                               lockScreen: lockScreen,
                               succeed: succeed,
                               failed: failed)
    }

    func updateVirtualDebitCardCvv(params: [String: Any]?,
                                   succeed: @escaping (ConfirmResponse) -> Void,
                                   failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateVirtualDebitCVV,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func cancelVirtualDebitCard(guid: String,
                                succeed: @escaping (ConfirmResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: ["Guid": guid],
                               urlPath: Endpoints.cancelVirtualDebit,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func virtualDebitCardLimitUpdate(params: [String: Any]?,
                                     succeed: @escaping (ConfirmResponse) -> Void,
                                     failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateVirtualDebitLimit,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getDebitCardLimits(guid: String,
                            succeed: @escaping (DebitCardsLimitResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getDebitCardsLimits + "/?guid=\(guid)",
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func updateDebitCardLimits(params: [String: Any]?,
                               succeed: @escaping (ConfirmResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateDebitCardsLimits,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func lostOrStolenDebitCards(params: [String: Any]?,
                                succeed: @escaping (ConfirmResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.lostOrStolenDebitCards,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func updateDebitCardsAccount(params: [String: Any]?,
                                 succeed: @escaping (ConfirmResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateDebitCardsAccount,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getBonusBusinessCardApplicationForm(succeed: @escaping (BonusBusinessCardInfoResponse) -> Void,
                                             failed: @escaping (ErrorMessage) -> Void) {
        let path = "?cardType=\(CardType.bonusBusiness.rawValue)"
        BaseAPI.shared.request(methotType: .post,
                               params: nil,
                               urlPath: Endpoints.bonusBusinesCardInfo + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getBonusBusinessExtendCardApplicationForm(succeed: @escaping (BonusBusinessExtendCardInfoResponse) -> Void,
                                                   failed: @escaping (ErrorMessage) -> Void) {
        let path = "?cardType=\(CardType.bonusBusinessExtend.rawValue)"
        BaseAPI.shared.request(methotType: .post,
                               params: nil,
                               urlPath: Endpoints.bonusBusinesCardInfo + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func applyBonusBusinessCard(params: [String: Any]?,
                                succeed: @escaping (ConfirmResponse) -> Void,
                                failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.bonusBusinesCardApply,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getExtendedDebitCardPersonInfo(params: [String: Any]?,
                                        succeed: @escaping (CreateExtendCardPersonInfoResponse) -> Void,
                                        failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.extendedDebitCardpersonInfo,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func updateDebitCardsSmartAccount(params: [String: Any]?,
                                      succeed: @escaping (ConfirmResponse) -> Void,
                                      failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.updateDebitCardSmartAccounts,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func createExtendedDebitCard(params: [String: Any]?,
                                 succeed: @escaping (ConfirmResponse) -> Void,
                                 failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.createExtendedDebitCard,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func canApplyDebitCards(cardType: Int,
                            succeed: @escaping (DebitCardCanApplyResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["type"] = cardType
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.canApplyDebitCard,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getRestructrableCards(succeed: @escaping (GetRestructrableCardsResponse) -> Void,
                               failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getRestructrableCards,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func mergeRestructure(params: [String: Any]?,
                          succeed: @escaping (MergeRestructureResponse) -> Void,
                          failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.mergeRestructure,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func simulateRestructure(params: [String: Any]?,
                             succeed: @escaping (SimulateRestructureResponse) -> Void,
                             failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.simulateRestructure,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func processRestructure(paymentPlanId: String,
                            succeed: @escaping (ConfirmResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["paymentPlanId"] = paymentPlanId
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.processRestructure,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getCredits(willResumeProgress: Bool = false,
                    succeed: @escaping (GetCreditsResponse) -> Void,
                    failed: @escaping (ErrorMessage) -> Void) {
        let path = "?op=detail"
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getCredits + path,
                               lockScreen: true,
                               willResumeProgress: willResumeProgress,
                               succeed: succeed,
                               failed: failed)
    }

    func getCreditDetail(creditId: String,
                         succeed: @escaping (CreditDetailResponse) -> Void,
                         failed: @escaping (ErrorMessage) -> Void) {
        let path = "/\(creditId)/activities"
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.getCredits + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func paymentCredit(params: [String: Any]?,
                       succeed: @escaping (ConfirmResponse) -> Void,
                       failed: @escaping (ErrorMessage) -> Void) {
        BaseAPI.shared.request(methotType: .post,
                               params: params,
                               urlPath: Endpoints.paymentCredit,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func isRestructuredCard(guid: String? = nil,
                            succeed: @escaping (IsRestructuredCardResponse) -> Void,
                            failed: @escaping (ErrorMessage) -> Void) {
        var path = ""
        if let guid = guid, !guid.isEmpty {
            path += "/\(guid)"
        }
        BaseAPI.shared.request(methotType: .get,
                               params: nil,
                               urlPath: Endpoints.isRestructuredCard + path,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }

    func getSeekerFinderAccountsForDebitCard(guid: String,
                                             succeed: @escaping (DebitAccountsResponse) -> Void,
                                             failed: @escaping (ErrorMessage) -> Void) {
        var params: [String: Any] = [:]
        params["guid"] = guid
        BaseAPI.shared.request(methotType: .get,
                               params: params,
                               urlPath: Endpoints.debitCardsSeekerFinderAccountList,
                               lockScreen: true,
                               succeed: succeed,
                               failed: failed)
    }
}
