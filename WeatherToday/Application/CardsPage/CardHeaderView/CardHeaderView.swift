//
//  CardHeaderView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

class CardHeaderView: UIView {
    static let height: CGFloat = 40.0

    @IBOutlet var addCardView: UIView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var lblButton: UILabel!

    var cardType: CardType? {
        didSet { configureView() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }

    func configureAddCardButton(isShowing: Bool = false) {
        addCardView.isHidden = !isShowing
    }

    private func configureView() {
        guard let cardType = cardType else { return }
        switch cardType {
        case .credit:
            lblHeader.resource = .cardListMainCardHeader
            lblButton.resource = .cardListCreateNewCreditCard
        case .extend:
            lblHeader.resource = .cardListSupplementaryCard
            lblButton.resource = .cardListCreateNewSupplementaryCard
        case .virtual:
            lblHeader.resource = .cardListVirtualCardHeader
            lblButton.resource = .cardListCreateNewVirtualCard
        case .debit:
            lblHeader.resource = .cardTypeDebit
            lblButton.resource = .cardListCreateNewDebitCard
        case .extendedDebit:
            lblHeader.resource = .cardTypeDebitExtended
            lblButton.resource = .cardListCreateNewSupplementaryCard
        case .virtualDebit:
            lblHeader.resource = .cardListDebitVirtualCardTitle
            lblButton.resource = .cardListCreateNewVirtualCard
        case .business:
            lblHeader.resource = .cardTypeBusinessMain
        case .businessExtend:
            lblHeader.resource = .cardTypeBusinessExtend
        case .producer:
            lblHeader.resource = .cardTypeProducerMain
        case .bonusBusiness:
            lblHeader.resource = .bonusBusinessCardsTitle
        case .bonusBusinessExtend:
            lblHeader.resource = .bonusBusinessAdditionalCardsTitle
        case .bonusBusinessVirtual:
            lblHeader.resource = .cardTypeBonusBusinessVirtual
        default:
            lblHeader.resource = .cardTypeMain
        }
    }

    private func setAccessibilityIdentifiers() {
        lblHeader.accessibilityKey = .header
        lblButton.accessibilityKey = .button1
    }
}
