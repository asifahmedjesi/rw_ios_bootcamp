//
//  TextPostViewModel.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class TextPostViewModel: MediaPostRepresentable {
    
    private let post: TextPost
    
    public init(post: TextPost) {
        self.post = post
    }
    
    var textBody: String {
        get { post.textBody ?? "" }
    }
    var userName: String {
        post.userName
    }
    var timestamp: String {
        DateHandler.getString(date: post.timestamp, dateFormat: DateHandler.FormatString.DD_MMM_YYYY_HH_mm)
    }
    
    var rowHeight: CGFloat {
        TextPostCell.heightForCell
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextPostCell.identifier, for: indexPath) as! TextPostCell
        cell.selectionStyle = .none
        self.configure(for: cell)
        return cell
    }
}

extension TextPostViewModel {
    
    public func configure(for cell: TextPostCell) {
        cell.titleLabel.text = self.userName
        cell.bodytextLabel.text = self.textBody
        cell.postedOnLabel.text = self.timestamp
    }

}

