package com.lifebalance.app.screens.auth

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.lifebalance.app.components.LBCard
import com.lifebalance.app.components.LBPrimaryButton
import com.lifebalance.app.components.LBTextField
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBSpacing
import com.lifebalance.app.designsystem.LBTextStyle

@Composable
fun ForgotPasswordScreen(
    onSendResetLink: (String) -> Unit = {},
    onBackToLogin: () -> Unit = {}
) {
    var email by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(LBColors.Background)
            .padding(LBSpacing.lg.dp),
        verticalArrangement = Arrangement.Center
    ) {
        LBCard(padding = LBSpacing.xl) {
            Column(verticalArrangement = Arrangement.spacedBy(LBSpacing.lg.dp)) {
                Text(
                    "Life Balance",
                    style = LBTextStyle.label.copy(color = LBColors.Primary, fontWeight = FontWeight.Bold, fontSize = 20.sp)
                )

                Column(verticalArrangement = Arrangement.spacedBy(LBSpacing.sm.dp)) {
                    Text("Reset your password", style = LBTextStyle.heading1)
                    Text("We'll email you a link to reset your password.", style = LBTextStyle.body)
                }

                LBTextField(label = "Email", placeholder = "you@email.com", value = email, onValueChange = { email = it }, icon = Icons.Filled.Email)

                LBPrimaryButton(title = "Send reset link", onClick = { onSendResetLink(email) })

                TextButton(onClick = onBackToLogin) {
                    Text("Back to log in", style = LBTextStyle.label.copy(color = LBColors.Accent))
                }
            }
        }
    }
}
