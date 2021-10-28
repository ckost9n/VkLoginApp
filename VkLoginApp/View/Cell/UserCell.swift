//
//  UserCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageUser: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageUser.layer.cornerRadius = imageUser.bounds.width / 2
    }

}
