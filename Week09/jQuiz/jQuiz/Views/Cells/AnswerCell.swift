//
//  AnswerCell.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 26/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class AnswerCell: BaseTableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
    static var heightForCell: CGFloat {
        UITableView.automaticDimension
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetUI()
    }
    
    func resetUI() {
        answerLabel.text = nil
    }
    
}
