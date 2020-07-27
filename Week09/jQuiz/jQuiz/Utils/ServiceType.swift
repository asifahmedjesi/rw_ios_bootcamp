//
//  ServiceType.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

enum ServiceType: String {
    case
        random = "/api/random",
        clues = "/api/clues"
        
    func path() -> String {
        return "\(AppConstants.BASE_URL)\(self.rawValue)"
    }
}
