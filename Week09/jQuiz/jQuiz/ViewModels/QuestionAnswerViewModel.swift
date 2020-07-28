//
//  QuestionAnswerViewModel.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 27/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class QuizViewModel {
    
    weak private var dataSource: CluesDataSource?
    
    public init(dataSource: CluesDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchData() {
        
        var list = [ClueRepresentable]()
        
        /*
        MediaPostsHandler.shared.mediaPosts.forEach { (post) in
            if let item = post as? ExtendedMediaPost {
                list.append(item.convertToViewModel())
            }
        }
        */
        
        self.dataSource?.data.value = []
        self.dataSource?.data.value = list
    }

}
