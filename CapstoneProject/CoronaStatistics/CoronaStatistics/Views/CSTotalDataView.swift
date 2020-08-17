//
//  CSTotalDataView.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class CSTotalStatisticsView: UIView {

    static let height: CGFloat = 55
    
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String = "" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
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
        
        configureTitleLabel()
        configureSubtitleLabel()
        
        setupConstraints()
    }
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        addSubview(titleLabel)
    }
    func configureSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = .black
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .systemFont(ofSize: 13)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupSubtitleLabelConstraints()
    }
    
    func setupTitleLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8))
        constraints.append(titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSubtitleLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 8))
        constraints.append(subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -8))
        constraints.append(subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8))
        NSLayoutConstraint.activate(constraints)
    }
}


