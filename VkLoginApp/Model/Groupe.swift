//
//  Groupe.swift
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
            groupes.append(Group(name: Lorem.words(1...3),
                                 image: UIImage(systemName: "person.2.crop.square.stack.fill")!))
        }
        
        return groupes
    }
    
}
