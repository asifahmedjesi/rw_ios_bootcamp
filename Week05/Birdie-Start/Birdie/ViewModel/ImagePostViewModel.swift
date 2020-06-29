//
//  ImagePostViewModel.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostViewModel: MediaPostRepresentable {
    
    private let post: ImagePost
    
    public init(post: ImagePost) {
        self.post = post
    }
    
    var textBody: String {
        post.textBody ?? ""
    }
    var userName: String {
        post.userName
    }
    var timestamp: String {
        DateHelper.getString(date: post.timestamp, dateFormat: DateHelper.FormatString.DD_MMM_YYYY_HH_MM_A)
    }
    var image: UIImage {
        post.image
    }
    
    var rowHeight: CGFloat {
        ImagePostCell.heightForCell
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagePostCell.identifier, for: indexPath) as! ImagePostCell
        cell.selectionStyle = .none
        self.configure(for: cell)
        return cell
    }
}

extension ImagePostViewModel {
    
    public func configure(for cell: ImagePostCell) {
        cell.titleLabel.text = self.userName
        cell.bodytextLabel.text = self.textBody
        cell.postedOnLabel.text = self.timestamp
        cell.bodyImage.image = self.image
    }
}

extension ImagePost: ExtendedMediaPost {
    
    func convertToViewModel() -> MediaPostRepresentable {
        return ImagePostViewModel(post: self)
    }
}
