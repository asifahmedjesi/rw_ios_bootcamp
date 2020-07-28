//
//  QuestionAnswerViewModel.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 27/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

protocol QuizViewModelDelegate {
    func getClues(success: @escaping (Bool) -> Void)
    func getCorrectClue() -> ClueViewModel?
}

class QuizViewModel: QuizViewModelDelegate {
    
    weak private var dataSource: CluesDataSource?
    
    public init(dataSource: CluesDataSource) {
        self.dataSource = dataSource
    }
    
    public func getClues(success: @escaping (Bool) -> Void) {

        Networking.shared.getRandomCategory(completion: { (categoryId) in
            guard let id = categoryId else {
                success(false)
                return
            }

            Networking.shared.getAllCluesInCategory(categoryId: id) { (clues) in
                
                if clues.count == 0 {
                    success(false)
                    return
                }
                
                let list = clues.map { (clue) -> ClueRepresentable in
                    return clue.convertToViewModel()
                }
                
                self.dataSource?.data.value = []
                self.dataSource?.data.value = list
                
                success(true)
            }

        })
        
    }
    
    public func getCorrectClue() -> ClueViewModel? {
        guard let source = self.dataSource else { return nil }
        guard let clues = source.data.value as? [ClueViewModel] else { return nil }
        
        if clues.count < 4 {
            return nil
        }
        
        let correctClueIndex = Int.random(in: 0...3)
        print("Correct Answer Index: \(correctClueIndex)")
        
        return clues[correctClueIndex]
    }

}
