//
//  AccountCreationView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct AccountCreationView: View {
    @ObservedObject var authViewModel: UserAuthViewModel
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var profilePicURL: String = ""
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                TextField("Weight", text: $weight)
                    .keyboardType(.numberPad)
                TextField("Profile Pic URL", text: $profilePicURL)
                
                Button("Create Account ") {
                    createAccount()
                }
                .disabled(username.isEmpty || password.isEmpty || name.isEmpty || age.isEmpty || weight.isEmpty)
                
            }
            .navigationTitle("Create Account")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Account Creation"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func createAccount() {
        guard let ageInt = Int(age), let weightInt = Int(weight) else {
            alertMessage = "Please make sure your age and weight are entered correctly."
            showingAlert = true
            return
        }
        
        authViewModel.createAccount(username: username, password: password) { success, message in
            if success {
                alertMessage = message ?? "Account created successfully!"
            } else {
                alertMessage = message ?? "Failed to create an account.  Please try again."
            }
            showingAlert = true
        }
    }
    //        let newProfile = Profile(name: name, age: ageInt, weight: weightInt, profilePicURL: profilePicURL)
    //        viewModel.saveUserProfile(newProfile)
}
