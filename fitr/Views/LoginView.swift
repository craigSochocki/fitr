//
//  LoginView.swift
//  fitr
//
//  Created by Craig Sochocki on 2/9/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel = UserAuthViewModel()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAccountCreation = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                }
                Button("Log In") {
                    loginUser()
                }
                .padding()
                Spacer()
                Button("Create Account") {
                    showingAccountCreation = true
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Log In")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage))
            }
        }
        .sheet(isPresented: $showingAccountCreation) {
            AccountCreationView(authViewModel: authViewModel)
        }
    }
    
    func loginUser() {
        authViewModel.login(username: username, password: password) { success, message in
            if success {
                
            } else {
                alertMessage = message ?? "Failed to log in.  Please try again."
                showingAlert = true
            }
            
        }
    }
}
