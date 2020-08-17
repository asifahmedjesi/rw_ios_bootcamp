//
//  BaseTableViewCell.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 17/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
