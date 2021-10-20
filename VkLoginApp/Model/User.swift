//
//  User.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

struct User {
    let name: String
    let lastName: String
    let age: Int?
    let image: UIImage
    var fullName: String {
        return self.name + " " + self.lastName
    }
    
    static func takeUser(count: Int) -> [User] {
        var users: [User] = []
        
        for _ in 0...count {
            users.append(User(name: Lorem.firstName,
                              lastName: Lorem.lastName,
                              age: Int.random(in: 18...55),
                              image: UIImage(systemName: "person.circle.fill")!))
        }
        
        return users
    }
    
}
