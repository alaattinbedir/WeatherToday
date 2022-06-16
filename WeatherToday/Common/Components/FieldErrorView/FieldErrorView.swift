//
//  FieldErrorView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import UIKit

class FieldErrorView: BaseFormField {
    @IBOutlet var lblError: UILabel!
    @IBOutlet var viewContainer: UIView!

    var text: String? {
        didSet { lblError.text = text }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifiers()
    }

    private func setAccessibilityIdentifiers() {
        lblError.accessibilityKey = .error
    }

    func animateContainer() {
        viewContainer.transform = CGAffineTransform(translationX: 0, y: 100)
        AnimationHelper.animate(with: .fieldError, animations: { [weak self] in
            self?.viewContainer.transform = .identity
        }, completion: nil)
    }
}
