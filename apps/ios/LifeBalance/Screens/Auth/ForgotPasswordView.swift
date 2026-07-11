import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    var onSendResetLink: (String) -> Void = { _ in }
    var onBackToLogin: () -> Void = {}

    var body: some View {
        ZStack {
            Color.lbBackground.ignoresSafeArea()
            LBCard(padding: LBSpacing.xl) {
                VStack(alignment: .leading, spacing: LBSpacing.lg) {
                    Text("Life Balance")
                        .font(LBFont.nunito(20, weight: .bold))
                        .foregroundStyle(Color.lbPrimary)

                    VStack(alignment: .leading, spacing: LBSpacing.sm) {
                        Text("Reset your password").lbHeading1()
                        Text("We'll email you a link to reset your password.").lbBody()
                    }

                    LBTextField(label: "Email", placeholder: "you@email.com", text: $email, systemIcon: "envelope")

                    LBPrimaryButton(title: "Send reset link") { onSendResetLink(email) }

                    Button("Back to log in", action: onBackToLogin)
                        .font(LBFont.nunito(14, weight: .semibold))
                        .foregroundStyle(Color.lbAccent)
                }
            }
            .padding(LBSpacing.lg)
        }
    }
}

#Preview {
    ForgotPasswordView()
}
