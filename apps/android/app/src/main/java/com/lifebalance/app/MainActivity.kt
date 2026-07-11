package com.lifebalance.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Folder
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.People
import androidx.compose.material.icons.filled.Schedule
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import com.lifebalance.app.designsystem.LBColors
import com.lifebalance.app.designsystem.LBTextStyle
import com.lifebalance.app.designsystem.LifeBalanceTheme
import com.lifebalance.app.screens.auth.LoginScreen
import com.lifebalance.app.screens.lifebalance.LifeBalanceOverviewScreen
import com.lifebalance.app.screens.lifebalance.LifeBalanceScores
import com.lifebalance.app.screens.lifebalance.WorkTask

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LifeBalanceTheme {
                RootScreen()
            }
        }
    }
}

/** Swaps between the auth flow and the main tab shell based on session state.
 *  Wire `isAuthenticated` to Supabase Auth's session listener once the backend is connected. */
@Composable
private fun RootScreen() {
    var isAuthenticated by remember { mutableStateOf(false) }

    if (isAuthenticated) {
        MainTabScreen()
    } else {
        LoginScreen(onLogin = { _, _ -> isAuthenticated = true })
    }
}

private enum class Tab(val label: String, val icon: androidx.compose.ui.graphics.vector.ImageVector) {
    LifeBalance("Life Balance", Icons.Filled.Home),
    Projects("Projects", Icons.Filled.Folder),
    Time("Time", Icons.Filled.Schedule),
    Clients("Clients", Icons.Filled.People),
    Settings("Settings", Icons.Filled.Settings)
}

/** Bottom tab bar — mirrors the 5-item nav from the Figma Mobile Screens page. */
@Composable
private fun MainTabScreen() {
    var selectedTab by remember { mutableStateOf(Tab.LifeBalance) }

    Scaffold(
        bottomBar = {
            NavigationBar(containerColor = LBColors.Surface) {
                Tab.entries.forEach { tab ->
                    NavigationBarItem(
                        selected = selectedTab == tab,
                        onClick = { selectedTab = tab },
                        icon = { Icon(tab.icon, contentDescription = tab.label) },
                        label = { Text(tab.label) },
                        colors = androidx.compose.material3.NavigationBarItemDefaults.colors(
                            selectedIconColor = LBColors.Accent,
                            selectedTextColor = LBColors.Accent,
                            unselectedIconColor = LBColors.Foreground,
                            unselectedTextColor = LBColors.Foreground,
                            indicatorColor = LBColors.Muted
                        )
                    )
                }
            }
        }
    ) { padding ->
        Box(modifier = Modifier.fillMaxSize().padding(padding)) {
            when (selectedTab) {
                Tab.LifeBalance -> LifeBalanceOverviewScreen(
                    userName = "Ngọc",
                    scores = LifeBalanceScores(work = 8f, love = 5f, health = 4f, finance = 7f),
                    todayTasks = listOf(
                        WorkTask("Redesign homepage hero", "Acme Co. Website", "5:00 PM")
                    )
                )
                else -> PlaceholderScreen(tab = selectedTab)
            }
        }
    }
}

/** Temporary placeholder for screens not yet ported from Figma (Projects, Time, Clients,
 *  Settings). Follow the same pattern as LifeBalanceOverviewScreen.kt when building these out. */
@Composable
private fun PlaceholderScreen(tab: Tab) {
    Box(
        modifier = Modifier.fillMaxSize().background(LBColors.Background),
        contentAlignment = androidx.compose.ui.Alignment.Center
    ) {
        Text("${tab.label} — coming soon", style = LBTextStyle.heading2)
    }
}
