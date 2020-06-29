//
//  MediaPostViewModel.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

protocol MediaPostRepresentable {
    var rowHeight: CGFloat { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol ExtendedMediaPost: MediaPost {
    func convertToViewModel() -> MediaPostRepresentable
}
