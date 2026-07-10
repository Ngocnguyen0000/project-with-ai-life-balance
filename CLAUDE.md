# Life Balance — Project Context

Freelancer work management app: task/project management, time tracking, light CRM. Web + native iOS (Swift/SwiftUI) + native Android (Kotlin/Jetpack Compose), shared Supabase backend (Postgres/Auth/Realtime/Storage). Commercial SaaS with Stripe billing.

Full requirements: [PRD.md](PRD.md)
Epic/Story breakdown: [docs/epics/](docs/epics/)
Design system (source of truth for colors/typography/spacing/components): [design-system/life-balance/MASTER.md](design-system/life-balance/MASTER.md)

## Working conventions
- Each of the 3 clients (web, ios, android) is a separate codebase but must share the same Supabase schema and business rules — enforce shared logic (limits, validation) at the database layer (RLS policies, Postgres functions), not duplicated per-client.
- Before building any UI, read `design-system/life-balance/MASTER.md` first; check `design-system/life-balance/pages/[page-name].md` for page-specific overrides. If a page override doesn't exist yet, generate one via the `ui-ux-pro-max` skill (`--design-system --persist --page "<page-name>"`) rather than improvising styling. Apply platform idiom on top of the shared tokens (Apple HIG for iOS, Material Design for Android).
- Reference the relevant Epic/Story file in `docs/epics/` before implementing a feature; acceptance criteria checkboxes there define "done".
