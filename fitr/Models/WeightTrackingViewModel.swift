//
//  WeightTrackingViewModel.swift
//  fitr
//
//  Created by Craig Sochocki on 2/13/24.
//

import Foundation

class WeightTrackingViewModel: ObservableObject {
    @Published var weightEntries: [WeightEntry] = []
    
    func clearEntries() {
        // pass
    }
    
    func addEntry(weight: Double, date: Date) {
        // pass
    }
    // Methods for adding, fetching, and managing weight entries here
    
}
