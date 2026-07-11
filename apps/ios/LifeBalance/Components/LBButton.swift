import SwiftUI

struct LBPrimaryButton: View {
    let title: String
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LBFont.nunito(16, weight: .semibold))
                .foregroundStyle(Color.lbOnPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, LBSpacing.md - 4)
        }
        .background(Color.lbAccent)
        .clipShape(RoundedRectangle(cornerRadius: LBRadius.input, style: .continuous))
        .lbShadow(isDisabled ? .sm : .md)
        .opacity(isDisabled ? 0.4 : 1)
        .disabled(isDisabled)
    }
}

struct LBSecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LBFont.nunito(16, weight: .semibold))
                .foregroundStyle(Color.lbAccent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, LBSpacing.md - 4)
        }
        .background(Color.lbSurface)
        .overlay(
            RoundedRectangle(cornerRadius: LBRadius.input, style: .continuous)
                .stroke(Color.lbAccent, lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: LBRadius.input, style: .continuous))
    }
}

#Preview {
    VStack(spacing: LBSpacing.md) {
        LBPrimaryButton(title: "Get Started") {}
        LBSecondaryButton(title: "Learn More") {}
        LBPrimaryButton(title: "Disabled", isDisabled: true) {}
    }
    .padding()
    .background(Color.lbBackground)
}
