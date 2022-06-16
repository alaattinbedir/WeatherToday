//
//  CardSelectionHeaderView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//
import UIKit

class CardSelectionHeaderView: UIView {
    static let height: CGFloat = 40.0

    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var imgSelection: UIImageView!

    var metadata: CardSelectionMetaData? {
        didSet { configureView() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }

    private func configureView() {
        guard let cardType = metadata?.cardType else { return }
        guard let numOfCards = metadata?.numOfCards else { return }
        let title = ResourceKey.resource("GeneralCardTypeName.\(cardType.rawValue)").value
            + " (\(numOfCards))"
        lblHeader.text = title
        guard let isCollapsed = metadata?.isCollapsed else { return }
        imgSelection.image = isCollapsed ? #imageLiteral(resourceName: "imgCollapsed") : #imageLiteral(resourceName: "imgExpansed")
    }

    private func setAccessibilityIdentifiers() {
        lblHeader.accessibilityKey = .header
        imgSelection.accessibilityKey = .cardAccountPickerImage
    }
}
