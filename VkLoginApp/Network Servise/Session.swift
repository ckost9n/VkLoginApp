//
//  Session.swift
//  VkLoginApp
//
//  Created by Konstantin on 27.10.2021.
//

import Foundation

class Session {
    
    static let shared = Session()
    private init() {}
    
    var token = ""
    var userId = 0
}
