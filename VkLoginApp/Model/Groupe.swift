//
//  Group.swift
//  VkLoginApp
//
//  Created by Konstantin on 20.10.2021.
//

import UIKit

struct Group {
    let name: String
    let image: UIImage
    
    
    static func takeGroupe(count: Int) -> [Group] {
        var groupes: [Group] = []
        
        for _ in 0...count {
            groupes.append(
                Group(
                    name: Lorem.words(1...3),
                    image: UIImage(named: String(Int.random(in: 1...6)))!
                )
            )
        }
        
        return groupes
    }
    
}
