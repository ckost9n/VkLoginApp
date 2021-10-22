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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTaped))
        imageUser.isUserInteractionEnabled = true
        imageUser.addGestureRecognizer(tap)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageUser.layer.cornerRadius = imageUser.bounds.width / 2
    }
    
    @objc func imageTaped(_ recognizer: UITapGestureRecognizer) {
        
        self.imageUser.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
  
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: []) {
            self.imageUser.transform = .identity
        } completion: { _ in
            
        }

    }

}
