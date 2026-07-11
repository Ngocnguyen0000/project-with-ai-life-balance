package com.lifebalance.app.screens.lifebalance

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.lifebalance.app.components.LBCard
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBSpacing
import com.lifebalance.app.designsystem.LBTextStyle

data class WorkTask(val title: String, val project: String, val due: String)

@Composable
fun LifeBalanceOverviewScreen(
    userName: String,
    scores: LifeBalanceScores,
    todayTasks: List<WorkTask>,
    onCheckIn: (String) -> Unit = {}
) {
    // Story 7.1: surface a plain-language nudge when one axis lags — placeholder logic,
    // replace with real trend data (Story 7.4) once check-in history exists.
    val lowestAxisNote = if (scores.health <= scores.work - 3) {
        "Sức khỏe đang thấp hơn các trục khác — cân nhắc dành thời gian nghỉ ngơi."
    } else null

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(LBColors.Background)
            .verticalScroll(rememberScrollState())
            .padding(LBSpacing.lg.dp),
        verticalArrangement = Arrangement.spacedBy(LBSpacing.lg.dp)
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(LBSpacing.xs.dp)) {
            Text("Chào buổi sáng, $userName", style = LBTextStyle.heading2)
            Text("Đây là bức tranh cân bằng cuộc sống của bạn tuần này", style = LBTextStyle.caption)
        }

        LBCard {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(LBSpacing.md.dp),
                modifier = Modifier.fillMaxWidth()
            ) {
                RadarChart(scores = scores)
                Row(horizontalArrangement = Arrangement.spacedBy(LBSpacing.sm.dp)) {
                    CheckInChip("Tình yêu", LBColors.AxisLove) { onCheckIn("Tình yêu") }
                    CheckInChip("Sức khỏe", LBColors.AxisHealth) { onCheckIn("Sức khỏe") }
                    CheckInChip("Tài chính", LBColors.AxisFinance) { onCheckIn("Tài chính") }
                }
            }
        }

        lowestAxisNote?.let {
            Text("💡 $it", style = LBTextStyle.label.copy(color = LBColors.Destructive))
        }

        Column(verticalArrangement = Arrangement.spacedBy(LBSpacing.sm.dp)) {
            Text("Công việc hôm nay", style = LBTextStyle.heading3)
            todayTasks.forEach { task ->
                LBCard(padding = LBSpacing.md) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Column {
                            Text(task.title, style = LBTextStyle.label)
                            Text(task.project, style = LBTextStyle.caption)
                        }
                        Text(task.due, style = LBTextStyle.caption.copy(color = LBColors.Destructive))
                    }
                }
            }
        }
    }
}

@Composable
private fun CheckInChip(label: String, color: Color, onClick: () -> Unit) {
    TextButton(
        onClick = onClick,
        shape = CircleShape,
        border = BorderStroke(1.5.dp, color)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(LBSpacing.xs.dp)) {
            Box(
                modifier = Modifier
                    .padding(end = 2.dp)
                    .background(color, CircleShape)
                    .padding(4.dp)
            )
            Text("Chấm điểm $label", style = LBTextStyle.caption.copy(color = color))
        }
    }
}
