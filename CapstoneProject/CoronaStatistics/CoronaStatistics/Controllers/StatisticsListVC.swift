//
//  StatisticsListVC.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

// MARK:- Configure UI
class StatisticsListVC: UIViewController {

    let totalConfirmedView: TotalStatisticsView = TotalStatisticsView()
    let totalCriticalView: TotalStatisticsView = TotalStatisticsView()
    let totalDeathView: TotalStatisticsView = TotalStatisticsView()
    let totalDeathPercentageView: TotalStatisticsView = TotalStatisticsView()
    let totalRecoveredView: TotalStatisticsView = TotalStatisticsView()
    let totalRecoveredPercentageView: TotalStatisticsView = TotalStatisticsView()

    let tableView: UITableView = UITableView()

    var items: [CountryStatistics] = [CountryStatistics]()
    var totalStatistics: TotalStatistics?
    
    var totalStatisticsLoaded = false
    var countryStatisticsLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        loadTotalSatistics()
        loadCountrySatistics()
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
        tableView.dataSource = self
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
        let vc = StatisticsDetailsVC()
        vc.item = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- TableView Data Source
extension StatisticsListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryStatisticsCell.identifier, for: indexPath) as! CountryStatisticsCell
        
        cell.countryLabel.text = item.country
        cell.confirmedLabel.text = item.confirmed.withCommas()
        cell.deathLabel.text = item.deaths.withCommas()
        cell.recoveredLabel.text = item.recovered.withCommas()
        
        cell.selectionStyle = .none
        
        return cell
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

// MARK:- API Services
extension StatisticsListVC {
    
    func loadTotalSatistics() {
        self.totalStatisticsLoaded = false
        self.showSpinnerView()
        NetworkService.shared.getTotalStatistics { (data) in
            self.totalStatisticsLoaded = true
            DispatchQueue.main.async {
                if self.totalStatisticsLoaded && self.countryStatisticsLoaded {
                    self.hideSpinnerView()
                }
            }
            self.totalStatistics = data
            guard let item = data else { return }
            
            DispatchQueue.main.async {
                self.setTitles(statisticsView: self.totalConfirmedView, title: item.confirmed.withCommas(), subtitle: "Confirmed")
                self.setTitles(statisticsView: self.totalCriticalView, title: item.critical.withCommas(), subtitle: "Critical")
                self.setTitles(statisticsView: self.totalDeathView, title: item.deaths.withCommas(), subtitle: "Death")
                self.setTitles(statisticsView: self.totalDeathPercentageView, title: item.fatalityRate.withCommasAndMin2Digit(), subtitle: "Death %")
                self.setTitles(statisticsView: self.totalRecoveredView, title: item.confirmed.description, subtitle: "Recovered")
                self.setTitles(statisticsView: self.totalRecoveredPercentageView, title: item.recoveredRate.withCommasAndMin2Digit(), subtitle: "Recovered %")
            }
        }
    }
    func loadCountrySatistics() {
        self.countryStatisticsLoaded = false
        self.showSpinnerView()
        NetworkService.shared.getAllCountryStatistics { (list) in
            self.countryStatisticsLoaded = true
            DispatchQueue.main.async {
                if self.totalStatisticsLoaded && self.countryStatisticsLoaded {
                    self.hideSpinnerView()
                }
            }
            
            self.items = list
            self.items.sort { $0.confirmed > $1.confirmed }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
