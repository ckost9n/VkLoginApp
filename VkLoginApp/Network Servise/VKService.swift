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
        case photos(id: String)
        case group
        case groupSearch(text: String)
        case newsFeed
        
        var path: String {
            switch self {
            case .friends:
                return "friends.get"
            case .photos:
                return "photos.getAll"
            case .group:
                return "groups.get"
            case .groupSearch:
                return "groups.search"
            case .newsFeed:
                return "newsfeed.get"
            }
        }
        
        
    }
    
    func getData(_ method: VKMethod, groupSearch: String = "", complition: @escaping (Data?) -> Void) {
        
        let urlPath = "https://api.vk.com/method/" + method.path
        var parameters: Parameters = [
            "access_token": session.token,
            "v": "5.81"
        ]
        
        switch method {
        case .friends:
            parameters["fields"] = "nickname,photo_50"
        case let .photos(id):
            parameters["owner_id"] = id
        case .group:
            parameters["extended"] = "1"
        case let .groupSearch(text):
            parameters["q"] = text
        case .newsFeed:
            parameters["filters"] = "post"
        }
        
//        print(urlPath)
//        print(session.token)
        
        AF.request(urlPath, parameters: parameters).responseData { (response) in
            if let data = response.value {
                complition(data)
            }
            
        }
        
    }
    
    func getFriends(complition: @escaping ([Friend]) -> Void) {
        getData(.friends) { (data) in
            guard let data = data else {
                complition([])
                return
            }
            do {
                let response = try JSONDecoder().decode(VKResponse<Friend>.self, from: data).items
                complition(response)
            } catch {
                print(error.localizedDescription)
                complition([])
            }
            
        }
    }
    
    func getPhoto(id: String, complition: @escaping ([Photo]) -> Void) {
        getData(.photos(id: id)) { (data) in
            guard let data = data else {
                complition([])
                return
            }
            do {
                let response = try JSONDecoder().decode(VKResponse<Photo>.self, from: data).items
                complition(response)
            } catch {
                print(error.localizedDescription)
                complition([])
            }
            
        }
    }
    
    func getGroup(complition: @escaping ([Group]) -> Void) {
        getData(.group) { (data) in
            guard let data = data else {
                complition([])
                return
            }
            do {
                let response = try JSONDecoder().decode(VKResponse<Group>.self, from: data).items
                complition(response)
            } catch {
                print(error.localizedDescription)
                complition([])
            }
            
        }
    }
    
    func getAllGroup(searchGroup: String, complition: @escaping ([Group]) -> Void) {
        getData(.groupSearch(text: searchGroup)) { (data) in
            guard let data = data else {
                complition([])
                return
            }
            do {
                let response = try JSONDecoder().decode(VKResponse<Group>.self, from: data).items
                complition(response)
            } catch {
                print(error.localizedDescription)
                complition([])
            }
            
        }
    }
    
    func getNews(complition: @escaping (NewsResponse) -> Void) {
        getData(.newsFeed) { (data) in
            guard let data = data else {
                print("Error! Данные не получены")
                return
            }
            do {
                let response = try JSONDecoder().decode(NewsItem.self, from: data).response
                complition(response)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
  
}
