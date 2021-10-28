//
//  VKService.swift
//  VkLoginApp
//
//  Created by Konstantin on 28.10.2021.
//

import Foundation
import Alamofire

class VKService {
    
    enum vkMethods {
        case friends
        case photos
        case group
        case groupSearch
    }
    
    static let shared = VKService()
    private init() {}
    
    let baseURL = "https://api.vk.com/method/users.get?user_id=210700286&v=5.52"
    
    func getData(token: String, method: vkMethods, groupSearch: String? = nil) {
        
        var vkMethod = ""
        
        switch method {
        case .friends:
            vkMethod = "friends.get"
        case .photos:
            vkMethod = "photos.getAll"
        case .group:
            vkMethod = "groups.get"
        case .groupSearch:
            vkMethod = "groups.search"
        }
        
    }
    
    
}
