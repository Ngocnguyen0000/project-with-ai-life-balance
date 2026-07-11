import SwiftUI

struct LifeBalanceScores {
    var work: Double   // computed from real task/time data — see Epic 7, Story 7.2
    var love: Double   // self-rated check-in
    var health: Double // self-rated check-in
    var finance: Double // self-rated check-in

    var average: Double { (work + love + health + finance) / 4 }
}

private enum Axis: Int, CaseIterable {
    case work, love, health, finance

    var label: String {
        switch self {
        case .work: return "Công việc"
        case .love: return "Tình yêu"
        case .health: return "Sức khỏe"
        case .finance: return "Tài chính"
        }
    }

    var color: Color {
        switch self {
        case .work: return .lbAxisWork
        case .love: return .lbAxisLove
        case .health: return .lbAxisHealth
        case .finance: return .lbAxisFinance
        }
    }

    /// Angle in radians: work=top, love=right, health=bottom, finance=left.
    var angle: Double {
        switch self {
        case .work: return -.pi / 2
        case .love: return 0
        case .health: return .pi / 2
        case .finance: return .pi
        }
    }

    func value(from scores: LifeBalanceScores) -> Double {
        switch self {
        case .work: return scores.work
        case .love: return scores.love
        case .health: return scores.health
        case .finance: return scores.finance
        }
    }
}

/// 4-axis radar/spider chart — this product's signature component (Epic 7).
/// Work axis is computed from real data; Love/Health/Finance are periodic self-ratings.
struct RadarChartView: View {
    let scores: LifeBalanceScores
    var size: CGFloat = 260

    private var maxRadius: CGFloat { size * 0.36 }

    var body: some View {
        ZStack {
            gridRings
            axisLines
            dataPolygon
            axisDots
            axisLabels
            centerScore
        }
        .frame(width: size, height: size)
    }

    private func point(for axis: Axis, radius: CGFloat) -> CGPoint {
        CGPoint(
            x: size / 2 + radius * CGFloat(cos(axis.angle)),
            y: size / 2 + radius * CGFloat(sin(axis.angle))
        )
    }

    private func ringPath(radius: CGFloat) -> Path {
        var path = Path()
        let points = Axis.allCases.map { point(for: $0, radius: radius) }
        path.move(to: points[0])
        for p in points.dropFirst() { path.addLine(to: p) }
        path.closeSubpath()
        return path
    }

    private var gridRings: some View {
        ForEach([0.33, 0.66, 1.0], id: \.self) { pct in
            ringPath(radius: maxRadius * pct)
                .stroke(Color.lbBorder, lineWidth: 1)
        }
    }

    private var axisLines: some View {
        ForEach(Axis.allCases, id: \.self) { axis in
            Path { path in
                path.move(to: CGPoint(x: size / 2, y: size / 2))
                path.addLine(to: point(for: axis, radius: maxRadius))
            }
            .stroke(Color.lbBorder, lineWidth: 1)
        }
    }

    private var dataPolygon: some View {
        let points = Axis.allCases.map { axis in
            point(for: axis, radius: maxRadius * CGFloat(axis.value(from: scores) / 10))
        }
        return Path { path in
            path.move(to: points[0])
            for p in points.dropFirst() { path.addLine(to: p) }
            path.closeSubpath()
        }
        .fill(Color.lbPrimary.opacity(0.22))
        .overlay(
            Path { path in
                path.move(to: points[0])
                for p in points.dropFirst() { path.addLine(to: p) }
                path.closeSubpath()
            }
            .stroke(Color.lbPrimary, lineWidth: 2.5)
        )
    }

    private var axisDots: some View {
        ForEach(Axis.allCases, id: \.self) { axis in
            let p = point(for: axis, radius: maxRadius * CGFloat(axis.value(from: scores) / 10))
            Circle()
                .fill(axis.color)
                .frame(width: 12, height: 12)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .position(p)
        }
    }

    private var axisLabels: some View {
        ForEach(Axis.allCases, id: \.self) { axis in
            let p = point(for: axis, radius: maxRadius + 26)
            Text("\(axis.label)  \(Int(axis.value(from: scores)))")
                .font(LBFont.nunito(12, weight: .semibold))
                .foregroundStyle(axis.color)
                .position(p)
        }
    }

    private var centerScore: some View {
        VStack(spacing: 0) {
            Text(String(format: "%.1f", scores.average))
                .font(LBFont.nunito(30, weight: .bold))
                .foregroundStyle(Color.lbForeground)
            Text("/ 10")
                .font(LBFont.nunito(12, weight: .medium))
                .foregroundStyle(Color.lbForeground.opacity(0.6))
        }
        .position(x: size / 2, y: size / 2)
    }
}

#Preview {
    RadarChartView(scores: .init(work: 8, love: 5, health: 4, finance: 7))
        .padding(60)
        .background(Color.lbBackground)
}
