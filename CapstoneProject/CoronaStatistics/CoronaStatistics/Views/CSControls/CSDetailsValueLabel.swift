//
//  CSDetailsValueLabel.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 18/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class CSDetailsValueLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    init(color: UIColor) {
        super.init(frame: .zero)
        self.textColor = color
        configure()
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .right
        font = .systemFont(ofSize: 17)
    }
}
