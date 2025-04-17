//
//  SplashView.swift
//  Rig drills
//
//  Created by Dinesh on 16/04/25.
//
import SwiftUI

struct SplashView: View {
    @StateObject var authVM = AuthViewModel()
    @State private var isActive = false

    var body: some View {
        if isActive {
            Group {
                if authVM.isLoggedIn {
                    MainTabbedView() // your main screen after login
                } else {
                    LoginView()
                }
            }
            .environmentObject(authVM)
        } else {
            ZStack {
                Image("login_bg")
                    .resizable()
                    .aspectRatio(0.5, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
                Text("Welcome to EHD")
                    .font(.title)
                    .padding(.top, 20)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                // Delay for 2 seconds, then switch to main view
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
