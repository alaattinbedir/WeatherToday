//
//  BesApplyPlanCellView.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

class BesApplyPlanCellView: UITableViewCell, NibLoadable {
    var disposeBag = DisposeBag()

    @IBOutlet var planDetail: UILabel!
    @IBOutlet var planAmount: UILabel!

    func configure(planDetail: String, planAmount: String) {
        self.planDetail.text = planDetail
        self.planAmount.isHidden = planAmount.isEmpty
        self.planAmount.text = "\("Bes.PlanListing.MinSaving.Text".resource()): \(planAmount)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
