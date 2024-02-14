//
//  SettingsView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: UserAuthViewModel
    @State var isShowingAlert = false
    @State private var title = ""
    @State private var msg = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Log Out") {
                    viewModel.logout()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .navigationTitle("Settings")
            }
        }
    }
    
}
