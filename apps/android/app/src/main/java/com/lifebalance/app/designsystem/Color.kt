package com.lifebalance.app.designsystem

import androidx.compose.ui.graphics.Color

/**
 * Color tokens mirrored 1:1 from design-system/life-balance/MASTER.md.
 * Keep this file in sync with MASTER.md — do not hardcode hex values elsewhere.
 */
object LBColors {
    val Primary = Color(0xFF5FA987)
    val OnPrimary = Color(0xFFFFFFFF)
    val Accent = Color(0xFF4E9F76)
    val Secondary = Color(0xFF8FC7AC)
    val Background = Color(0xFFF5FBF8)
    val Surface = Color(0xFFFFFFFF)
    val Foreground = Color(0xFF2B332F)
    val Muted = Color(0xFFE8F5EE)
    val Border = Color(0xFFD7E8DF)
    val Destructive = Color(0xFFDC4C3F)
    val Ring = Color(0xFF5FA987)

    // Life Balance radar axis colors
    val AxisWork = Color(0xFF5FA987)
    val AxisLove = Color(0xFFE8A0BF)
    val AxisHealth = Color(0xFF7EC8C0)
    val AxisFinance = Color(0xFFE8B86D)
}

/** Soft, green-tinted shadow tint used across cards/buttons ("Soft UI Evolution" — see MASTER.md). */
object LBShadow {
    val sm = LBColors.Primary.copy(alpha = 0.08f) to 3f
    val md = LBColors.Primary.copy(alpha = 0.12f) to 10f
    val lg = LBColors.Primary.copy(alpha = 0.16f) to 20f
    val xl = LBColors.Primary.copy(alpha = 0.20f) to 32f
}
