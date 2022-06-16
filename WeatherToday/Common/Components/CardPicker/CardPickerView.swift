//
//  CardPickerView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import UIKit

enum PickerType: Int {
    case card = 0
    case account = 1
}

class CardAccountPickerItem {
    var left1: String = ""
    var left2: String = ""
    var left3: String = ""
    var right2: String = ""
    var currency: String = ""
    var isButtonEnabled = true
    var ownerName = ""
    var isShowBalance = false
    var balanceAmount: String = ""
    var isShowName = true
    var softLoginLimitFirst: String = ""
    var softLoginLimitSecond: String = ""
    var cardType: CardType = .credit
    var isAccount: Bool = false
    var isDebitCard: Bool = false

    init(left1: String,
         left2: String,
         left3: String = "",
         right2: String,
         currency: String,
         isButtonEnabled: Bool = true,
         ownerName: String = "",
         isShowBalance: Bool = false,
         balanceAmount: String = "",
         softLoginLimitFirst: String = "",
         softLoginLimitSecond: String = "",
         cardType: CardType = .credit,
         isAccount: Bool = false,
         isDebitCard: Bool = false) {
        self.left1 = left1
        self.left2 = left2
        self.left3 = left3
        self.right2 = right2
        self.currency = currency
        self.isButtonEnabled = isButtonEnabled
        self.ownerName = ownerName
        self.isShowBalance = isShowBalance
        self.balanceAmount = balanceAmount
        self.softLoginLimitFirst = softLoginLimitFirst
        self.softLoginLimitSecond = softLoginLimitSecond
        self.cardType = cardType
        self.isAccount = isAccount
        self.isDebitCard = isDebitCard
    }
}

protocol CardAccountPickerItemable {
    var pickerItem: CardAccountPickerItem { get }
}

class CardPickerView: UIView {
    private var pSelectedType: PickerType = .card
    @IBInspectable var selectedType: Int {
        get { return pSelectedType.rawValue }
        set {
            if let type = PickerType(rawValue: newValue) {
                pSelectedType = type
            }
        }
    }

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblObjectTitle: UILabel!
    @IBOutlet var lblObjectDetail1: UILabel!
    @IBOutlet var lblObjectDetail2: UILabel!
    @IBOutlet var lblAmountTitle: UILabel! {
        didSet {
            lblAmountTitle.resource = .generalCardLimitAvailableLimit
        }
    }

    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblBalance: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblChange: UILabel! {
        didSet {
            lblChange.resource = .change
        }
    }

    @IBOutlet var btnSelect: UIButton!
    @IBOutlet var imgDown: UIImageView!
    @IBOutlet var viewChange: UIView! {
        didSet {
            viewChange.isHidden = true
        }
    }

    var item: CardAccountPickerItem? {
        didSet { updatePickerItem() }
    }

    override func awakeAfter(using _: NSCoder) -> Any? {
        return loadFromNibIfEmbeddedInDifferentNib()
    }

    func updatePickerItem() {
        guard let item = item else { return }
        lblObjectTitle.text = (item.isDebitCard) ? item.currency + "-" + item.left1 : item.left1
        lblObjectDetail1.text = item.left2
        lblObjectDetail2.text = item.left3
        configureCardPickerAmount()
        btnSelect.isUserInteractionEnabled = item.isButtonEnabled
        let size = lblChange.bounds.size
        lblChange.resource = item.isAccount ? .changeAccount : .change
        lblChange.textColor = UIColor.gradient(startColor: .salmon,
                                               endColor: .paleMagenta,
                                               style: .horizontal,
                                               size: size == CGSize(width: 0, height: 0) ?
                                                   CGSize(width: 75, height: 25) : size)
        lblChange.isHidden = !item.isButtonEnabled
        viewChange.isHidden = !item.isButtonEnabled
        if item.currency == "TRY" {
            item.currency = "TL"
        }
        if !(item.balanceAmount.contains("TL") || item.balanceAmount.contains("TRY") || item.balanceAmount.contains("USD") || item.balanceAmount.contains("EUR") || item
            .balanceAmount.contains("XAU")) {
            lblBalance.text = "\(ResourceKey.cashAdvanceLimit.value): \(item.balanceAmount) \(item.currency)"
        } else {
            lblBalance.text = "\(ResourceKey.cashAdvanceLimit.value): \(item.balanceAmount)"
        }
        lblBalance.isHidden = !item.isShowBalance
        lblName.isHidden = !item.isShowName
        imgDown.isHidden = !item.isButtonEnabled
        lblName.text = item.ownerName
        setAccessibilityIdentifiers()
    }

    func configureCardPickerAmount() {
        guard let item = item else { return }
        if SessionKeeper.shared.isUserLoggedIn {
            if item.right2.contains("***") {
                if item.currency == "TRY" {
                    item.currency = "TL"
                }
                let limitFirst = "***"
                let limitSecond = ",*** \(item.currency)"
                setAttributedString(limitFirst: limitFirst,
                                    limitSecond: limitSecond,
                                    label: lblAmount)
            } else {
                lblAmount.amountAttributed(amount: item.right2.trimmingWhitespace().amountToDouble(),
                                           currency: item.currency,
                                           fractionDigits: 2,
                                           removeZeroIfNeeded: false,
                                           font: lblAmount.font,
                                           fractionalFont: AppFont.regular12)
            }
        } else {
            let limitFirst = item.softLoginLimitFirst
            let limitSecond = item.softLoginLimitSecond
            setAttributedString(limitFirst: limitFirst,
                                limitSecond: limitSecond,
                                label: lblAmount)
        }
    }

    private func setAccessibilityIdentifiers() {
        lblTitle.accessibilityKey = .cardAccountPickerTitle
        lblObjectTitle.accessibilityKey = .cardPickerObjectTitle
        lblObjectDetail1.accessibilityKey = .cardPickerObjectDetail1
        lblObjectDetail2.accessibilityKey = .cardPickerObjectDetail2
        lblAmountTitle.accessibilityKey = .amountTitle
        lblAmount.accessibilityKey = .cardPickerAmount
        lblBalance.accessibilityKey = .cardPickerbalance
        btnSelect.accessibilityKey = .cardPickerButtonSelection
    }
}
