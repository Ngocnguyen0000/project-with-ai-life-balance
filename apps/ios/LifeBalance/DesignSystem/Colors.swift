import SwiftUI

/// Color tokens mirrored 1:1 from design-system/life-balance/MASTER.md.
/// Keep this file in sync with MASTER.md — do not hardcode hex values elsewhere.
extension Color {
    static let lbPrimary = Color(hex: "#5FA987")
    static let lbOnPrimary = Color(hex: "#FFFFFF")
    static let lbAccent = Color(hex: "#4E9F76")
    static let lbSecondary = Color(hex: "#8FC7AC")
    static let lbBackground = Color(hex: "#F5FBF8")
    static let lbSurface = Color(hex: "#FFFFFF")
    static let lbForeground = Color(hex: "#2B332F")
    static let lbMuted = Color(hex: "#E8F5EE")
    static let lbBorder = Color(hex: "#D7E8DF")
    static let lbDestructive = Color(hex: "#DC4C3F")
    static let lbRing = Color(hex: "#5FA987")

    // Life Balance radar axis colors
    static let lbAxisWork = Color(hex: "#5FA987")
    static let lbAxisLove = Color(hex: "#E8A0BF")
    static let lbAxisHealth = Color(hex: "#7EC8C0")
    static let lbAxisFinance = Color(hex: "#E8B86D")
}

extension Color {
    init(hex: String) {
        let sanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

/// Soft, green-tinted shadow used across cards/buttons ("Soft UI Evolution" — see MASTER.md).
enum LBShadow {
    case sm, md, lg, xl

    var color: Color { Color.lbPrimary.opacity(opacity) }

    private var opacity: Double {
        switch self {
        case .sm: return 0.08
        case .md: return 0.12
        case .lg: return 0.16
        case .xl: return 0.20
        }
    }

    var radius: CGFloat {
        switch self {
        case .sm: return 3
        case .md: return 10
        case .lg: return 20
        case .xl: return 32
        }
    }

    var y: CGFloat {
        switch self {
        case .sm: return 1
        case .md: return 4
        case .lg: return 10
        case .xl: return 16
        }
    }
}

extension View {
    func lbShadow(_ level: LBShadow) -> some View {
        self.shadow(color: level.color, radius: level.radius, x: 0, y: level.y)
    }
}
