//
//  BaseTableViewCell.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
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
