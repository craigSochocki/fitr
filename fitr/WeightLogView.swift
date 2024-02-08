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
    @State private var weight: String = ""
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter your current weight:")) {
                    TextField("Weight (lbs)", text: $weight)
                        .keyboardType(.decimalPad)
                }
                Button("Log") {
                    submitWeight()
                }
            }
            .navigationTitle("Weight Logger")
            .alert("Confirm Weight", isPresented: $showingConfirmationAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Yes", role: .destructive) {
                    confirmAndLogWeight()
                }
            } message: {
                Text("The weight you entered (\(weight) lbs) seems outside the typical range.  Are you sure this is correct?")
            }
        }
    }
    
    private func submitWeight() {
        guard !weight.trimmingCharacters(in: .whitespaces).isEmpty,
                let weightValue = Double(weight),
              !weight.isEmpty else {
            // Weight is blank or not a number, don't log
            return
        }
        
        if weightValue < 100 || weightValue > 500 {
            showingConfirmationAlert = true
        } else {
            logWeight(weightValue)
        }
    }
    
    private func confirmAndLogWeight() {
        if let weightValue = Double(weight) {
            logWeight(weightValue)
        }
    }
    
    private func logWeight(_ weight: Double) {
        viewModel.addEntry(weight: weight)
        presentationMode.wrappedValue.dismiss()
    }
}
