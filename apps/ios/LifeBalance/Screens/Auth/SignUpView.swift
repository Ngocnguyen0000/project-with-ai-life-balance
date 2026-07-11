import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    var onSignUp: (String, String, String) -> Void = { _, _, _ in }
    var onGoToLogin: () -> Void = {}

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
                            Text("Create your account").lbHeading1()
                            Text("Start tracking work and getting paid on time.").lbBody()
                        }

                        LBTextField(label: "Full name", placeholder: "Ngoc Nguyen", text: $fullName, systemIcon: "person")
                        LBTextField(label: "Email", placeholder: "you@email.com", text: $email, systemIcon: "envelope")
                        LBTextField(label: "Password", placeholder: "••••••••", text: $password, systemIcon: "lock", isSecure: true)

                        LBPrimaryButton(title: "Sign up") { onSignUp(fullName, email, password) }

                        HStack(spacing: LBSpacing.xs) {
                            Text("Already have an account?").lbBody()
                            Button("Log in", action: onGoToLogin)
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
    SignUpView()
}
