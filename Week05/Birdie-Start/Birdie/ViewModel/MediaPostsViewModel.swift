//
//  MediaPostListViewModel.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class MediaPostsViewModel: MediaPostsViewModelDelegate {
    
    weak private var dataSource: MediaPostsDataSource?
    weak var delegate: ViewControllerDelegate?
    
    public init(dataSource: MediaPostsDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchData() {
        
        var list = [MediaPostRepresentable]()
        
        MediaPostsHandler.shared.mediaPosts.forEach { (post) in
            if let item = post as? ExtendedMediaPost {
                list.append(item.convertToViewModel())
            }
        }
        
        self.dataSource?.data.value = []
        self.dataSource?.data.value = list
    }
    
    public func addPost(username: String, textbody: String) {
        let post = TextPost(textBody: textbody, userName: username, timestamp: Date())
        MediaPostsHandler.shared.addTextPost(textPost: post)
        delegate?.result(success: true)
    }
    
    public func addPost(username: String, textbody: String, image: UIImage) {
        let post = ImagePost(textBody: textbody, userName: username, timestamp: Date(), image: image)
        MediaPostsHandler.shared.addImagePost(imagePost: post)
        delegate?.result(success: true)
    }
}
