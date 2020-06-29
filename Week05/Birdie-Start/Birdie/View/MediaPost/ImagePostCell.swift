//
//  ImagePostCell.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postedOnLabel: UILabel!
    @IBOutlet weak var bodytextLabel: UILabel!
    @IBOutlet weak var bodyImage: UIImageView!
    
    static var heightForCell: CGFloat {
        UITableView.automaticDimension
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        resetUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetUI()
    }
    
    func resetUI() {
        titleLabel.text = nil
        postedOnLabel.text = nil
        bodytextLabel.text = nil
        bodyImage.image = nil
    }
    
}
