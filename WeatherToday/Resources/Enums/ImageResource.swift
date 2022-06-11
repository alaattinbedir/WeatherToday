//
//  ImageResource.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import UIKit

public enum ImageResource: String {
    case editIcon = "edit"
    case formClearIcon = "cleear_textfield"
    case shareIcon = "share"
    case navigationMoreMenuIcon = "navigation_more_menu_icon"
    case dashboardNavigationSamplePersonIcon = "db_sample_person_pic"
    case dashboardLeftMainButtonSelectedBg = "db_selected_left_main_button_bg"
    case dashboardRightMainButtonSelectedBg = "db_selected_right_main_button_bg"
    case dashboardPaymentCreditCardButtonIcon = "db_pay_credit_card_btn_icon"
    case dashboardCashAdvanceButtonIcon = "db_cash_advance_btn_icon"
    case dashboardCardDetailButtonIcon = "db_card_detail_btn_icon"
    case dashboardInstallmentButtonIcon = "db_transaction_installment_btn_icon"
    case dashboardUpdateLimitButtonIcon = "db_limit_update_btn_icon"
    case dashboardUpdateLimitDecreaseButtonIcon = "db_limit_update_decrease_btn_icon"
    case dashboardCloseCardButtonIcon = "db_close_card_btn_icon"
    case dashboardCardPasswordButtonIcon = "db_card_password_btn_icon"
    case dashboardInvoicePaymentButtonIcon = "Dashboard_TermDeposit_PayBillsButton"
    case dashboardShareIcon = "shareDashboardIban"
    case dashboardCardsViewStatementIcon = "db_cards_view_statement"
    case dashboardCardTransactionsCreditApplicationIcon = "db_card_transactions_credit_application_icon"
    case downArrow
    case rightArrow = "secim.left.arrow"
    case upArrow = "up"
    case assetsDownArrow = "assets_arrow_down"
    case assetsUpArrow = "assets_arrow_up"
    case check
    case infoSmallBlue = "info-small-blue"
    case infoSmallFastpay
    case infoSmallGray = "info"
    case errorSmallRed = "uyari-red"
    case infoSmallTurquaz = "info-small-turquaz"
    case backArrowWhite
    case campaignBgImage = "bannerLanding"
    case hardTokenVerification
    case smsVerification
    case investmentPriceArrowDownRed = "investment_price_arrow_down_red"
    case investmentPriceArrowUpGreen = "investment_price_arrow_up_green"
    case investmentPriceDiffNotrGray = "investment_price_arrow_notr_grey"
    case flagTRY
    case flagGBP
    case businessCardLoan
    case fillCalendar

    case landingBgblackPapers = "landing_bg_black_papers.jpg"
    case landingBgSea = "landing_bg_sea.jpg"
    case landingBgDumen = "landing_bg_dumen.jpg"
    case landingBgSeaShell = "landing_bg_sea_shell.jpg"
    case landingBgWhiteShell = "landing_bg_white_shell.jpg"
    case landingBgWaterFall = "landing_bg_waterfall.jpg"
    case landingBgStone = "landing_bg_stone.jpg"
    case landingBgSeaside = "landing_bg_seaside2.jpg"
    case landingBgAutumn = "landing_bg_autumn4.jpg"
    case landingBgMountain = "landing_bg_mountain1.jpg"
    case landingBgTurquoise = "landing_bg_turquoise4.jpg"
    case landingBgCorp = "landing_bg_corp.jpg"
    case landingBgBlackSandBeach = "landing_bg_blacksand_beach.jpg"
    case landingBgShellInBlack = "landing_bg_shell_in_black.jpg"
    case dashboardArbitrage = "dashboard_arbitrage"
    case landingBgiceTree = "landing_bg_ice_tree.jpg"
    case landingBgsnowTree = "landing_bg_snow_tree3.jpg"

    case iconDigitalCustomerCompleted
    case iconDigitalCustomerWaiting
    case cameraIcon = "call_center_voip_camera"
    case dropDownBlueArrow
    case arrowDownBold = "arrow_down_bold"
    case arrowUpBold = "arrow_up_bold"
    case ocrCamera
    case qrIcon

    case debitCardSwipeButtonArarBulur = "db_debitCard_swipeButton_ararBulur"
    case debitCardSwipeButtonUpdateVirtualLimit = "db_debitCard_swipeButton_updateVirtualLimit"
    case debitCardSwipeButtonUpdateLimit = "db_debitCard_swipeButton_updateLimit"
    case debitCardWelcomeButtonAddRemoveAccount = "db_debitCard_welcomeButton_addRemoveAccount"

    case cancelledTransaction = "StockMarketPublicOfferCustomerDemandCancelled"
    case waitingTransaction = "StockMarketPublicOfferCustomerDemandActive"
    case completedTransaction = "StockMarketPublicOfferCustomerDemandCompleted"

    case navStocksIcon = "nav_stocks_icon"
    case stockWatch = "icn_follow"
    case stockUnwatch = "icn_unfollow"
    case stockWatchOperationSuccess = "icn_check"
}

extension ImageResource {
    func toUIImage() -> UIImage {
        return UIImage(named: rawValue).required()
    }

    func toUIImageView(frame: CGRect? = nil, color: UIColor? = nil) -> UIImageView {
        let imageView = UIImageView(image: toUIImage())

        if let frame = frame {
            imageView.frame = frame
        }

        if let color = color {
            imageView.image = imageView.image.required().withRenderingMode(.alwaysTemplate)
            imageView.tintColor = color
        }

        return imageView
    }
}
