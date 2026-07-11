# Life Balance — iOS (SwiftUI)

Source files only — no `.xcodeproj` yet (needs to be generated in Xcode itself, can't be scripted from here).

## Setup
1. Open Xcode → **File → New → Project → iOS → App**. Name it `LifeBalance`, interface: SwiftUI, language: Swift.
2. Delete the generated `ContentView.swift` / default `LifeBalanceApp.swift`.
3. Drag the `LifeBalance/` folder from this repo into the Xcode project navigator (check "Copy items if needed").
4. Add the **Nunito Sans** font files (`.ttf`, download from [Google Fonts](https://fonts.google.com/specimen/Nunito+Sans)) to the project, and register them in `Info.plist` under `Fonts provided by application`. Until then, `LBFont.nunito()` will silently fall back to the system font.
5. Add the **Supabase Swift SDK** via Swift Package Manager: `https://github.com/supabase/supabase-swift` — needed before wiring real auth/data (see step 9 / backend consultation).

## Structure
- `DesignSystem/` — Colors.swift, Typography.swift (mirrors `design-system/life-balance/MASTER.md` — keep in sync)
- `Components/` — LBButton, LBTextField, LBCard (reusable, used across all screens)
- `Screens/Auth/` — Login, SignUp, ForgotPassword
- `Screens/LifeBalance/` — RadarChartView (custom Shape) + LifeBalanceOverviewView (home screen, Epic 7)
- `LifeBalanceApp.swift` — app entry, auth gate, tab navigation

## Not yet built
Dashboard, Projects, Project Detail (Kanban), Task Detail, Time Tracker, Timesheet, Clients, Client Detail, Settings, Pricing — specs are in the Figma file's `📲 Mobile Screens` page. Follow the pattern in `Screens/LifeBalance/LifeBalanceOverviewView.swift` (compose `LBCard` + design tokens, no ad-hoc colors).
