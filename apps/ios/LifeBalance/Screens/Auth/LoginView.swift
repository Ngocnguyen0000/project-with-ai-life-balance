import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var onLogin: (String, String) -> Void = { _, _ in }
    var onForgotPassword: () -> Void = {}
    var onGoToSignUp: () -> Void = {}

    var body: some View {
        ZStack {
            Color.lbBackground.ignoresSafeArea()
            ScrollView {
                LBCard(padding: LBSpacing.xl) {
                    VStack(alignment: .leading, spacing: LBSpacing.lg) {
                        Text("Life Balance")
                            .font(LBFont.nunito(20, weight: .bold))
                            .foregroundStyle(Color.lbPrimary)

                        VStack(alignment: .leading, spacing: LBSpacing.sm) {
                            Text("Welcome back").lbHeading1()
                            Text("Log in to manage your projects, time, and clients.").lbBody()
                        }

                        LBTextField(label: "Email", placeholder: "you@email.com", text: $email, systemIcon: "envelope")
                        LBTextField(label: "Password", placeholder: "••••••••", text: $password, systemIcon: "lock", isSecure: true)

                        Button("Forgot password?", action: onForgotPassword)
                            .font(LBFont.nunito(14, weight: .semibold))
                            .foregroundStyle(Color.lbAccent)

                        LBPrimaryButton(title: "Log in") { onLogin(email, password) }

                        HStack(spacing: LBSpacing.xs) {
                            Text("Don't have an account?").lbBody()
                            Button("Sign up", action: onGoToSignUp)
                                .font(LBFont.nunito(14, weight: .semibold))
                                .foregroundStyle(Color.lbAccent)
                        }
                    }
                }
                .padding(LBSpacing.lg)
            }
        }
    }
}

#Preview {
    LoginView()
}
