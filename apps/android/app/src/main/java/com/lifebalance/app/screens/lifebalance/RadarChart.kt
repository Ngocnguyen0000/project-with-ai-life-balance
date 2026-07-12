package com.lifebalance.app.screens.lifebalance

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.layout.layout
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBTextStyle
import kotlin.math.cos
import kotlin.math.sin

data class LifeBalanceScores(
    val work: Float,   // computed from real task/time data — see Epic 7, Story 7.2
    val love: Float,   // self-rated check-in
    val health: Float, // self-rated check-in
    val finance: Float // self-rated check-in
) {
    val average: Float get() = (work + love + health + finance) / 4f
}

private enum class Axis(val label: String, val color: Color, val angle: Double) {
    WORK("Công việc", LBColors.AxisWork, -Math.PI / 2),
    LOVE("Tình yêu", LBColors.AxisLove, 0.0),
    HEALTH("Sức khỏe", LBColors.AxisHealth, Math.PI / 2),
    FINANCE("Tài chính", LBColors.AxisFinance, Math.PI);

    fun value(scores: LifeBalanceScores): Float = when (this) {
        WORK -> scores.work
        LOVE -> scores.love
        HEALTH -> scores.health
        FINANCE -> scores.finance
    }
}

/** 4-axis radar/spider chart — this product's signature component (Epic 7). */
@Composable
fun RadarChart(scores: LifeBalanceScores, size: Int = 260) {
    val axes = Axis.entries
    val maxRadiusPx = size * 0.36f

    Box(modifier = Modifier.size(size.dp), contentAlignment = Alignment.Center) {
        Canvas(modifier = Modifier.size(size.dp)) {
            val center = Offset(this.size.width / 2, this.size.height / 2)

            fun point(axis: Axis, radius: Float): Offset = Offset(
                x = center.x + radius * cos(axis.angle).toFloat(),
                y = center.y + radius * sin(axis.angle).toFloat()
            )

            // grid rings
            listOf(0.33f, 0.66f, 1f).forEach { pct ->
                val path = Path()
                axes.forEachIndexed { i, axis ->
                    val p = point(axis, maxRadiusPx * pct)
                    if (i == 0) path.moveTo(p.x, p.y) else path.lineTo(p.x, p.y)
                }
                path.close()
                drawPath(path, color = LBColors.Border, style = Stroke(width = 2f))
            }

            // axis lines
            axes.forEach { axis ->
                val p = point(axis, maxRadiusPx)
                drawLine(LBColors.Border, center, p, strokeWidth = 2f, cap = StrokeCap.Round)
            }

            // data polygon
            val dataPoints = axes.map { axis -> point(axis, maxRadiusPx * (axis.value(scores) / 10f)) }
            val dataPath = Path()
            dataPoints.forEachIndexed { i, p -> if (i == 0) dataPath.moveTo(p.x, p.y) else dataPath.lineTo(p.x, p.y) }
            dataPath.close()
            drawPath(dataPath, color = LBColors.Primary.copy(alpha = 0.22f))
            drawPath(dataPath, color = LBColors.Primary, style = Stroke(width = 6f, cap = StrokeCap.Round))

            // vertex dots
            axes.forEachIndexed { i, axis ->
                drawCircle(Color.White, radius = 9f, center = dataPoints[i])
                drawCircle(axis.color, radius = 6f, center = dataPoints[i])
            }
        }

        // axis labels (drawn as Compose Text overlays, positioned via the same trig)
        axes.forEach { axis ->
            val labelRadius = maxRadiusPx + 30
            val x = (size / 2) + labelRadius * cos(axis.angle).toFloat()
            val y = (size / 2) + labelRadius * sin(axis.angle).toFloat()
            Box(
                modifier = Modifier.size(size.dp),
                contentAlignment = Alignment.TopStart
            ) {
                Text(
                    "${axis.label} ${axis.value(scores).toInt()}",
                    style = LBTextStyle.caption.copy(color = axis.color, fontWeight = FontWeight.SemiBold),
                    modifier = Modifier.offset(x, y)
                )
            }
        }

        Column2 {
            Text(String.format("%.1f", scores.average), style = LBTextStyle.heading1.copy(fontSize = 30.sp))
            Text("/ 10", style = LBTextStyle.caption)
        }
    }
}

@Composable
private fun Column2(content: @Composable androidx.compose.foundation.layout.ColumnScope.() -> Unit) {
    androidx.compose.foundation.layout.Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        content = content
    )
}

private fun Modifier.offset(x: Float, y: Float): Modifier = this.layout { measurable, constraints ->
    val placeable = measurable.measure(constraints)
    layout(placeable.width, placeable.height) {
        placeable.place(x.toInt() - placeable.width / 2, y.toInt() - placeable.height / 2)
    }
}
