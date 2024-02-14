//
//  Profile.swift
//  fitr5
//
//  Created by Craig Sochocki on 1/20/24.
//

import Foundation

struct Profile: Codable, Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let weight: Int
    let profilePicURL: String?
    
    init(id: UUID = UUID(), name: String, age: Int, weight: Int, profilePicURL: String?) {
        self.id = id
        self.name = name
        self.age = age
        self.weight = weight
        self.profilePicURL = profilePicURL
    }
}
