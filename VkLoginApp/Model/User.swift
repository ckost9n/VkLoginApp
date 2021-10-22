//
//  User.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

struct User {
    let name: String
    let lastName: String
    var likeCount: Int
    var isLike: Bool
    let image: [UIImage]
    var fullName: String {
        return self.lastName + " " + self.name
    }
    
    static func takeUser(count: Int) -> [User] {
        var users: [User] = []
        
        for _ in 0...count {
            users.append(
                User(
                    name: Lorem.firstName,
                    lastName: Lorem.lastName,
                    likeCount: Int.random(in: 1...9999999),
                    isLike: false,
                    image: (1...Int.random(in: 1...10))
                        .map { $0 % 5 }
                        .shuffled()
                        .compactMap({ String($0) })
                        .compactMap({ UIImage(named: $0) })
                )
            )
        }
        
        return users
    }
    
}
