import SwiftUI

struct WorkTask: Identifiable {
    let id = UUID()
    let title: String
    let project: String
    let due: String
}

struct LifeBalanceOverviewView: View {
    let userName: String
    let scores: LifeBalanceScores
    let todayTasks: [WorkTask]
    var onCheckIn: (String) -> Void = { _ in }

    private var lowestAxisNote: String? {
        // Story 7.1: surface a plain-language nudge when one axis lags — placeholder logic,
        // replace with real trend data (Story 7.4) once check-in history exists.
        if scores.health <= scores.work - 3 {
            return "Sức khỏe đang thấp hơn các trục khác — cân nhắc dành thời gian nghỉ ngơi."
        }
        return nil
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: LBSpacing.lg) {
                VStack(alignment: .leading, spacing: LBSpacing.xs) {
                    Text("Chào buổi sáng, \(userName)").lbHeading2()
                    Text("Đây là bức tranh cân bằng cuộc sống của bạn tuần này").lbCaption()
                }

                LBCard {
                    VStack(spacing: LBSpacing.md) {
                        RadarChartView(scores: scores)
                        checkInRow
                    }
                }

                if let note = lowestAxisNote {
                    Text("💡 \(note)")
                        .font(LBFont.nunito(13, weight: .medium))
                        .foregroundStyle(Color.lbDestructive)
                }

                VStack(alignment: .leading, spacing: LBSpacing.sm) {
                    Text("Công việc hôm nay").lbHeading3()
                    ForEach(todayTasks) { task in
                        taskRow(task)
                    }
                }
            }
            .padding(LBSpacing.lg)
        }
        .background(Color.lbBackground.ignoresSafeArea())
    }

    private var checkInRow: some View {
        HStack(spacing: LBSpacing.sm) {
            checkInChip(label: "Tình yêu", color: .lbAxisLove)
            checkInChip(label: "Sức khỏe", color: .lbAxisHealth)
            checkInChip(label: "Tài chính", color: .lbAxisFinance)
        }
    }

    private func checkInChip(label: String, color: Color) -> some View {
        Button { onCheckIn(label) } label: {
            HStack(spacing: LBSpacing.xs) {
                Circle().fill(color).frame(width: 8, height: 8)
                Text("Chấm điểm \(label)")
                    .font(LBFont.nunito(13, weight: .medium))
                    .foregroundStyle(color)
            }
            .padding(.horizontal, LBSpacing.md - 2)
            .padding(.vertical, LBSpacing.sm + 2)
            .overlay(Capsule().stroke(color, lineWidth: 1.5))
        }
    }

    private func taskRow(_ task: WorkTask) -> some View {
        LBCard(padding: LBSpacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(task.title).lbLabel()
                    Text(task.project).lbCaption()
                }
                Spacer()
                Text(task.due)
                    .font(LBFont.nunito(12, weight: .medium))
                    .foregroundStyle(Color.lbDestructive)
            }
        }
    }
}

#Preview {
    LifeBalanceOverviewView(
        userName: "Ngọc",
        scores: .init(work: 8, love: 5, health: 4, finance: 7),
        todayTasks: [
            WorkTask(title: "Redesign homepage hero", project: "Acme Co. Website", due: "5:00 PM"),
            WorkTask(title: "Client feedback review", project: "Acme Co. Website", due: "6:30 PM")
        ]
    )
}
