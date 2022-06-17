//
//  NoCardCell.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import UIKit

class NoCardCell: UITableViewCell {
    @IBOutlet var lblNoCard: UILabel!
    @IBOutlet var btnAddCard: FormButton!

    var cardType: CardType? {
        didSet {
            configureView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }

    private func configureView() {
        lblNoCard.resource = .cardListNoCardMessage
        btnAddCard.resource = .cardApplicationButton
    }

    private func setAccessibilityIdentifiers() {
        lblNoCard.accessibilityKey = .header
        btnAddCard.accessibilityKey = .button1
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag.dispose()
        lblNoCard.text = ""
    }
}
