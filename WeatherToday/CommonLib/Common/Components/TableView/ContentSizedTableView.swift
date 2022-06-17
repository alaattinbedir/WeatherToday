//
//  ContentSizedTableView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
class ContentSizedTableView: UITableView {
    @IBInspectable var maxHeight: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()

        if maxHeight > 0, contentSize.height > maxHeight {
            return CGSize(width: UIView.noIntrinsicMetric, height: maxHeight)
        }

        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

class ContentSizedCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
