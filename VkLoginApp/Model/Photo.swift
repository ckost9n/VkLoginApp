//
//  Photo.swift
//  VkLoginApp
//
//  Created by Konstantin on 06.11.2021.
//

import UIKit

//class PhotoResponse: Codable {
//    let photoFriends: PhotoFriends
//    
//    enum CodingKeys: String, CodingKey {
//        case photoFriends = "response"
//    }
//}
//
//// MARK: - Response
//class PhotoFriends: Codable {
//    let count: Int 
//    let photos: [Photo]
//    
//    enum CodingKeys: String, CodingKey {
//        case count
//        case photos = "items"
//    }
//}

// MARK: - Item
class Photo: Decodable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let lat, long: Double?
    let postID: Int?
    let sizes: [Size]
    let text: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case lat, long
        case postID = "post_id"
        case sizes, text
    }
}

// MARK: - Size
class Size: Decodable {
    let height: Int
    let url: String
    let type: TypeEnum
    let width: Int
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
