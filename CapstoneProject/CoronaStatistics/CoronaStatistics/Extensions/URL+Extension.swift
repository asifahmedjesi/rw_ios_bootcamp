//
//  URL+Extension.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

extension URL {

    private static func build(type: ServiceType) -> URL? {
        return URL(string: type.path())
    }
    private static func build(type: ServiceType, parameters: [String:Any]) -> URL? {
        let parameterArrays = parameters.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        return URL(string: "\(type.path())?\(parameterArrays.joined(separator: ", "))")
    }

    static func buildTotalsUrl() -> URL? {
        return build(type: .totals, parameters: ["format": "json"])
    }
    static func buildCountryAllUrl() -> URL? {
        return build(type: .countryAll, parameters: ["format": "json"])
    }
}
