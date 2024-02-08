//
//  WeightTrackerView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightTrackerView: View {
    
    @State private var entries: [WeightEntry] = []
    
    var body: some View {
        NavigationView {
            VStack {
                WeightChartView(entries: entries)
                    .frame(height: 200)
                    .padding()
            }
            .navigationTitle("Weight Tracker")
            .onAppear {
                loadEntries()
            }
        }
    }
    
    private func loadEntries() {
        if let entriesData = UserDefaults.standard.data(forKey: "weightEntries"),
           let decodedEntries = try? JSONDecoder().decode([WeightEntry].self, from: entriesData) {
            self.entries = decodedEntries.sorted(by: {$0.timestamp > $1.timestamp})
        }
    }
    
//    private func clearWeightHistory() {
//        UserDefaults.standard.removeObject(forKey: "userWeights")
//        weights = []
//    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    WeightTrackerView()
}
