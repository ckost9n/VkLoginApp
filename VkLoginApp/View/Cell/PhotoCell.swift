//
//  PhotoCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet var imageUser: UIImageView!
    
    
 
    func configure(photo: Photo) {
        
        let stringPhoto = photo.sizes
        let photoSize = stringPhoto.sorted { $0.height > $1.height }
        
        guard let photo = photoSize.first?.url else { return }
        
        if let url = URL(string: photo) {
            imageUser.kf.setImage(with: url)
        }
    }
    
}
