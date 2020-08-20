//
//  DynamicCountryStatisticsRepresentable.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 20/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

class DynamicCountryStatisticsRepresentable {
    
    var value : [CountryStatisticsRepresentable] {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: [CountryStatisticsRepresentable]) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addObserverAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}
