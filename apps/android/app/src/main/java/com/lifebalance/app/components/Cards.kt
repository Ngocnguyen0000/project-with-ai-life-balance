package com.lifebalance.app.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBRadius
import com.lifebalance.app.designsystem.LBSpacing
import com.lifebalance.app.designsystem.LBTextStyle

/** Standard card surface: white on the mint-tinted app background, soft green shadow. */
@Composable
fun LBCard(
    modifier: Modifier = Modifier,
    padding: Int = LBSpacing.lg,
    content: @Composable () -> Unit
) {
    Column(
        modifier = modifier
            .shadow(elevation = 4.dp, shape = RoundedCornerShape(LBRadius.card.dp), ambientColor = LBColors.Primary, spotColor = LBColors.Primary)
            .background(LBColors.Surface, RoundedCornerShape(LBRadius.card.dp))
            .border(1.dp, LBColors.Border, RoundedCornerShape(LBRadius.card.dp))
            .padding(padding.dp)
    ) {
        content()
    }
}

@Composable
fun LBBadge(text: String, color: Color) {
    Text(
        text = text,
        style = LBTextStyle.caption.copy(color = color),
        modifier = Modifier
            .background(LBColors.Muted, CircleShape)
            .padding(horizontal = LBSpacing.sm.dp + 2.dp, vertical = LBSpacing.xs.dp)
    )
}
