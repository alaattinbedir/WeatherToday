//
//  BesApplyVM.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

class BesApplyVM {
    let disposeBag = DisposeBag()
    let pageLoadingStatus = BehaviorRelay<PageLoadingStatus>(value: PageLoadingStatus.loading)
    let title = BehaviorRelay<String>(value: "Bes.Application.Title".resource())
    let plans = BehaviorRelay<[Product]?>(value: nil)
    let selectedPlan = BehaviorRelay<Product?>(value: nil)
    let information = BehaviorRelay<String?>(value: nil)
    let besQuestions = BehaviorRelay<[BesApplyPageQuestion]?>(value: nil)
    let fundPreferences = BehaviorRelay<[BesPreference]?>(value: nil)
}

extension BesApplyVM {
    func fetchBesPlans() {
        pageLoadingStatus.accept(.loading)
        BesApplyGetPlansEP().execute()
            .onSucceeded { [weak self] response in
                guard let self = self else { return }

                self.plans.accept(response.products)
                self.information.accept(response.info)
                self.besQuestions.accept(response.pageQuestionInfos)
                self.fundPreferences.accept(response.fundSelectionPreferences)
                self.pageLoadingStatus.accept(.success)
            }
            .onError { [weak self] error in
                self?.pageLoadingStatus.accept(PageLoadingStatus.fatal(error))
            }
    }
}
