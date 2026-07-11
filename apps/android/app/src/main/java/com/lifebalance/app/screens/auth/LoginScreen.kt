package com.lifebalance.app.screens.auth

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
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
fun LoginScreen(
    onLogin: (String, String) -> Unit = { _, _ -> },
    onForgotPassword: () -> Unit = {},
    onGoToSignUp: () -> Unit = {}
) {
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(LBColors.Background)
            .verticalScroll(rememberScrollState())
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
                    Text("Welcome back", style = LBTextStyle.heading1)
                    Text("Log in to manage your projects, time, and clients.", style = LBTextStyle.body)
                }

                LBTextField(label = "Email", placeholder = "you@email.com", value = email, onValueChange = { email = it }, icon = Icons.Filled.Email)
                LBTextField(label = "Password", placeholder = "••••••••", value = password, onValueChange = { password = it }, icon = Icons.Filled.Lock, isPassword = true)

                TextButton(onClick = onForgotPassword) {
                    Text("Forgot password?", style = LBTextStyle.label.copy(color = LBColors.Accent))
                }

                LBPrimaryButton(title = "Log in", onClick = { onLogin(email, password) })

                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text("Don't have an account? ", style = LBTextStyle.body)
                    TextButton(onClick = onGoToSignUp) {
                        Text("Sign up", style = LBTextStyle.label.copy(color = LBColors.Accent))
                    }
                }
            }
        }
    }
}
