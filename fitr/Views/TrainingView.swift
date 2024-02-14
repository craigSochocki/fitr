//
//  TrainingView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct TrainingView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LogWorkoutView()) {
                    Text("Log Workout")
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }
            }.navigationTitle("Training")
        }
    }
}

#Preview {
    TrainingView()
}
