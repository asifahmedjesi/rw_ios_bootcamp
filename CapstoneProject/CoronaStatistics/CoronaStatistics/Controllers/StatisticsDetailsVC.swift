//
//  StatisticsDetailsVC.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class StatisticsDetailsVC: UIViewController {

    let countryStatisticsDetails: CountryStatisticsView = CountryStatisticsView()

    var item: CountryStatistics!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = item.country
        configureUI()
    }

    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(countryStatisticsDetails)
        
        setupViewConstraints()
        if item != nil {
            loadData()
        }
    }

    func loadData() {
        countryStatisticsDetails.confirmedValueLabel.text = item.confirmed.withCommas()
        countryStatisticsDetails.criticalValueLabel.text = item.critical.withCommas()
        countryStatisticsDetails.deathValueLabel.text = item.deaths.withCommas()
        countryStatisticsDetails.deathPercentageValueLabel.text = item.fatalityRate.withCommasAndMin2Digit() + "%"
        countryStatisticsDetails.recoveredValueLabel.text = item.recovered.withCommas()
        countryStatisticsDetails.recoveredPercentageValueLabel.text = item.recoveredRate.withCommasAndMin2Digit() + "%"
    }
}

// MARK:- Constraints Setup
extension StatisticsDetailsVC {
    
    func setupViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(countryStatisticsDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16))
        constraints.append(countryStatisticsDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(countryStatisticsDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        constraints.append(countryStatisticsDetails.heightAnchor.constraint(equalToConstant: CountryStatisticsView.height))
        NSLayoutConstraint.activate(constraints)
    }
}
