//
//  CountryStatisticsRepresentable.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 20/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

protocol CountryStatisticsRepresentable {
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
