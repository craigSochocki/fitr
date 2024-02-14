//
//  FitrTabView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct FitrTabView: View {
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    // Init other view models here
    @StateObject var userProfileViewModel = UserProfileViewModel()
    @StateObject var weightTrackingViewModel = WeightTrackingViewModel()
    
    
    var body: some View {
        TabView {
            TrainingView()
                .tabItem{
                    Image(systemName: "calendar")
                    Text("Training")
                }
            //                ProgressView()
            //                    .tabItem{
            //                        Image(systemName: "chart.xyaxis.line")
            //                        Text("Progress")
            //                    }
            
            // Profile and weight tracking only available when user is logged in
            if userAuthViewModel.isLoggedIn {
                ProfileView(viewModel: userProfileViewModel)
                    .tabItem{
                        Image(systemName: "person")
                        Text("Profile")
                    }
                
                WeightTrackerView(viewModel: weightTrackingViewModel)
                    .tabItem {
                        Image(systemName: "chart.xyaxis.line")
                        Text("Progress")
                    }
            }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    FitrTabView()
}
