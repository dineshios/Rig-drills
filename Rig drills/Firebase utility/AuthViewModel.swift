//
//  Untitled.swift
//  Rig drills
//
//  Created by Dinesh on 15/04/25.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var loginError: String?

    init() {
        checkLoginStatus()
    }

    func checkLoginStatus() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.loginError = error.localizedDescription
                } else {
                    self.isLoggedIn = true
                    self.loginError = nil
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}
