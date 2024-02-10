//
//  WeightEntry.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import Foundation

struct WeightEntry: Codable, Identifiable {
    var id = UUID()
    let weight: Double
    let timestamp: Date
    let userID: UUID // refers to Profile ID
    
    init(id: UUID = UUID(), weight: Double, timestamp: Date, userID: UUID){
        self.id = id
        self.weight = weight
        self.timestamp = timestamp
        self.userID = userID
    }
}
