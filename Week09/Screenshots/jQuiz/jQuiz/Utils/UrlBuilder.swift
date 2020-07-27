//
//  UrlBuilder.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class UrlBuilder {
    
    static let shared = UrlBuilder()
    
    private init() {
        
    }
    
    private func build(type: ServiceType) -> URL? {
        return URL(string: type.path())
    }
    private func build(type: ServiceType, parameters: [String:Any]) -> URL? {
        let parameterArrays = parameters.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        return URL(string: "\(type.path())?\(parameterArrays.joined(separator: ", "))")
    }
    
    func buildRandomUrl() -> URL? {
        return build(type: .random)
    }
    func buildCluesUrl(category: Int) -> URL? {
        return build(type: .clues, parameters: ["category": category])
    }
}
