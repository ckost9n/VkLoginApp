//
//  VKService.swift
//  VkLoginApp
//
//  Created by Konstantin on 28.10.2021.
//

import Foundation
import Alamofire

class VKService {
    
    let session = Session.shared
    
    enum VKMethod {
        case friends
        case photos
        case group
        case groupSearch
    }
    
    func getData(_ method: VKMethod, groupSearch: String = "", complition: @escaping ([Friend]) -> Void) {
        
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
        
        let urlPath = "https://api.vk.com/method/" + vkMethod
        var parameters: Parameters = [
            "access_token": session.token,
            "v": "5.81",
            "fields": "nickname,photo_50"
        ]
        if method == .groupSearch {
            parameters["q"] = groupSearch
        }
        
//        AF.request(urlPath, parameters: parameters).responseJSON { (response) in
//            print(response.value ?? "No json")
//            do {
//                print(users.response.friends)
//            } catch {
//                print(error)
//            }
//
//        }
        
//        let request = AF.request(urlPath, parameters: parameters)
//            request.responseJSON { (data) in
//              print(data)
//            }
//
//        request.responseDecodable(of: UserNew.self) { (response) in
//          guard let friendsResponse = response.value else { return }
//            print(friendsResponse.response.friends[1].firstName)
//        }
        
        AF.request(urlPath, parameters: parameters).responseData { (response) in
            if let data = response.value {
                do {
                    let friends = try JSONDecoder().decode(UserNew.self, from: data).response.friends
                    complition(friends)
                } catch {
                    print(error)
                    complition([])
                }
            }
            
        }
        
//        AF.request(urlPath, parameters: parameters).responseDecodable(of: UserNew.self) { (response) in
//          guard let responseData = response.value else { return }
//            print(responseData.response.friends[1].firstName)
//        }

        
    }
    
    
}
