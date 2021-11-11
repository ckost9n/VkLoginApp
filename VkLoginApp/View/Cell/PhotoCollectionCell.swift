//
//  PhotoCollectionCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit
import Kingfisher

class PhotoCollectionCell: UICollectionViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var countLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.isHidden = true
    }
    
    func configure(_ model: NewsFake, _ imageStr: String, indexPath: IndexPath) {
        
        if let url = URL(string: imageStr) {
            photoImageView.kf.setImage(with: url)
        }
        
        if indexPath.row == Constants.maxPhotos - 1 {
            let count = (model.images.count) - Constants.maxPhotos
            countLabel.text = "+\(count)"
            containerView.isHidden = count == 0
        }
    }

}
