//
//  User.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

// MARK: - Welcome
class UserNew: Codable {
    let response: Response
}

// MARK: - Response
class Response: Codable {
    let count: Int
    let friends: [Friend]
    
    enum CodingKeys: String, CodingKey {
        case count
        case friends = "items"
    }
}

// MARK: - Item
class Friend: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo50: String
    let nickname: String?
    let trackCode: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case nickname
        case trackCode = "track_code"
        case deactivated
    }
}

struct User {
    let firstName: String
    let lastName: String
    var likeCount: Int
    var isLike: Bool
    let image: [UIImage]
    var fullName: String {
        return self.lastName + " " + self.firstName
    }
    
    static func takeUser(count: Int) -> [User] {
        var users: [User] = []
        
        for _ in 0...count {
            users.append(
                User(
                    firstName: Lorem.firstName,
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
