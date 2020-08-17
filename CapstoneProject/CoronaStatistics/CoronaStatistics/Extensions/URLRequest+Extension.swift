//
//  URLRequest+Extension.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func build(url: URL, headers: [String: String]) -> URLRequest {
        var request = URLRequest(url: url)
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
