//
//  NetworkingService.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {

    static let shared = Networking()
    
    private init() {
        
    }
    
    func getRandomCategory(completion: @escaping (_ categoryId: Int?) -> Void) {
        
        guard let url = UrlBuilder.shared.buildRandomUrl() else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(nil)
                fatalError()
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode), let data = data else {
                completion(nil)
                fatalError()
            }
            
            let decoder = JSONDecoder()
            guard let clues = try? decoder.decode([Clue].self, from: data) else {
                completion(nil)
                return
            }
            
            if let first = clues.first {
                completion(first.categoryID ?? 0)
            }
            else {
                completion(nil)
            }
            
        }.resume()
    }
    
    func getAllCluesInCategory(categoryId: Int, completion: @escaping (_ clues: [Clue]) -> Void) {
        
        guard let url = UrlBuilder.shared.buildCluesUrl(category: categoryId) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion([])
                fatalError()
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode), let data = data else {
                completion([])
                fatalError()
            }
            
            let decoder = JSONDecoder()
            guard let clues = try? decoder.decode([Clue].self, from: data) else {
                completion([])
                return
            }
            
            let cluesWithQuestionAndAnswer = clues.filter { (clue) -> Bool in
                guard var ques = clue.question, var ans = clue.answer else { return false }
                ques = ques.trimmingCharacters(in: .whitespacesAndNewlines)
                ans = ans.trimmingCharacters(in: .whitespacesAndNewlines)
                return !ques.isEmpty && !ans.isEmpty
            }
            var questions = [Clue]()
            var indexes = [Int]()
            
            if cluesWithQuestionAndAnswer.count < 4 {
                completion([])
                return
            }
            
            for _ in 1...4 {
                var index = Int.random(in: 0..<cluesWithQuestionAndAnswer.count)
                while indexes.contains(index) {
                    index = Int.random(in: 0..<cluesWithQuestionAndAnswer.count)
                }
                indexes.append(index)
            }
            
            for index in indexes {
                if index < cluesWithQuestionAndAnswer.count {
                    questions.append(cluesWithQuestionAndAnswer[index])
                }
            }
            
            if questions.count < 4 {
                completion([])
                return
            }
            
            completion(questions)
            
        }.resume()
    }

}
