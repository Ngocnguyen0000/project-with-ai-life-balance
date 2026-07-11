import SwiftUI

/// Standard card surface: white on the mint-tinted app background, soft green shadow.
struct LBCard<Content: View>: View {
    var padding: CGFloat = LBSpacing.lg
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(padding)
            .background(Color.lbSurface)
            .overlay(
                RoundedRectangle(cornerRadius: LBRadius.card, style: .continuous)
                    .stroke(Color.lbBorder, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: LBRadius.card, style: .continuous))
            .lbShadow(.md)
    }
}

struct LBBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(LBFont.nunito(12, weight: .medium))
            .foregroundStyle(color)
            .padding(.horizontal, LBSpacing.sm + 2)
            .padding(.vertical, LBSpacing.xs)
            .background(Color.lbMuted)
            .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: LBSpacing.md) {
        LBCard {
            VStack(alignment: .leading, spacing: LBSpacing.xs) {
                Text("Project: Website Redesign").lbHeading3()
                Text("3 tasks in progress · Client: Acme Co.").lbCaption()
            }
        }
        LBBadge(text: "In Progress", color: .lbAccent)
    }
    .padding()
    .background(Color.lbBackground)
}
