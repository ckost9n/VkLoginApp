//
//  UserCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageUser: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageUser.layer.cornerRadius = imageUser.bounds.width / 2
    }
    
    func configure(friend: Friend) {
        nameLabel.text = friend.fullName
        
        if let url = URL(string: friend.photo50) {
            imageUser.kf.setImage(with: url)
        }
        
    }

}
