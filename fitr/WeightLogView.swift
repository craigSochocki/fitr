//
//  ContentView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightLogView: View {
    
    @State private var weight: String = ""
    @FocusState private var isInputActive: Bool
    @State private var showingConfirmationAlert = false
    @State private var weightToConfirm: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter your current weight:")) {
                    TextField("Weight (lbs)", text: $weight)
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Log") {
                                    submitWeight()
                                }
                            }
                        }
                }
                Section {
                    NavigationLink(destination: WeightTrackerView()) {
                        Text("View Weight Tracker")
                    }
                }
            }
            .navigationTitle("Weight Logger")
            .alert("Confirm Weight", isPresented: $showingConfirmationAlert) {
                Button("Cancel", role: .cancel) {
                    weightToConfirm = ""
                    weight = ""
                }
                Button("Yes", role: .destructive) {
                    confirmAndSaveWeight()
                }
            } message: {
                Text("The weight you entered (\(weightToConfirm) lbs) seems outside the typical range.  Are you sure this is correct?")
            }
        }
    }
    
    private func submitWeight() {
        guard !weight.trimmingCharacters(in: .whitespaces).isEmpty, let weightValue = Double(weight) else {
            // Weight is blank or not a number, don't log
            return
        }
        
        guard weightValue >= 100, weightValue <= 500 else {
            weightToConfirm = weight
            showingConfirmationAlert = true
            return
        }
        
        logAndClearWeight()
        isInputActive = false
    }
    
    private func logAndClearWeight() {
        guard let weightValue = Double(weight) else { return }
        
        let newEntry = WeightEntry(weight: weightValue, timestamp: Date())
        
        var entries: [WeightEntry] = []
        
        if let entriesData = UserDefaults.standard.data(forKey: "weightEntries"),
           let decodedEntries = try? JSONDecoder().decode([WeightEntry].self, from: entriesData) {
            entries = decodedEntries
        }
        entries.append(newEntry)
        
        if let encodedEntries = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encodedEntries, forKey: "weightEntries")
        }
                
        weight = ""
        weightToConfirm = ""
    }
    
    private func confirmAndSaveWeight() {
        logAndClearWeight()
        isInputActive = false
    }
}

#Preview {
    WeightLogView()
}
