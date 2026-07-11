package com.lifebalance.app.designsystem

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable

private val LBColorScheme = lightColorScheme(
    primary = LBColors.Primary,
    onPrimary = LBColors.OnPrimary,
    secondary = LBColors.Secondary,
    background = LBColors.Background,
    surface = LBColors.Surface,
    onBackground = LBColors.Foreground,
    onSurface = LBColors.Foreground,
    surfaceVariant = LBColors.Muted,
    outline = LBColors.Border,
    error = LBColors.Destructive
)

@Composable
fun LifeBalanceTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    // Dark mode not designed yet — MASTER.md is light-only for v3. Force light scheme
    // until a dark variant of the sage-green palette is approved.
    MaterialTheme(
        colorScheme = LBColorScheme,
        typography = LBTypography,
        content = content
    )
}
