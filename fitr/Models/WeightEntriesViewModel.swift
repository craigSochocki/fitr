//
//  WeightEntriesViewModel.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import Foundation

class WeightEntriesViewModel_DEPRECATED: ObservableObject {
    @Published var entries: [WeightEntry] = []
    @Published var loggedInUser: Profile?
    
    init() {
        loadUserProfile()
        loadEntries()
    }
    
    func loadUserProfile() {
        let decoder = JSONDecoder()
        if let userData = UserDefaults.standard.data(forKey: "userProfile"),
           let userProfile = try? decoder.decode(Profile.self, from: userData) {
            loggedInUser = userProfile
        }
    }
    
    func loadMockData() {
        self.loggedInUser = Profile(name: "John Doe", age: 32, weight: 315, profilePicURL: "https://example.com/profile.jpg")
    }
    
    func saveUserProfile(_ profile: Profile) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profile) {
            UserDefaults.standard.set(encoded, forKey: "userProfile")
            loggedInUser = profile
        }
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
    
    func deleteAllUsers() {
        UserDefaults.standard.removeObject(forKey: "userProfile")
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


