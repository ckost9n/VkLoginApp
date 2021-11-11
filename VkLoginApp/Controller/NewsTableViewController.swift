//
//  NewsTableViewController.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit
import Kingfisher

class NewsTableViewController: UITableViewController {
    
    var news = News.fake
    var newsFeed: NewsResponse?
    var newsFake: [NewsFake] = []
    lazy var service = VKService()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        
        service.getNews { [weak self] (newsRespons) in
            
            self?.newsFake = self?.parseDate(newsRespons) ?? []
            self?.tableView.reloadData()
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFake.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        cell.configureFake(model: newsFake[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? NewsCell else { return }
        cell.setCollectionDelegate(self, for: indexPath.row)
    }
    
}


// MARK: - Collection view data source

enum Constants {
    static let maxPhotos = 4
}

extension NewsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2,
                      height: collectionView.bounds.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let imagesCount = newsFake[collectionView.tag].images.count
        return imagesCount > Constants.maxPhotos ? Constants.maxPhotos : imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! PhotoCollectionCell
        
        let newsModel = newsFake[collectionView.tag]
        let image = newsFake[collectionView.tag].images[indexPath.row]
        
        cell.configure(newsModel, image, indexPath: indexPath)
        
        return cell
    }
    
}

// MARK: - Parse Data

extension NewsTableViewController {
    func parseDate(_ newsFeed: NewsResponse) -> [NewsFake] {
        var newsArray: [NewsFake] = []
        
        let news = newsFeed.news
        let groups = newsFeed.groups
        let users = newsFeed.profiles
        
        for item in news {
            
            var sourceIdStr = String(item.sourceID)
            
            if sourceIdStr.first != "-" {
                for userNew in users {
                    if userNew.id == item.sourceID {
                        
                        var images: [String] = []
                        if let attachments = item.attachments {
                            for itemAttachment in attachments {
                                guard let stringPhoto = itemAttachment.photo?.sizes else { continue }
                                let photoSize = stringPhoto.sorted { $0.height > $1.height }
                                
                                guard let imageUrl = photoSize.first?.url else { continue }
                                images.append(imageUrl)
                            }
                        }
                        
                        let isLike = item.likes?.userLikes == 0 ? false : true
                        
                        newsArray.append(NewsFake(
                            autor: userNew.fullName,
                            avatar: userNew.photo50,
                            postDate: String(item.date),
                            text: item.text ?? "",
                            likeCount: item.likes?.count ?? 0,
                            isLike: isLike,
                            images: images)
                        )
                        break
                    }
                }
                
            } else {
                sourceIdStr.removeFirst()
                let sourceId = Int(sourceIdStr)
                for groupNew in groups {
                    if groupNew.id == sourceId {
                        
                        var images: [String] = []
                        if let attachments = item.attachments {
                            for photo in attachments {
                                
                                guard let stringPhoto = photo.photo?.sizes else { continue }
                                let photoSize = stringPhoto.sorted { $0.height > $1.height }
                                
                                guard let imageUrl = photoSize.first?.url else { continue }
                                images.append(imageUrl)
                            }
                        }
                        
                        let isLike = item.likes?.userLikes == 0 ? false : true
                        
                        newsArray.append(NewsFake(
                            autor: groupNew.name,
                            avatar: groupNew.photo50,
                            postDate: String(item.date),
                            text: item.text ?? "",
                            likeCount: item.likes?.count ?? 0,
                            isLike: isLike,
                            images: images)
                        )
                        break
                    }
                }
            }
            
        }
  
        return newsArray
    }
    
}

