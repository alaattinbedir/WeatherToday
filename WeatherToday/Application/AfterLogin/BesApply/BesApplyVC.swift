//
//  BesApplyVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

class BesApplyVC: BaseVC, RoutingConfiguration {
    private let viewModel = BesApplyVM()

    @IBOutlet var contentView: UIView!

    @IBOutlet var planInformation: UILabel! {
        didSet {
            viewModel.information
                .flatMap { $0.map(Observable.just) ?? Observable.empty() }
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] info in
                    self?.planInformation.text = info
                })
                .disposed(by: viewModel.disposeBag)
        }
    }

    @IBOutlet var tableView: ContentSizedTableView! {
        didSet {
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(BesApplyPlanCellView.nib, forCellReuseIdentifier: BesApplyPlanCellView.reuseIdentifier())

            viewModel.plans
                .flatMap { _ in Observable.just(()) }
                .subscribe(onNext: tableView.reloadData)
                .disposed(by: viewModel.disposeBag)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureItems()
        viewModel.fetchBesPlans()
    }

    override func refreshPageMenuEnum() {
        pageMenuEnum = .besApply
    }
}

// MARK: Bindings

private extension BesApplyVC {
    func bind() {
        bindTitle(viewModel.title, viewModel.disposeBag)
        bindPageLoadingStatus(status: viewModel.pageLoadingStatus, contentView: contentView, contenInfoView: nil, disposeBag: viewModel.disposeBag)
        bindSelectedPlan()
    }

    func bindSelectedPlan() {
        viewModel.selectedPlan
            .flatMap { $0.map(Observable.just) ?? Observable.empty() }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] plan in
                RoutingEnum
                    .besApplyInfoStep(transferObject: BesApplyTO(plan: plan, fundSelectionPrefrences: self?.viewModel.fundPreferences.value,
                                                                 besQuestions: self?.viewModel.besQuestions.value)).navigate()
            })
            .disposed(by: viewModel.disposeBag)
    }
}

// MARK: Configure the components

extension BesApplyVC {
    func configureItems() {
        setRightBarButtonItem()
    }

    func setRightBarButtonItem() {
        let imageName = "question_icon"
        let barbuttonItem = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self,
                                            action: #selector(takeBesDetail))
        barbuttonItem.accessibilityLabel = "Bes.Application.TranDesc.Txt".resource()
        navigationItem.rightBarButtonItem = barbuttonItem
    }

    @objc private func takeBesDetail() {
        guard let questions = viewModel.besQuestions.value else { return }
        RoutingEnum.besApplyDetail(besQuestions: questions).navigate()
    }
}

// MARK: TableView DataSource and Delegate

extension BesApplyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.plans.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: BesApplyPlanCellView.reuseIdentifier(), for: indexPath) ==> BesApplyPlanCellView
            .self
        guard let selectedPlan = viewModel.plans.value?[safe: indexPath.row] else { return cell }
        cell.configure(planDetail: selectedPlan.requestText, planAmount: selectedPlan.minimumEstimatedSavings)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPlan = viewModel.plans.value?[safe: indexPath.row] else { return }
        viewModel.selectedPlan.accept(selectedPlan)
    }
}
