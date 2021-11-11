//
//  Group.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

struct Group: Decodable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
//    let type: TypeGroup
//    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
//        case type
//        case isAdmin = "is_admin"
//        case isMember = "is_member"
//        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

//enum TypeGroup: String, Decodable {
//    case event = "event"
//    case group = "group"
//    case page = "page"
//}

//struct Group {
//    let name: String
//    let image: UIImage
//
//
//    static func takeGroupe(count: Int) -> [Group] {
//        var groupes: [Group] = []
//
//        for _ in 0...count {
//            groupes.append(
//                Group(
//                    name: Lorem.words(1...3),
//                    image: UIImage(named: String(Int.random(in: 1...6)))!
//                )
//            )
//        }
//
//        return groupes
//    }
//
//}
