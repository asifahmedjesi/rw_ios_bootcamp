//
//  MediaListViewModelProtocol.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

protocol MediaPostsViewModelDelegate {
    func fetchData()
    func addPost(username: String, textbody: String)
    func addPost(username: String, textbody: String, image: UIImage)
}
