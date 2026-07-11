import SwiftUI

@main
struct LifeBalanceApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

/// Swaps between the auth flow and the main tab shell based on session state.
/// Wire `isAuthenticated` to Supabase Auth's session listener once the backend is connected.
struct RootView: View {
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            MainTabView()
        } else {
            LoginView(
                onLogin: { _, _ in isAuthenticated = true },
                onForgotPassword: {},
                onGoToSignUp: {}
            )
        }
    }
}

/// Bottom tab bar — mirrors the 5-item nav from the Figma Mobile Screens page
/// (Life Balance, Projects, Time, Clients, Settings).
struct MainTabView: View {
    var body: some View {
        TabView {
            LifeBalanceOverviewView(
                userName: "Ngọc",
                scores: .init(work: 8, love: 5, health: 4, finance: 7),
                todayTasks: [
                    WorkTask(title: "Redesign homepage hero", project: "Acme Co. Website", due: "5:00 PM")
                ]
            )
            .tabItem { Label("Life Balance", systemImage: "house.fill") }

            PlaceholderScreen(title: "Projects")
                .tabItem { Label("Projects", systemImage: "folder.fill") }

            PlaceholderScreen(title: "Time Tracking")
                .tabItem { Label("Time", systemImage: "clock.fill") }

            PlaceholderScreen(title: "Clients")
                .tabItem { Label("Clients", systemImage: "person.2.fill") }

            PlaceholderScreen(title: "Settings")
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(Color.lbAccent)
    }
}

/// Temporary placeholder for screens not yet ported from Figma (Dashboard, Projects,
/// Time Tracker, Timesheet, Clients, Settings). Follow the same pattern as
/// LifeBalanceOverviewView.swift when building these out.
struct PlaceholderScreen: View {
    let title: String
    var body: some View {
        ZStack {
            Color.lbBackground.ignoresSafeArea()
            VStack(spacing: LBSpacing.sm) {
                Text(title).lbHeading2()
                Text("Coming soon — see Figma Mobile Screens for spec").lbCaption()
            }
        }
    }
}
