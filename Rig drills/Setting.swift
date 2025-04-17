//
//  Setting.swift
//  Rig drills
//
//  Created by Dinesh on 16/04/25.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile")) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(Auth.auth().currentUser?.displayName ?? "User")
                                .font(.headline)
                            Text(Auth.auth().currentUser?.email ?? "Email")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Section(header: Text("Preferences")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                    }

                    Toggle(isOn: $darkModeEnabled) {
                        Text("Dark Mode")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        authVM.logout()
                    } label: {
                        HStack {
                            Image(systemName: "power")
                            Text("Logout")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
