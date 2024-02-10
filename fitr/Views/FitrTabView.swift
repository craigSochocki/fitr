//
//  FitrTabView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct FitrTabView: View {
    var body: some View {
        TabView {
            TrainingView()
                .tabItem{
                    Image(systemName: "calendar")
                    Text("Training")
                }
            ProgressView()
                .tabItem{
                    Image(systemName: "chart.xyaxis.line")
                    Text("Progress")
                }
            ProfileView(profile: MockData.sampleProfile)
                .tabItem{
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    FitrTabView()
}
