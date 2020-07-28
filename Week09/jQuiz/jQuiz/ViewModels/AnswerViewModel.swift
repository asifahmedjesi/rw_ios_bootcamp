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
    
    private let clue: Clue
    
    public init(clue: Clue) {
        self.clue = clue
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
        cell.answerLabel.text = self.answer
    }
}

extension Clue {
    func convertToViewModel() -> ClueRepresentable {
        return ClueViewModel(clue: self)
    }
}
