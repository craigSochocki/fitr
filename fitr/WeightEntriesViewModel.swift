//
//  WeightEntriesViewModel.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import Foundation

class WeightEntriesViewModel: ObservableObject {
    @Published var entries: [WeightEntry] = []
    
    init() {
        loadEntries()
    }
    
    func addEntry(weight: Double, timestamp: Date = Date()) {
        let newEntry = WeightEntry(weight: weight, timestamp: timestamp)
        entries.append(newEntry)
        saveEntries()
    }
    
    func clearEntries() {
        entries.removeAll() // clear array of entries
        UserDefaults.standard.removeObject(forKey: "weightEntries")
    }
    
    private func loadEntries() {
        if let entriesData = UserDefaults.standard.data(forKey: "weightEntries"),
           let decodedEntries = try? JSONDecoder().decode([WeightEntry].self, from: entriesData) {
            self.entries = decodedEntries.sorted(by: { $0.timestamp > $1.timestamp })
        }
    }
    
    private func saveEntries() {
        if let encodedEntries = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encodedEntries, forKey: "weightEntries")
        }
    }
}

struct WeightEntry: Codable, Identifiable {
    var id = UUID()
    let weight: Double
    let timestamp: Date
}
