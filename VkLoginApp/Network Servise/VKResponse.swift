//
//  VKResponse.swift
//  VkLoginApp
//
//  Created by Konstantin on 06.11.2021.
//

import UIKit

struct VKResponse<T: Decodable>: Decodable {
    let count: Int
    let items: [T]
    
    // MARK: - Enum Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case response
        case count
        case items
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let topContener = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContener.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)

        self.count = try container.decode(Int.self, forKey: .count)
        self.items = try container.decode([T].self, forKey: .items)
    }
    
}


