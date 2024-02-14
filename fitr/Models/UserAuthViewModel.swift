//
//  UserAuthViewModel.swift
//  fitr
//
//  Created by Craig Sochocki on 2/13/24.
//

import Foundation

class UserAuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool
    
    init() {
        self.isLoggedIn = UserAuthViewModel.fetchLoginState()
        // Any additional setup can go here
    }

    // More properties associated with authentication can go here...
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // Login logic here
        if let userData = UserDefaults.standard.data(forKey: username),
        let storedInfo = try? JSONDecoder().decode([String: String].self, from: userData),
        let storedPassword = storedInfo["password"] {
            
            if password == storedPassword {
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    self.saveLoginState(isLoggedIn: self.isLoggedIn)
                    completion(true, nil) // Login successful
                }
            } else {
                DispatchQueue.main.async {
                    completion(false, "Invalid username or password")
                }
            }
        } else {
            // No user found with given username
            DispatchQueue.main.async {
                completion(false, "User not found")
            }
        }
    }
    
    func logout() {
        // Logout logic here
        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.saveLoginState(isLoggedIn: self.isLoggedIn)
        }
    }
    
    func saveLoginState(isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    static func fetchLoginState() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func createAccount(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // Check for existing account
        if UserDefaults.standard.object(forKey: username) != nil {
            DispatchQueue.main.async {
                completion(false, "An account for this username already exists.")
            }
            return
        }
        
        // Simulate account creation
        let accountInfo = ["username": username, "password": password]
        
        // Convert accountInfo to Data
        if let accountData = try? JSONEncoder().encode(accountInfo) {
            UserDefaults.standard.set(accountData, forKey: username)
            DispatchQueue.main.async {
                self.isLoggedIn = true
                completion(true, "Account created succcessfully!")
            }
        } else {
            DispatchQueue.main.async {
                completion(false, "Failed to create an account due to an error")
            }
        }
    }
}
