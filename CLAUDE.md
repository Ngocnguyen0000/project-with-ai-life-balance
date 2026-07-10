# Life Balance — Project Context

Freelancer work management app: task/project management, time tracking, light CRM. Web + native iOS (Swift/SwiftUI) + native Android (Kotlin/Jetpack Compose), shared Supabase backend (Postgres/Auth/Realtime/Storage). Commercial SaaS with Stripe billing.

Full requirements: [PRD.md](PRD.md)
Epic/Story breakdown: [docs/epics/](docs/epics/)

## Working conventions
- Each of the 3 clients (web, ios, android) is a separate codebase but must share the same Supabase schema and business rules — enforce shared logic (limits, validation) at the database layer (RLS policies, Postgres functions), not duplicated per-client.
- Before building any UI, use the `ui-ux-pro-max` skill to generate/consult the design system (`--design-system`) so styling stays consistent across the three platforms while respecting each platform's idiom (Apple HIG for iOS, Material Design for Android).
- Reference the relevant Epic/Story file in `docs/epics/` before implementing a feature; acceptance criteria checkboxes there define "done".
