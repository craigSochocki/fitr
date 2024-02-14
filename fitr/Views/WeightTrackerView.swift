//
//  WeightTrackerView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

struct WeightTrackerView: View {
    
    @ObservedObject var viewModel: WeightTrackingViewModel
    @State private var showingLogView = false
    @State private var showingClearConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.weightEntries.isEmpty {
                    // No entries have been logged
                    Text("No weights have been logged yet.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    WeightChartView(entries: viewModel.weightEntries)
                        .frame(height: 200)
                        .padding()
                }
            }
            .navigationTitle("Weight Tracker")
            .navigationBarItems(
                leading: Button("Clear All") {
                    showingClearConfirmation = true
                },
                trailing: Button(action: {
                    showingLogView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
            .alert(isPresented: $showingClearConfirmation) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("This will permanently delete all your weight entries."),
                    primaryButton: .destructive(Text("Clear All")){
                        viewModel.clearEntries()
                    },
                    secondaryButton: .cancel())
            }
            .sheet(isPresented: $showingLogView) {
                WeightLogView(viewModel: viewModel)
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    WeightTrackerView(viewModel: WeightTrackingViewModel())
}
