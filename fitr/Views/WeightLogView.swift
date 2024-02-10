//
//  ContentView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightLogView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: WeightEntriesViewModel
    @State private var selectedWeight: Int = 150
    @State private var  selectedDate: Date = Date()
    let weightRange: [Int] = Array(100...500)
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter your current weight:")) {
                    Picker("Weight (lbs)", selection: $selectedWeight) {
                        ForEach(weightRange, id: \.self) { weight in
                            Text("\(weight) lbs").tag(weight)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                }
                Section {
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                Button("Log") {
                    submitWeight()
                }
            }
            .navigationTitle("Weight Logger")
            .onAppear {
                if let latestWeight = viewModel.entries.last?.weight {
                    selectedWeight = Int(latestWeight)
                }
            }
            .alert("Confirm Weight", isPresented: $showingConfirmationAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Yes", role: .destructive) {
                    confirmAndLogWeight()
                }
            } message: {
                Text("The weight you entered (\(selectedWeight) lbs) seems outside the typical range.  Are you sure this is correct?")
            }
        }
    }
    
    private func submitWeight() {
        if selectedWeight < 100 || selectedWeight > 500 {
            showingConfirmationAlert = true
        } else {
            logWeight(Double(selectedWeight))
        }
    }
    
    private func confirmAndLogWeight() {
        logWeight(Double(selectedWeight))
    }
    
    private func logWeight(_ weight: Double) {
        viewModel.addEntry(weight: weight, date: selectedDate)
        presentationMode.wrappedValue.dismiss()
    }
}
