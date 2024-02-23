//
//  WeightTrackingViewModel.swift
//  fitr
//
//  Created by Craig Sochocki on 2/13/24.
//

import Foundation

class WeightTrackingViewModel: ObservableObject {
    @Published var weightEntries: [WeightEntry] = []
    
    // Methods for adding, fetching, and managing weight entries here
    
    init() {
        loadWeightEntries()
    }
    
    func addEntry(weight: Double, date: Date = Date()) {
        let newEntry = WeightEntry(weight: weight, date: date)
        weightEntries.append(newEntry)
        saveWeightEntries()
    }
    
    func saveWeightEntries() {
        if let data = try? JSONEncoder().encode(weightEntries) {
            UserDefaults.standard.set(data, forKey: "weightEntries")
        }
    }
    
    func loadWeightEntries() {
        // pass
        if let data = UserDefaults.standard.data(forKey: "weightEntries"),
           let savedEntries = try? JSONDecoder().decode([WeightEntry].self, from: data) {
            weightEntries = savedEntries
        }
    }
    
    func clearEntries() {
        weightEntries.removeAll()
        saveWeightEntries()
    }
    
}
