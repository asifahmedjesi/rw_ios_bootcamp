//
//  CSTitleLabel.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 18/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class CSDetailsTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        configure()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        font = .systemFont(ofSize: 17)
    }
}
