//
//  AnswerViewModel.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 27/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class ClueViewModel: ClueRepresentable {
    
    let clue: Clue
    
    public init(clue: Clue) {
        self.clue = clue
    }
    
    var question: String {
        get { clue.question ?? "" }
    }
    
    var category: String {
        get { clue.category?.title ?? "" }
    }
    
    var answer: String {
        get { clue.answer ?? "" }
    }
    
    var point: Int {
        get { clue.value ?? 0 }
    }
    
    var rowHeight: CGFloat {
        AnswerCell.heightForCell
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as! AnswerCell
        cell.selectionStyle = .none
        self.configure(for: cell)
        return cell
    }
}

extension ClueViewModel {
    public func configure(for cell: AnswerCell) {
        cell.answerLabel.attributedText = self.answer.htmlAttributedString()
        cell.container.layer.cornerRadius = 5
    }
}

extension Clue {
    func convertToViewModel() -> ClueRepresentable {
        return ClueViewModel(clue: self)
    }
}
