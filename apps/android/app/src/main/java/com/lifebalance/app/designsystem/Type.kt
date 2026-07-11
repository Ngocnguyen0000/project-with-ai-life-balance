package com.lifebalance.app.designsystem

import androidx.compose.material3.Typography
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp
import com.lifebalance.app.R

/**
 * Nunito Sans type scale mirrored from design-system/life-balance/MASTER.md.
 * Requires Nunito Sans variable font files under res/font/ (nunito_sans.ttf or similar).
 */
val NunitoSans = FontFamily(
    Font(R.font.nunito_sans_regular, FontWeight.Normal),
    Font(R.font.nunito_sans_medium, FontWeight.Medium),
    Font(R.font.nunito_sans_semibold, FontWeight.SemiBold),
    Font(R.font.nunito_sans_bold, FontWeight.Bold)
)

object LBTextStyle {
    val display = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.Bold, fontSize = 40.sp)
    val heading1 = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.Bold, fontSize = 32.sp)
    val heading2 = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.SemiBold, fontSize = 24.sp)
    val heading3 = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.SemiBold, fontSize = 18.sp)
    val body = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.Normal, fontSize = 16.sp)
    val label = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.Medium, fontSize = 14.sp)
    val caption = TextStyle(fontFamily = NunitoSans, fontWeight = FontWeight.Normal, fontSize = 12.sp)
}

val LBTypography = Typography(
    displayLarge = LBTextStyle.display,
    headlineLarge = LBTextStyle.heading1,
    headlineMedium = LBTextStyle.heading2,
    headlineSmall = LBTextStyle.heading3,
    bodyLarge = LBTextStyle.body,
    labelLarge = LBTextStyle.label,
    bodySmall = LBTextStyle.caption
)

object LBSpacing {
    val xs = 4
    val sm = 8
    val md = 16
    val lg = 24
    val xl = 32
    val xxl = 48
    val xxxl = 64
}

object LBRadius {
    val input = 10
    val card = 12
    val modal = 16
    val pill = 999
}
