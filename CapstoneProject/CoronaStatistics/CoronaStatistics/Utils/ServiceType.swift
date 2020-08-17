//
//  ServiceType.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

enum ServiceType: String {
    case
        totals = "/totals?format=json",
        countryAll = "/country/all?format=json"
        
    func path() -> String {
        return "\(AppConstants.BASE_URL)\(self.rawValue)"
    }
}
