//
//  ClueRepresentable.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 28/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

protocol ClueRepresentable {
    var rowHeight: CGFloat { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
