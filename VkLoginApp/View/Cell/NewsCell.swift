//
//  NewsCell.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var autorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var newsText: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    func configure(model: News) {
        mainImageView.image = model.images.first
        autorLabel.text = model.autor
        dateLabel.text = model.postDate
        newsText.text = model.text
        
        collectionView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "photoCollectionCell")
    }
    
    func setCollectionDelegate(_ delegate: UICollectionViewDelegate & UICollectionViewDataSource, for row: Int) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = row
        collectionView.reloadData()
    }

    
}
