//
//  CardCell.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

class CardCell: UITableViewCell {
    @IBOutlet var imgViewCard: UIImageView!
    @IBOutlet var lblCardName: UILabel!
    @IBOutlet var lblCardNo: UILabel!
    @IBOutlet var lblLeft1: UILabel!
    @IBOutlet var lblLeft2: UILabel!
    @IBOutlet var lblLeft3: UILabel!
    @IBOutlet var lblLeft4: UILabel!
    @IBOutlet var lblLeft5: UILabel!
    @IBOutlet var viewMiddle1: UIView!
    @IBOutlet var viewMiddle2: UIView!
    @IBOutlet var viewMiddle3: UIView!
    @IBOutlet var viewMiddle4: UIView!
    @IBOutlet var viewMiddle5: UIView!
    @IBOutlet var lblRight1: UILabel!
    @IBOutlet var lblRight2: UILabel!
    @IBOutlet var lblRight3: UILabel!
    @IBOutlet var lblRight4: UILabel!
    @IBOutlet var lblRight5: UILabel!
    @IBOutlet var lblCardOwnerName: UILabel!
    @IBOutlet var imgCopyCardNo: UIImageView!
    var cardType: CardType?

    var card: Card? {
        didSet {
            configureView()
            configureLines()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }

    func configureView() {
        guard let card = card else { return }
        lblCardName.adjustsFontSizeToFitWidth = true
        lblCardName.minimumScaleFactor = 0.5
        lblCardName.text = card.name
        lblCardOwnerName.isHidden = true
        lblLeft1.resource = .generalCardLimitAvailableLimit
        lblLeft2.resource = .paymentCreditCardLastPaymentDate
        lblLeft4.resource = .paymentCreditCardRemainingStatementDebtUSD
        lblLeft5.resource = .paymentCreditCardRemainingStatementDebtEUR
        if let debtUsd = card.remainingDebtUsd {
            let usdAmount = String(debtUsd).currencyFormatted().replacingOccurrences(of: "₺", with: "")
            lblRight4.text = "\(usdAmount) \(card.remainingDebtUsdCurrency)"
        }
        if let debtEuro = card.remainingDebtEuro {
            let eurAmount = String(debtEuro).currencyFormatted().replacingOccurrences(of: "₺", with: "")
            lblRight5.text = "\(eurAmount) \(card.remainingDebtEuroCurrency)"
        }
        if let imageUrl = URL(string: card.image) {
            imgViewCard.kf.setImage(with: imageUrl, placeholder: #imageLiteral(resourceName: "default_card"))
        }
        configureViewForCardType()
    }

    private func configureViewForCardType() {
        guard let card = card else { return }
        guard let cardType = cardType else { return }
        switch cardType {
        case .credit,
             .bonusBusiness:
            guard let creditCard = card as? CreditCard else { return }
            configureCreditCard(card: creditCard)
        case .bonusBusinessExtend, .businessExtend:
            guard let creditCard = card as? CreditCard else { return }
            configureBonusBusinessExtend(card: creditCard)
        case .debit:
            guard let debitCard = card as? DebitCard else { return }
            configureDebitCard(card: debitCard)
        case .extend:
            configureExtendCard(card: card)
        case .virtual,
             .bonusBusinessVirtual:
            configureVirtualCard(card: card)
        case .virtualDebit:
            guard let virtualDebitCard = card as? VirtualDebitCard else { return }
            configureVirtualDebitCard(card: virtualDebitCard)
        case .extendedDebit:
            guard let extendDebitCard = card as? ExtendDebitCard else { return }
            configureExtendDebitCard(card: extendDebitCard)
        case .business:
            guard let businessCard = card as? BusinessCard else { return }
            configureBusinessCard(card: businessCard)
        case .producer:
            guard let producerCard = card as? Card else { return }
            configureProducerCard(card: producerCard)
        default:
            break
        }
        configureCopyButton(card: card)
    }

    private func configureCopyButton(card: Card) {
        if card.cardType == .virtual || card.cardType == .bonusBusinessVirtual || card.cardType == .virtualDebit {
            imgCopyCardNo.isHidden = false
            imgCopyCardNo.addTapGestureRecognizer {
                UIPasteboard.general.string = card.clearCardNumber.decrypt()
                let message = card.cardType == .virtualDebit ? ResourceKey.virtualDebitCardCopyInfo.value : ResourceKey.virtualCardCopyInfo.value
                UIViewController.getTopMostViewController()?.showToastMessage(message: message)
            }
        } else {
            imgCopyCardNo.isHidden = true
        }
    }

    private func configureExtendDebitCard(card: ExtendDebitCard) {
        lblLeft1.resource = .cashAdvanceLimit
        lblLeft2.resource = .cashAdvanceAccountLimit
        lblLeft3.resource = .cardListSuppDebitCardName
        lblCardNo.text = card.maskedCardNumber
        lblRight1.text = card.balance
        lblRight2.text = card.availableLimit
        lblRight3.text = "\(card.contactId)"
        if !card.fullName.isEmpty {
            lblCardOwnerName.text = card.fullName
            lblCardOwnerName.isHidden = false
        }
    }

    private func configureVirtualDebitCard(card: VirtualDebitCard) {
        lblLeft1.resource = .cashAdvanceLimit
        lblLeft2.resource = .cashAdvanceAccountLimit
        lblLeft3.resource = .updateCVVCVV
        lblCardNo.text = "\(card.maskedCardNumber) | \(card.expiryDate)"
        lblRight1.text = card.balance
        lblRight2.text = card.availableLimit
        lblRight3.text = card.cvv2
        if !card.fullName.isEmpty {
            lblCardOwnerName.text = card.fullName
            lblCardOwnerName.isHidden = false
        }
    }

    private func configureVirtualCard(card: CardDetail) {
        lblLeft2.resource = .cardListVirtualCardCVV
        lblCardNo.text = "\(card.clearCardNumber.decrypt()) | \(card.expiryDate)"
        lblRight1.text = card.availableLimit
        lblRight2.text = card.cvv2.decrypt()
    }

    private func configureExtendCard(card: WelcomeCard) {
        lblCardNo.text = card.maskedCardNumber
        lblRight1.text = card.availableLimit
        if card.lastPaymentDate.suffix(4).prefix(2) == "19" || card.lastPaymentDate.suffix(4) == "0001" {
            card.lastPaymentDate = "-"
        }
        lblRight2.text = card.lastPaymentDate
        if !card.ownerName.isEmpty {
            lblCardOwnerName.text = card.ownerName
            lblCardOwnerName.isHidden = false
        }
    }

    private func configureCreditCard(card: CreditCard) {
        lblLeft3.resource = .paymentCreditCardRemainingStatementDebt
        lblCardNo.text = card.maskedCardNumber
        lblRight1.text = card.availableLimit
        if card.lastPaymentDate.suffix(4).prefix(2) == "19" || card.lastPaymentDate.suffix(4) == "0001" {
            card.lastPaymentDate = "-"
        }
        lblRight2.text = card.lastPaymentDate
        if !card.remainingDebt.isEmpty {
            lblRight3.text = card.remainingDebtDomestic
        } else if card.remainingDebtUsd != nil {
            if let debtUsd = card.remainingDebtUsd {
                let usdAmount = String(debtUsd).currencyFormatted().replacingOccurrences(of: "₺", with: "")
                lblRight3.text = "\(usdAmount) \(card.remainingDebtUsdCurrency)"
            }
        } else {
            lblRight3.text = "0 TL"
        }
    }

    private func configureBusinessCard(card: BusinessCard) {
        lblLeft3.resource = .paymentCreditCardRemainingStatementDebt
        lblCardNo.text = card.maskedCardNumber
        lblRight1.text = card.availableLimit
        if card.lastPaymentDate.suffix(4).prefix(2) == "19" || card.lastPaymentDate.suffix(4) == "0001" {
            card.lastPaymentDate = "-"
        }
        lblRight2.text = card.lastPaymentDate
        if !card.remainingDebt.isEmpty {
            lblRight3.text = card.remainingDebt
        } else if card.remainingDebtUsd != nil {
            if let debtUsd = card.remainingDebtUsd {
                let usdAmount = String(debtUsd).currencyFormatted().replacingOccurrences(of: "₺", with: "")
                lblRight3.text = "\(usdAmount) \(card.remainingDebtUsdCurrency)"
            }
        } else {
            lblRight3.text = "0 TL"
        }
    }

    private func configureBonusBusinessExtend(card: CreditCard) {
        lblLeft3.resource = .paymentCreditCardRemainingStatementDebt
        lblCardNo.text = card.maskedCardNumber
        lblRight1.text = card.availableLimit
        if card.lastPaymentDate.suffix(4).prefix(2) == "19" || card.lastPaymentDate.suffix(4) == "0001" {
            card.lastPaymentDate = "-"
        }
        lblRight2.text = card.lastPaymentDate
        if !card.ownerName.isEmpty {
            lblCardOwnerName.text = card.ownerName
            lblCardOwnerName.isHidden = false
        }
    }

    private func configureDebitCard(card: DebitCard) {
        lblCardNo.text = card.maskedCardNumber
        lblLeft1.resource = .cashAdvanceLimit
        lblLeft2.resource = .cashAdvanceAccountLimit
        lblLeft3.resource = .cardListDebitCardAccountNumber
        lblRight1.text = card.balance
        lblRight2.text = card.availableLimit
        lblRight3.text = card.account
    }

    private func configureProducerCard(card: Card) {
        lblLeft1.resource = .agricultureCardStatementDate
        lblLeft2.resource = .producerCardTotalLimit
        lblCardNo.text = card.maskedCardNumber
        if card.statementDate.suffix(4).prefix(2) == "19" || card.statementDate.suffix(4) == "0001" {
            card.statementDate = "-"
        }
        lblRight1.text = card.statementDate
        lblRight2.text = card.totalLimit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func configureLines() {
        guard let cardType = card?.cardType else { return }
        switch cardType {
        case .credit,
             .business,
             .debit,
             .bonusBusiness,
             .virtualDebit,
             .extendedDebit:
            lblLeft3.isHidden = false
            viewMiddle3.isHidden = false
            lblRight3.isHidden = false
        default:
            lblLeft3.isHidden = true
            viewMiddle3.isHidden = true
            lblRight3.isHidden = true
        }
        guard let card = card else { return }
        lblLeft4.isHidden = card.remainingDebtUsd == nil
        lblLeft5.isHidden = card.remainingDebtEuro == nil
        viewMiddle4.isHidden = card.remainingDebtUsd == nil
        viewMiddle5.isHidden = card.remainingDebtEuro == nil
        lblRight4.isHidden = card.remainingDebtUsd == nil
        lblRight5.isHidden = card.remainingDebtEuro == nil
    }

    func setAccessibilityIdentifiers() {
        lblLeft1.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelLeft1)
        lblLeft2.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelLeft2)
        lblLeft3.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelLeft3)
        lblLeft4.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelLeft4)
        lblLeft5.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelLeft5)
        lblRight1.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelRight1)
        lblRight2.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelRight2)
        lblRight3.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelRight3)
        lblRight4.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelRight4)
        lblRight5.accessibilityIdentifier = createAccessibilityIdentifier(key: .labelRight5)
        lblCardOwnerName.accessibilityIdentifier = createAccessibilityIdentifier(key: .title)
        lblCardNo.accessibilityIdentifier = createAccessibilityIdentifier(key: .cardNo)
        lblCardName.accessibilityIdentifier = createAccessibilityIdentifier(key: .cardName)
    }

    private func createAccessibilityIdentifier(key: AccessibilityKey) -> String {
        guard let cardType = card?.cardType else { return key.value }
        return "\(cardType.rawValue)-\(key.value)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblCardName.text = ""
        lblCardNo.text = ""
        lblCardOwnerName.text = ""
        lblLeft1.text = ""
        lblLeft2.text = ""
        lblLeft3.text = ""
        lblLeft4.text = ""
        lblLeft5.text = ""
        lblRight1.text = ""
        lblRight2.text = ""
        lblRight3.text = ""
        lblRight4.text = ""
        lblRight5.text = ""
        imgViewCard.image = nil
        bag.dispose()
    }
}
