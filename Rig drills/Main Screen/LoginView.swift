import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            // Background Image
            Image("login_bg")
                .resizable()
                .aspectRatio(0.5, contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            // Transparent overlay
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)

            // Centered login form
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal, 32)

                Button(action: {
                    authVM.login(email: email, password: password)
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                }
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .alert(isPresented: Binding<Bool>(
            get: { authVM.loginError != nil },
            set: { _ in authVM.loginError = nil }
        )) {
            Alert(
                title: Text("Login Failed"),
                message: Text(authVM.loginError ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
