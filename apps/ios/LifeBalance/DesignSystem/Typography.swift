import SwiftUI

/// Type scale mirrored from design-system/life-balance/MASTER.md.
/// Font: Nunito Sans (heading + body) — falls back to system rounded if the font isn't bundled yet.
enum LBFont {
    static func nunito(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("NunitoSans-\(weightSuffix(weight))", size: size, relativeTo: relativeStyle(size))
    }

    private static func weightSuffix(_ weight: Font.Weight) -> String {
        switch weight {
        case .bold: return "Bold"
        case .semibold: return "SemiBold"
        case .medium: return "Medium"
        default: return "Regular"
        }
    }

    private static func relativeStyle(_ size: CGFloat) -> Font.TextStyle {
        switch size {
        case 32...: return .largeTitle
        case 24..<32: return .title
        case 18..<24: return .title3
        case 16..<18: return .body
        case 14..<16: return .subheadline
        default: return .caption
        }
    }
}

extension Text {
    func lbDisplay() -> some View { self.font(LBFont.nunito(40, weight: .bold)).foregroundStyle(Color.lbForeground) }
    func lbHeading1() -> some View { self.font(LBFont.nunito(32, weight: .bold)).foregroundStyle(Color.lbForeground) }
    func lbHeading2() -> some View { self.font(LBFont.nunito(24, weight: .semibold)).foregroundStyle(Color.lbForeground) }
    func lbHeading3() -> some View { self.font(LBFont.nunito(18, weight: .semibold)).foregroundStyle(Color.lbForeground) }
    func lbBody() -> some View { self.font(LBFont.nunito(16, weight: .regular)).foregroundStyle(Color.lbForeground) }
    func lbLabel() -> some View { self.font(LBFont.nunito(14, weight: .medium)).foregroundStyle(Color.lbForeground) }
    func lbCaption() -> some View { self.font(LBFont.nunito(12, weight: .regular)).foregroundStyle(Color.lbForeground) }
}

enum LBSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
}

enum LBRadius {
    static let input: CGFloat = 10
    static let card: CGFloat = 12
    static let modal: CGFloat = 16
    static let pill: CGFloat = 999
}
