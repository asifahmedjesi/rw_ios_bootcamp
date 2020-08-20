//
//  StatisticsListVC.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

protocol StatisticsListViewModelDelegate: class {
    func fetchTotalStatistics(completionHandler: @escaping (_ stats: TotalStatistics?) -> Void)
    func fetchCountryStatistics(completionHandler: @escaping () -> Void)
}

// MARK:- Configure UI
class StatisticsListVC: UIViewController {

    let totalConfirmedView: TotalStatisticsView = TotalStatisticsView()
    let totalCriticalView: TotalStatisticsView = TotalStatisticsView()
    let totalDeathView: TotalStatisticsView = TotalStatisticsView()
    let totalDeathPercentageView: TotalStatisticsView = TotalStatisticsView()
    let totalRecoveredView: TotalStatisticsView = TotalStatisticsView()
    let totalRecoveredPercentageView: TotalStatisticsView = TotalStatisticsView()

    let tableView: UITableView = UITableView()

    let dataSource = CountryStatisticsDataSource()

    lazy var viewModel : StatisticsListViewModel = {
        let viewModel = StatisticsListViewModel(dataSource: dataSource)
        return viewModel
    }()

    var items: [CountryStatistics] = [CountryStatistics]()

    var totalStatisticsLoaded = false
    var countryStatisticsLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        self.dataSource.data.addObserverAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.totalStatisticsLoaded = false
        self.countryStatisticsLoaded = false
        self.showSpinnerView()
        
        self.viewModel.fetchTotalStatistics { (stats) in
            self.totalStatisticsLoaded = true
            DispatchQueue.main.async {
                if self.totalStatisticsLoaded && self.countryStatisticsLoaded {
                    self.hideSpinnerView()
                }
            }
            guard let item = stats else { return }
            
            DispatchQueue.main.async {
                self.setTitles(statisticsView: self.totalConfirmedView, title: item.confirmed.withCommas(), subtitle: "Confirmed")
                self.setTitles(statisticsView: self.totalCriticalView, title: item.critical.withCommas(), subtitle: "Critical")
                self.setTitles(statisticsView: self.totalDeathView, title: item.deaths.withCommas(), subtitle: "Death")
                self.setTitles(statisticsView: self.totalDeathPercentageView, title: item.fatalityRate.withCommasAndMin2Digit(), subtitle: "Death %")
                self.setTitles(statisticsView: self.totalRecoveredView, title: item.confirmed.description, subtitle: "Recovered")
                self.setTitles(statisticsView: self.totalRecoveredPercentageView, title: item.recoveredRate.withCommasAndMin2Digit(), subtitle: "Recovered %")
            }
        }
        
        self.viewModel.fetchCountryStatistics {
            self.countryStatisticsLoaded = true
            DispatchQueue.main.async {
                if self.totalStatisticsLoaded && self.countryStatisticsLoaded {
                    self.hideSpinnerView()
                }
            }
        }
        
    }

    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(totalConfirmedView)
        view.addSubview(totalCriticalView)
        view.addSubview(totalDeathView)
        view.addSubview(totalDeathPercentageView)
        view.addSubview(totalRecoveredView)
        view.addSubview(totalRecoveredPercentageView)
        
        configureTableView()
        setupViewConstraints()
    }
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(CountryStatisticsSectionHeader.self, forHeaderFooterViewReuseIdentifier: CountryStatisticsSectionHeader.identifier)
        tableView.register(CountryStatisticsCell.self, forCellReuseIdentifier: CountryStatisticsCell.identifier)
        
        view.addSubview(tableView)
    }

    func setTitles(statisticsView: TotalStatisticsView, title: String, subtitle: String) {
        statisticsView.title = title
        statisticsView.subtitle = subtitle
    }

}

// MARK:- TableView Delegate
extension StatisticsListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CountryStatisticsCell.heightForRow
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CountryStatisticsSectionHeader.heightForRow
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CountryStatisticsSectionHeader.identifier) as? CountryStatisticsSectionHeader
        return header
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.000001))
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = self.dataSource.data.value[indexPath.row] as? CountryStatisticsViewModel {
            let vc = StatisticsDetailsVC()
            vc.item = item
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK:- Constraints Setup
extension StatisticsListVC {
    
    func setupViewConstraints() {
        setupConfirmedViewConstraints()
        setupCriticalViewConstraints()
        setupDeathViewConstraints()
        setupDeathPercentageViewConstraints()
        setupRecoveredViewConstraints()
        setupRecoveredPercentageViewConstraints()
        setupTableViewConstraints()
    }
    func setupConfirmedViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(totalConfirmedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30))
        constraints.append(totalConfirmedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(totalConfirmedView.widthAnchor.constraint(equalTo: totalCriticalView.widthAnchor))
        constraints.append(totalConfirmedView.heightAnchor.constraint(equalToConstant: TotalStatisticsView.height))
        NSLayoutConstraint.activate(constraints)
    }
    func setupCriticalViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(totalCriticalView.topAnchor.constraint(equalTo: totalConfirmedView.topAnchor))
        constraints.append(totalCriticalView.heightAnchor.constraint(equalTo: totalConfirmedView.heightAnchor))
        constraints.append(totalCriticalView.leadingAnchor.constraint(equalTo: totalConfirmedView.trailingAnchor, constant: 16))
        constraints.append(totalCriticalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        NSLayoutConstraint.activate(constraints)
    }
    func setupDeathViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(totalDeathView.topAnchor.constraint(equalTo: totalConfirmedView.bottomAnchor, constant: 16))
        constraints.append(totalDeathView.leadingAnchor.constraint(equalTo: totalConfirmedView.leadingAnchor))
        constraints.append(totalDeathView.trailingAnchor.constraint(equalTo: totalConfirmedView.trailingAnchor))
        constraints.append(totalDeathView.heightAnchor.constraint(equalTo: totalConfirmedView.heightAnchor))
        constraints.append(totalDeathView.widthAnchor.constraint(equalTo: totalConfirmedView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    func setupDeathPercentageViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(totalDeathPercentageView.topAnchor.constraint(equalTo: totalDeathView.topAnchor))
        constraints.append(totalDeathPercentageView.leadingAnchor.constraint(equalTo: totalCriticalView.leadingAnchor))
        constraints.append(totalDeathPercentageView.trailingAnchor.constraint(equalTo: totalCriticalView.trailingAnchor))
        constraints.append(totalDeathPercentageView.heightAnchor.constraint(equalTo: totalCriticalView.heightAnchor))
        constraints.append(totalDeathPercentageView.widthAnchor.constraint(equalTo: totalCriticalView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    func setupRecoveredViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(totalRecoveredView.topAnchor.constraint(equalTo: totalDeathView.bottomAnchor, constant: 16))
        constraints.append(totalRecoveredView.leadingAnchor.constraint(equalTo: totalDeathView.leadingAnchor))
        constraints.append(totalRecoveredView.trailingAnchor.constraint(equalTo: totalDeathView.trailingAnchor))
        constraints.append(totalRecoveredView.heightAnchor.constraint(equalTo: totalDeathView.heightAnchor))
        constraints.append(totalRecoveredView.widthAnchor.constraint(equalTo: totalDeathView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    func setupRecoveredPercentageViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(totalRecoveredPercentageView.topAnchor.constraint(equalTo: totalRecoveredView.topAnchor))
        constraints.append(totalRecoveredPercentageView.leadingAnchor.constraint(equalTo: totalDeathPercentageView.leadingAnchor))
        constraints.append(totalRecoveredPercentageView.trailingAnchor.constraint(equalTo: totalDeathPercentageView.trailingAnchor))
        constraints.append(totalRecoveredPercentageView.heightAnchor.constraint(equalTo: totalDeathPercentageView.heightAnchor))
        constraints.append(totalRecoveredPercentageView.widthAnchor.constraint(equalTo: totalDeathPercentageView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    func setupTableViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(tableView.topAnchor.constraint(equalTo: totalRecoveredView.bottomAnchor, constant: 12))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }
}
