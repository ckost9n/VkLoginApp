//
//  News.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit

struct News {
    var autor: String
    var postDate: String
    var text: String
    var images: [UIImage]
    
    static let fake: [News] = (1...5).map { _ in
        News(
            autor: Lorem.fullName,
             postDate: "22.10.2021",
            text: Lorem.sentences(2...5),
            images: (1...Int.random(in: 1...10))
                .map { $0 % 5 }
                .shuffled()
                .compactMap({ String($0) })
                .compactMap({ UIImage(named: $0) })
        )
    }
}
