//
//  Clue.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// MARK: - Clue
struct Clue: Codable {
    let id: Int!
    let answer, question: String!
    let value: Int!
    let airdate, createdAt, updatedAt: String!
    let categoryID, gameID, invalidCount: Int!
    let category: Category!

    enum CodingKeys: String, CodingKey {
        case id, answer, question, value, airdate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryID = "category_id"
        case gameID = "game_id"
        case invalidCount = "invalid_count"
        case category
    }
}
