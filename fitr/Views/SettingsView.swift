//
//  SettingsView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: UserAuthViewModel
    @State var isShowingAlert = false
    @State private var title = ""
    @State private var msg = ""
    
    var body: some View {
        List {
            Section(header: Text("Settings")) {
                Button("Test Button") {}
                Button("Test Button 2") {}
            }
            if authViewModel.isAdmin {
                Section(header: Text("Internal Settings")) {
                    Button("Debug Tool 1") {
                        // Action for Debug Tool 1
                    }
                    Button("Debug Tool 2") {
                        // Action for Debug Tool 2
                    }
                    // Add more buttons or views for additional tools as needed.
                }
            }
                Button("Log Out") {
                    authViewModel.logout()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        .navigationTitle("Settings")
    }
}
