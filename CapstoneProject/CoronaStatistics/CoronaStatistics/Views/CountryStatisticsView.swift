//
//  CountryStatisticsView.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 18/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class CountryStatisticsView: UIView {

    static let height: CGFloat = 260
    private let verticalPadding: CGFloat = 20

    private var confirmedTitleLabel: CSDetailsTitleLabel = CSDetailsTitleLabel(title: "Confirmed")
    public var confirmedValueLabel: CSDetailsValueLabel = CSDetailsValueLabel(color: .darkGray)

    private var criticalTitleLabel: CSDetailsTitleLabel = CSDetailsTitleLabel(title: "Critical")
    public var criticalValueLabel: CSDetailsValueLabel = CSDetailsValueLabel(color: .orange)

    private var deathTitleLabel: CSDetailsTitleLabel = CSDetailsTitleLabel(title: "Death")
    public var deathValueLabel: CSDetailsValueLabel = CSDetailsValueLabel(color: .red)

    private var deathPercentageTitleLabel: CSDetailsTitleLabel = CSDetailsTitleLabel(title: "Death %")
    public var deathPercentageValueLabel: CSDetailsValueLabel = CSDetailsValueLabel(color: .red)

    private var recoveredTitleLabel: CSDetailsTitleLabel = CSDetailsTitleLabel(title: "Recovered")
    public var recoveredValueLabel: CSDetailsValueLabel = CSDetailsValueLabel(color: UIColor(red: 121/255, green: 198/255, blue: 99/255, alpha: 1))

    private var recoveredPercentageTitleLabel: CSDetailsTitleLabel = CSDetailsTitleLabel(title: "Recovered %")
    public var recoveredPercentageValueLabel: CSDetailsValueLabel = CSDetailsValueLabel(color: UIColor(red: 121/255, green: 198/255, blue: 99/255, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    init() {
        super.init(frame: .zero)
        configure()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 246/255, alpha: 1)
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        
        addSubview(confirmedTitleLabel)
        addSubview(confirmedValueLabel)
        addSubview(criticalTitleLabel)
        addSubview(criticalValueLabel)
        addSubview(deathTitleLabel)
        addSubview(deathValueLabel)
        addSubview(deathPercentageTitleLabel)
        addSubview(deathPercentageValueLabel)
        addSubview(recoveredTitleLabel)
        addSubview(recoveredValueLabel)
        addSubview(recoveredPercentageTitleLabel)
        addSubview(recoveredPercentageValueLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        setupConfirmedTitleLabelConstraints()
        setupConfirmedValueLabelConstraints()
        
        setupLabelConstraints(left: criticalTitleLabel, right: confirmedTitleLabel)
        setupLabelConstraints(left: criticalValueLabel, right: confirmedValueLabel)
        
        setupLabelConstraints(left: deathTitleLabel, right: criticalTitleLabel)
        setupLabelConstraints(left: deathValueLabel, right: criticalValueLabel)
        
        setupLabelConstraints(left: deathPercentageTitleLabel, right: deathTitleLabel)
        setupLabelConstraints(left: deathPercentageValueLabel, right: deathValueLabel)
        
        setupLabelConstraints(left: recoveredTitleLabel, right: deathPercentageTitleLabel)
        setupLabelConstraints(left: recoveredValueLabel, right: deathPercentageValueLabel)
        
        setupLabelConstraints(left: recoveredPercentageTitleLabel, right: recoveredTitleLabel)
        setupLabelConstraints(left: recoveredPercentageValueLabel, right: recoveredValueLabel)
    }
    
    func setupConfirmedTitleLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(confirmedTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12))
        constraints.append(confirmedTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3))
        constraints.append(confirmedTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding))
        NSLayoutConstraint.activate(constraints)
    }
    func setupConfirmedValueLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(confirmedValueLabel.leadingAnchor.constraint(equalTo: confirmedTitleLabel.trailingAnchor, constant: 8))
        constraints.append(confirmedValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12))
        constraints.append(confirmedValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding))
        NSLayoutConstraint.activate(constraints)
    }
    func setupLabelConstraints(left: UILabel, right: UILabel) {
        var constraints = [NSLayoutConstraint]()
        constraints.append(left.leadingAnchor.constraint(equalTo: right.leadingAnchor))
        constraints.append(left.trailingAnchor.constraint(equalTo: right.trailingAnchor))
        constraints.append(left.topAnchor.constraint(equalTo: right.bottomAnchor, constant: verticalPadding))
        NSLayoutConstraint.activate(constraints)
    }
    
}
