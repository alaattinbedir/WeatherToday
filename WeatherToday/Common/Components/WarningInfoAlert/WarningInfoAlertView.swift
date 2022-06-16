//
//  WarningInfoAlertView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 16.06.2022.
//

import Bond
import Foundation
import ReactiveKit

enum WarningInfoType {
    case warning
    case info
    case error
    case approve
}

class WarningInfoAlertView: UIView {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var stackView: UIStackView!

    override func awakeAfter(using _: NSCoder) -> Any? {
        return loadFromNibIfEmbeddedInDifferentNib()
    }

    func configureView(type: WarningInfoType,
                       labels: [UILabel]) {
        switch type {
        case .warning:
            imageView.image = #imageLiteral(resourceName: "iconWarning")
            backgroundColor =
                UIColor.gradient(startColor: .warningOne,
                                 endColor: .warningTwo,
                                 style: .horizontal,
                                 size: frame.size)
        case .approve:
            imageView.image = #imageLiteral(resourceName: "approveIcon")
            backgroundColor =
                UIColor.gradient(startColor: .tealishOne,
                                 endColor: .tealishTwo,
                                 style: .horizontal,
                                 size: frame.size)
        case .error:
            imageView.image = #imageLiteral(resourceName: "closeCircle")
            backgroundColor =
                UIColor.gradient(startColor: .errorOne,
                                 endColor: .errorTwo,
                                 style: .horizontal,
                                 size: frame.size)
        case .info:
            imageView.image = #imageLiteral(resourceName: "infoIcon")
            backgroundColor = UIColor.white
        }
        stackView.removeAllArrangedSubviews()
        for label in labels {
            if type == .info {
                label.textColor = .brownishGreyTwo
            }
            stackView.addArrangedSubview(label)
        }
    }
}
