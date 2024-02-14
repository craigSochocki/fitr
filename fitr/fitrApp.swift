//
//  fitrApp.swift
//  fitr
//
//  Created by Craig Sochocki on 2/8/24.
//

import SwiftUI

@main
struct fitrApp: App {
    @StateObject private var userAuthViewModel = UserAuthViewModel()
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @StateObject private var weightTrackingViewModel = WeightTrackingViewModel()

    
    var body: some Scene {
        WindowGroup {
            if userAuthViewModel.isLoggedIn {
                FitrTabView()
                    .environmentObject(userAuthViewModel)
                    .environmentObject(userProfileViewModel)
                    .environmentObject(weightTrackingViewModel)
            } else {
                LoginView(authViewModel: userAuthViewModel)
            }
        }
    }
}
