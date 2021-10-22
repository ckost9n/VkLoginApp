//
//  NewsCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var isLike = false

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var autorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var newsText: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var likeButton: UIButton! {
        didSet {
            likeButton.tintColor = .red
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.cornerRadius = mainImageView.bounds.width / 2
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        guard likeCount.text != nil else { return }
        
        if isLike {
            self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        likeCount.text = !isLike ? String(Int(likeCount.text!)! + 1) :
        String(Int(likeCount.text!)! - 1)
        
        isLike.toggle()
        
        sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
  
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: []) {
            sender.transform = .identity
        } completion: { _ in
            
        }
    }
    
    func configure(model: News) {
        mainImageView.image = model.images.first
        autorLabel.text = model.autor
        dateLabel.text = model.postDate
        newsText.text = model.text
        likeCount.text = String(model.likeCount)
        
        collectionView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "photoCollectionCell")
    }
    
    func setCollectionDelegate(_ delegate: UICollectionViewDelegate & UICollectionViewDataSource, for row: Int) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = row
        collectionView.reloadData()
    }

    
}
