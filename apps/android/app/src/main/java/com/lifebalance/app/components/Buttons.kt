package com.lifebalance.app.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBRadius
import com.lifebalance.app.designsystem.LBTextStyle

@Composable
fun LBPrimaryButton(
    title: String,
    onClick: () -> Unit,
    enabled: Boolean = true,
    modifier: Modifier = Modifier
) {
    Button(
        onClick = onClick,
        enabled = enabled,
        shape = RoundedCornerShape(LBRadius.input.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = LBColors.Accent,
            contentColor = LBColors.OnPrimary,
            disabledContainerColor = LBColors.Accent.copy(alpha = 0.4f)
        ),
        contentPadding = PaddingValues(vertical = 14.dp),
        modifier = modifier.fillMaxWidth()
    ) {
        Text(title, style = LBTextStyle.label.copy(color = LBColors.OnPrimary, fontSize = LBTextStyle.body.fontSize))
    }
}

@Composable
fun LBSecondaryButton(
    title: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    OutlinedButton(
        onClick = onClick,
        shape = RoundedCornerShape(LBRadius.input.dp),
        colors = ButtonDefaults.outlinedButtonColors(contentColor = LBColors.Accent),
        border = BorderStroke(1.5.dp, LBColors.Accent),
        contentPadding = PaddingValues(vertical = 12.dp),
        modifier = modifier.fillMaxWidth()
    ) {
        Text(title, style = LBTextStyle.label.copy(color = LBColors.Accent, fontSize = LBTextStyle.body.fontSize))
    }
}
