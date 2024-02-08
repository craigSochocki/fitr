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
            List(entries, id: \.timestamp) {
                entry in
                VStack(alignment: .leading) {
                    Text("\(entry.weight, specifier: "%.0f") lbs")
                    Text("Logged on \(entry.timestamp, formatter: dateFormatter)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            .navigationTitle("Weight Tracker")
            //            .navigationBarItems(trailing: Button(action: clearWeightHistory){
            //                Image(systemName: "trash")
            //            })
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
