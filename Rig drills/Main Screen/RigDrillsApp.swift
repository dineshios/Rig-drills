//
//  RigDrillsApp.swift
//  Rig drills
//
//  Created by Dinesh on 01/04/25.
//

import SwiftUI
import SwiftData
import Contacts
import FirebaseCore

@main
struct RigDrillsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Customer.self,
            Project.self,
            Employee.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(sharedModelContainer)
    }
}

// Class that conforms to UIApplicationDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    let store = CNContactStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // perform what you want here
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                print("Contact access granted.")
            } else {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
            }
        }
        return true
    }
    
}
