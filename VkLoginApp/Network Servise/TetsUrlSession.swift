//
//  TetsUrlSession.swift
//  VkLoginApp
//
//  Created by Konstantin on 28.10.2021.
//

import Foundation
import Alamofire

class TestUrlSession {
    
    static let shared = TestUrlSession()
    private init() {}
    
    func getWeatherWithURLSession() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=a25139c3d1bdde3e3e37cf43625632cc")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json ?? "No json")
            }
        }.resume()
        
    }
    
    func getWeatherWithURLSessionComponents() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = [
            URLQueryItem(name: "q", value: "Moscow"),
            URLQueryItem(name: "appid", value: "a25139c3d1bdde3e3e37cf43625632cc")
        ]
        
        guard let url = components.url else { return }
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json ?? "No json")
            }
        }.resume()
    }
    
    func postJSONPlaceholderRequest() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = "/posts"
        components.queryItems = [
            URLQueryItem(name: "title", value: "Hello"),
            URLQueryItem(name: "body", value: "Hello world!!!"),
            URLQueryItem(name: "userId", value: "123")
        ]
        
        guard let url = components.url else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json ?? "No json")
            }
        }.resume()
    }
    
    func getWeatherAlamofire() {
        let urlPath = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=a25139c3d1bdde3e3e37cf43625632cc"
        
        AF.request(urlPath).responseJSON { response in
            print(response.value ?? "No JSON")
//            switch response {
//            case let .success(value):
//                print(value)
//            case let .failure(error):
//                print(error)
//            }
        }
    }
    
    func getWeatherAlamofireParameters() {
        let urlPath = "https://api.openweathermap.org/data/2.5/weather"
        let patameters: Parameters = [
            "q": "Moscow",
            "appid": "a25139c3d1bdde3e3e37cf43625632cc"
        ]
        
        
        AF.request(urlPath, parameters: patameters).responseJSON { response in
            print(response.value ?? "No JSON")
            
        }
    }
    
    func postJSONPlaceholderAlamofire() {
        let urlPath = "https://jsonplaceholder.typicode.com/posts?title=Hello&body=Hello%20world!!!&userId=123"
        let patameters: Parameters = [
            "title": "Hello",
            "body": "Hello World!!!",
            "userId": 1
        ]
        
        
        AF.request(urlPath, method: .post, parameters: patameters).responseJSON { response in
            print(response.value ?? "No JSON")
            
        }
    }
    
}
