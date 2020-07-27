//
//  Category.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let id: Int!
    let title, createdAt, updatedAt: String!
    let cluesCount: Int!

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cluesCount = "clues_count"
    }
}
