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
    let date: Date
    
    init(id: UUID = UUID(), weight: Double, date: Date){
        self.id = id
        self.weight = weight
        self.date = date
    }
}
