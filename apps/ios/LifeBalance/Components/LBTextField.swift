import SwiftUI

struct LBTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var systemIcon: String? = nil
    var isSecure: Bool = false

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: LBSpacing.xs + 2) {
            Text(label.uppercased())
                .font(LBFont.nunito(12, weight: .medium))
                .foregroundStyle(Color.lbForeground.opacity(0.7))

            HStack(spacing: LBSpacing.sm + 2) {
                if let systemIcon {
                    Image(systemName: systemIcon)
                        .foregroundStyle(Color.lbPrimary)
                        .frame(width: 18)
                }
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(LBFont.nunito(15, weight: .regular))
                .foregroundStyle(Color.lbForeground)
                .focused($isFocused)
            }
            .padding(.horizontal, LBSpacing.md)
            .padding(.vertical, LBSpacing.md - 4)
            .background(Color.lbSurface)
            .overlay(
                RoundedRectangle(cornerRadius: LBRadius.input, style: .continuous)
                    .stroke(isFocused ? Color.lbPrimary : Color.lbBorder, lineWidth: isFocused ? 2 : 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: LBRadius.input, style: .continuous))
            .lbShadow(.sm)
        }
    }
}

#Preview {
    VStack(spacing: LBSpacing.md) {
        LBTextField(label: "Email", placeholder: "you@email.com", text: .constant(""), systemIcon: "envelope")
        LBTextField(label: "Password", placeholder: "••••••••", text: .constant(""), systemIcon: "lock", isSecure: true)
    }
    .padding()
    .background(Color.lbBackground)
}
