//
//  News.swift
//  VkLoginApp
//
//  Created by Konstantin on 22.10.2021.
//

import UIKit

// MARK: - Welcome
struct NewsItem: Decodable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Decodable {
    let news: [NewsFeed]
    let profiles: [Friend]
    let groups: [Group]
    //    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case news = "items"
        case profiles, groups
        //        case nextFrom = "next_from"
    }
}

struct NewsFeed: Decodable {
    let sourceID, date: Int
    let postType: PostTypeEnum?
    let text: String?
    let attachments: [ItemAttachment]?
    let likes: PurpleLikes?
    let reposts: Reposts?
    let views: Views?
    let postID: Int
    let type: PostTypeEnum
//    let photos: Photos?
    let topicID, signerID: Int?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
        case likes, reposts, views
        case postID = "post_id"
        case type
        case topicID = "topic_id"
        case signerID = "signer_id"
    }
}

struct ItemAttachment: Decodable {
    let type: AttachmentType
    let photo: Photo?
//    let video: Video?
    let link: Link?
//    let poll: Poll?
}

struct Link: Decodable {
    let url: String
    let title, linkDescription: String
    let target, caption: String?
    let photo: Photo?

    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target, caption, photo
    }
}

enum AttachmentType: String, Decodable {
    case link = "link"
    case photo = "photo"
//    case poll = "poll"
    case video = "video"
}

enum PostTypeEnum: String, Decodable {
    case friend = "friend"
    case post = "post"
    case wallPhoto = "wall_photo"
}

class Photos: Decodable {
    let count: Int
    let items: [Photo]
}

struct Views: Decodable {
    let count: Int
}

struct PurpleLikes: Decodable {
    let canLike, count, userLikes, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

struct Reposts: Decodable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}


// MARK: - WelcomeElement
struct PostsElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
typealias Post = [PostsElement]

struct News {
    var autor: String
    var postDate: String
    var text: String
    var likeCount: Int
    var isLike: Bool
    var images: [UIImage]
    
    static let fake: [News] = (1...5).map { _ in
        News(
            autor: Lorem.fullName,
             postDate: "22.10.2021",
            text: Lorem.sentences(2...5),
            likeCount: Int.random(in: 1...9999999),
            isLike: false,
            images: (1...Int.random(in: 1...10))
                .map { $0 % 5 }
                .shuffled()
                .compactMap({ String($0) })
                .compactMap({ UIImage(named: $0) })
        )
    }
}

struct NewsFake {
    
    var autor: String
    var avatar: String
    var postDate: String
    var text: String
    var likeCount: Int
    var isLike: Bool
    var images: [String]
    
    
}
