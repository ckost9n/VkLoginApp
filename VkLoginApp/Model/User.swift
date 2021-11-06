//
//  User.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

//// MARK: - Welcome
//class UserNew: Codable {
//    let response: Response
//}
//
//// MARK: - Response
//class Response: Codable {
//    let count: Int
//    let friends: [Friend]
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case friends = "items"
//    }
//}

// MARK: - Item
struct Friend: Decodable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo50: String
    let nickname: String?
    let trackCode: String
    let deactivated: String?
    
    var fullName: String {
        return self.lastName + " " + self.firstName
    }

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
    

