//
//  CountryStatisticsSection.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 18/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit



class CountryStatisticsSectionHeader: BaseTableHeaderFooterView {
    
    let countryLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.text = "Country"
        label.padding(top: 0, bottom: 0, left: 12, right: 0)
        return label
    }()

    let confirmedLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Confirmed"
        label.padding(top: 0, bottom: 0, left: 0, right: 8)
        return label
    }()

    let deathLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Death"
        label.padding(top: 0, bottom: 0, left: 0, right: 8)
        return label
    }()

    let recoveredLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Recovered"
        label.padding(top: 0, bottom: 0, left: 0, right: 12)
        return label
    }()
    
    let customBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 202/255, alpha: 1)
        return view
    }()
    
    
    static var heightForRow: CGFloat = 50
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(customBackgroundView)
        
        customBackgroundView.addSubview(countryLabel)
        customBackgroundView.addSubview(confirmedLabel)
        customBackgroundView.addSubview(deathLabel)
        customBackgroundView.addSubview(recoveredLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        setupCountryLabelConstraints()
        setupConfirmedLabelConstraints()
        setupDeathLabelConstraints()
        setupRecoveredLabelConstraints()
        setupCustomBackgroundViewConstraints()
    }
    
    func setupCountryLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(countryLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor))
        constraints.append(countryLabel.widthAnchor.constraint(equalTo: customBackgroundView.widthAnchor, multiplier: 0.30))
        constraints.append(countryLabel.trailingAnchor.constraint(equalTo: confirmedLabel.leadingAnchor))
        constraints.append(countryLabel.centerYAnchor.constraint(equalTo: customBackgroundView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupConfirmedLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(confirmedLabel.widthAnchor.constraint(equalTo: customBackgroundView.widthAnchor, multiplier: 0.26))
        constraints.append(confirmedLabel.trailingAnchor.constraint(equalTo: deathLabel.leadingAnchor))
        constraints.append(confirmedLabel.centerYAnchor.constraint(equalTo: customBackgroundView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupDeathLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(deathLabel.widthAnchor.constraint(equalTo: customBackgroundView.widthAnchor, multiplier: 0.22))
        constraints.append(deathLabel.trailingAnchor.constraint(equalTo: recoveredLabel.leadingAnchor))
        constraints.append(deathLabel.centerYAnchor.constraint(equalTo: customBackgroundView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupRecoveredLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(recoveredLabel.widthAnchor.constraint(equalTo: customBackgroundView.widthAnchor, multiplier: 0.22))
        constraints.append(recoveredLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor))
        constraints.append(recoveredLabel.centerYAnchor.constraint(equalTo: customBackgroundView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupCustomBackgroundViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
}
