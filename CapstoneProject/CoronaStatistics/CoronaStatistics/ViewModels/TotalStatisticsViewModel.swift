//
//  TotalStatisticsViewModel.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 20/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

// MARK: - TotalStatisticsViewModel
struct TotalStatisticsViewModel {
    
    private let data: TotalStatistics
    
    init(data: TotalStatistics) {
        self.data = data
    }
    
    var confirmed: Int {
        return data.confirmed ?? 0
    }
    
    var deaths: Int {
        return data.deaths ?? 0
    }
    
    var critical: Int {
        return data.critical ?? 0
    }
    
    var recovered: Int {
        return data.recovered ?? 0
    }

    var fatalityRate: Double {
        return (100.00 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveredRate: Double {
        return (100.00 * Double(recovered)) / Double(confirmed)
    }
}

