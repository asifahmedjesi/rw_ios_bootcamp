//
//  CountryStatisticsDataSource.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 20/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation
import UIKit

class CountryStatisticsDataSource: NSObject, UITableViewDataSource {

    var data: DynamicCountryStatisticsRepresentable = DynamicCountryStatisticsRepresentable([])

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data.value[indexPath.row].cellInstance(tableView, indexPath: indexPath)
    }

}
