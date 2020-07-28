//
//  DynamicClueRepresentable.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 28/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

class DynamicClueRepresentable {
    
    var value : [ClueRepresentable] {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: [ClueRepresentable]) {
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
