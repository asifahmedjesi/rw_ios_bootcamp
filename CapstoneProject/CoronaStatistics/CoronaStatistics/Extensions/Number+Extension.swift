//
//  Number+Extension.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 17/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let result = numberFormatter.string(from: NSNumber(value:self)) {
            return result
        }
        return ""
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 2
        if let result = numberFormatter.string(from: NSNumber(value:self)) {
            return result
        }
        return ""
    }
    func withCommasAndMin2Digit() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        if let result = numberFormatter.string(from: NSNumber(value:self)) {
            return result
        }
        return ""
    }
}
