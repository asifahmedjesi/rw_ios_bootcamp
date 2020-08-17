//
//  CountryStatistics.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

// MARK: - TotalStatistics
struct CountryStatistics: Codable {
    let country: String!
    let confirmed, deaths, critical, recovered: Int!
    let longitude: Double!
    let latitude: Double!
}

extension CountryStatistics {
    
    var fatalityRate: Double {
        return (100.00 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveredRate: Double {
        return (100.00 * Double(recovered)) / Double(confirmed)
    }
}
