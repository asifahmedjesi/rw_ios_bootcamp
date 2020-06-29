//
//  DateHandler.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

import UIKit

class DateHandler: NSObject {
    static let shared = DateHandler()

    private static let dateFormatter = DateFormatter()

    struct FormatString {
        static let DD_MMM_YYYY_HH_MM_A = "dd MMM yyyy, hh:mm a" // 09 Jan 2020, 11:40 AM
        static let DD_MMM_YYYY_HH_MM = "dd MMM yyyy, HH:mm" // 09 Jan 2020, 21:40
    }

    static func getString(date: Date, dateFormat: String) -> String {
        self.dateFormatter.calendar = Calendar(identifier: .gregorian)
        self.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        self.dateFormatter.dateFormat = dateFormat
        let timeAsString = self.dateFormatter.string(from: date)
        return timeAsString
    }
    static func getDate(date: String, dateFormat: String) -> Date? {
        self.dateFormatter.calendar = Calendar(identifier: .gregorian)
        self.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        self.dateFormatter.dateFormat = dateFormat
        guard let timeAsDate = self.dateFormatter.date(from: date) else {
            return nil
        }
        return timeAsDate
    }
    
}
