//
//  WeightEntriesViewModel.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import Foundation

class WeightEntriesViewModel: ObservableObject {
    @Published var entries: [WeightEntry] = []
    @Published var loggedInUser: Profile?
    
    init() {
        self.loggedInUser = Profile(name: "John Doe", age: 32, weight: 245, profilePicURL: "https://example.com/profile.jpg")
        loadEntries()
    }
    
    func addEntry(weight: Double, date: Date) {
        guard let userID = loggedInUser?.id else { return }
        let newEntry = WeightEntry(weight: weight, timestamp: date, userID: userID)
        entries.append(newEntry)
        saveEntries()
    }
    
    func clearEntries() {
        entries.removeAll() // clear array of entries
        UserDefaults.standard.removeObject(forKey: "weightEntries")
    }
    
    private func loadEntries() {
        guard let entriesData = UserDefaults.standard.data(forKey: "weightEntries"),
           let decodedEntries = try? JSONDecoder().decode([WeightEntry].self, from: entriesData) else {
            // get some better logic here to handle when there are no entries
            self.entries = []
            return
        }
        
        let userEntries = decodedEntries
            .filter { $0.userID == loggedInUser?.id }
                .sorted(by: { $0.timestamp > $1.timestamp })
        
        self.entries = userEntries
    
    }
    
    private func saveEntries() {
        if let encodedEntries = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encodedEntries, forKey: "weightEntries")
        }
    }
}


