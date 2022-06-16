//
//  CardsSelectionCell.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Foundation

class CardsSelectionCell: BaseSelectionCell {
    @IBOutlet var lblCardName: UILabel!
    @IBOutlet var lblCardNumber: UILabel!
    @IBOutlet var lblOwnerName: UILabel!
    @IBOutlet var lblLimitTitle: UILabel!
    @IBOutlet var lblLimit: UILabel!

    var card: CardDetail? {
        didSet { configureView() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }

    private func configureView() {
        guard let card = card else { return }
        lblCardName.text = card.name
        lblCardNumber.text = card.maskedCardNumber
        if card.isShowBonus {
            lblLimitTitle.resource = .bonusTransferAvailableBonus
        } else {
            lblLimitTitle.resource = (card.cardType == .debit ||
                card.cardType == .extendedDebit ||
                card.cardType == .virtualDebit) ? .availableLimit : .lostStolenCardAvailableLimit
        }
        configureCardSelectionCellAmount()
        lblOwnerName.isHidden = !(card.cardType == .extend
            || card.cardType == .extendedDebit
            || card.cardType == .businessExtend)
        lblOwnerName.text = card.ownerName
        if card.isSelected {
            makeUISelected()
        } else {
            makeUIUnselected()
        }
    }

    func configureCardSelectionCellAmount() {
        guard let card = card else { return }
        if SessionKeeper.shared.isUserLoggedIn {
            if !card.isShowBonus, card.availableLimitFirst == "***" {
                let limitFirst = "\(card.availableLimitFirst)"
                let limitSecond = "\(card.availableLimitSecond) \(card.availableLimitCurrency)"
                setAttributedString(limitFirst: limitFirst,
                                    limitSecond: limitSecond,
                                    label: lblLimit)
            } else {
                let amount = card.isShowBonus ? card.availableBonus : "\(card.availableLimitFirst)\(card.availableLimitSecond)"
                    .trimmingWhitespace()
                    .amountToDouble()
                lblLimit.amountAttributed(amount: amount,
                                          currency: card.availableLimitCurrency,
                                          fractionDigits: 2,
                                          removeZeroIfNeeded: false,
                                          font: lblLimit.font,
                                          fractionalFont: AppFont.regular12)
            }
        } else {
            let limitFirst = "\(card.availableLimitFirst)"
            let limitSecond = "\(card.availableLimitSecond) \(card.availableLimitCurrency)"
            setAttributedString(limitFirst: limitFirst,
                                limitSecond: limitSecond,
                                label: lblLimit)
        }
    }

    func setAccessibilityIdentifiers() {
        lblCardName.accessibilityKey = .name
        lblCardNumber.accessibilityKey = .cardNo
        lblOwnerName.accessibilityKey = .animation
        lblLimitTitle.accessibilityKey = .limitTitle
        lblLimit.accessibilityKey = .limit
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblCardName.text = ""
        lblCardNumber.text = ""
        lblOwnerName.text = ""
        lblLimitTitle.text = ""
        lblLimit.text = ""
        bag.dispose()
    }
}
