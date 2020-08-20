//
//  StatisticsListViewModel.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 20/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation
import UIKit

class StatisticsListViewModel: StatisticsListViewModelDelegate {
    
    weak private var dataSource: CountryStatisticsDataSource?
    
    public init(dataSource: CountryStatisticsDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchTotalStatistics(completionHandler: @escaping (_ stats: TotalStatistics?) -> Void) {
        NetworkService.shared.getTotalStatistics { (data) in
            guard let item = data else {
                completionHandler(nil)
                return
            }            
            completionHandler(item)
        }
    }
    public func fetchCountryStatistics(completionHandler: @escaping () -> Void) {
        var items = [CountryStatisticsRepresentable]()        
        NetworkService.shared.getAllCountryStatistics { (list) in
            list.forEach { (stats) in
                items.append(stats.convertToViewModel())
            }
            self.dataSource?.data.value = []
            self.dataSource?.data.value = items
            
            completionHandler()
        }
    }
    
}
