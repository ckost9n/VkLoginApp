//
//  PhotoCollectionCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var countLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.isHidden = true
    }

}
