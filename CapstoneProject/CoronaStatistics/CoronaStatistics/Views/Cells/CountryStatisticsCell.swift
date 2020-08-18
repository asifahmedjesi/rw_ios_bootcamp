//
//  CountryStatisticsCell.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 17/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class CountryStatisticsCell: BaseTableViewCell {

    let countryLabel: CSPaddingLabel = {
        let label = CSPaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.padding(top: 0, bottom: 0, left: 12, right: 0)
        return label
    }()

    let confirmedLabel: CSPaddingLabel = {
        let label = CSPaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.padding(top: 0, bottom: 0, left: 0, right: 8)
        return label
    }()

    let deathLabel: CSPaddingLabel = {
        let label = CSPaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.padding(top: 0, bottom: 0, left: 0, right: 8)
        return label
    }()

    let recoveredLabel: CSPaddingLabel = {
        let label = CSPaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 121/255, green: 198/255, blue: 99/255, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.padding(top: 0, bottom: 0, left: 0, right: 12)
        return label
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static var heightForRow: CGFloat = 45
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        countryLabel.text = nil
        confirmedLabel.text = nil
        deathLabel.text = nil
        recoveredLabel.text = nil
    }
    
    func configure() {
        self.contentView.addSubview(countryLabel)
        self.contentView.addSubview(confirmedLabel)
        self.contentView.addSubview(deathLabel)
        self.contentView.addSubview(recoveredLabel)
        self.contentView.addSubview(seperator)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        setupCountryLabelConstraints()
        setupConfirmedLabelConstraints()
        setupDeathLabelConstraints()
        setupRecoveredLabelConstraints()
        setupSeperatorConstraints()
    }
    
    func setupSeperatorConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(seperator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        constraints.append(seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12))
        constraints.append(seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(seperator.heightAnchor.constraint(equalToConstant: 0.5))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupCountryLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(countryLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.30))
        constraints.append(countryLabel.trailingAnchor.constraint(equalTo: confirmedLabel.leadingAnchor))
        constraints.append(countryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupConfirmedLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(confirmedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.26))
        constraints.append(confirmedLabel.trailingAnchor.constraint(equalTo: deathLabel.leadingAnchor))
        constraints.append(confirmedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupDeathLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(deathLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22))
        constraints.append(deathLabel.trailingAnchor.constraint(equalTo: recoveredLabel.leadingAnchor))
        constraints.append(deathLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupRecoveredLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(recoveredLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22))
        constraints.append(recoveredLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(recoveredLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }

}
