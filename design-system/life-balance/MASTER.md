# Design System Master File

> **LOGIC:** When building a specific page, first check `design-system/pages/[page-name].md`.
> If that file exists, its rules **override** this Master file.
> If not, strictly follow the rules below.

---

**Project:** Life Balance
**Version:** v3 (final, approved 2026-07-11)
**Category:** Freelancer Platform + Personal Wellness (Life Balance Overview)

> **History:** v1 was an auto-generated indigo/dark palette (rejected — looked unfinished/flat). v2 followed a user-provided coral/pink e-commerce reference (visually fine but too vivid for a data-dense daily-use app). v3 is the approved direction: a custom soft sage-green pastel palette the user explicitly asked for, styled as "Soft UI Evolution" — chosen because it fits both halves of the product (professional task/time tool + personal wellness radar) and stays WCAG AA+ compliant, unlike raw neumorphism.

---

## Global Rules

### Color Palette

| Role | Hex | CSS Variable | Usage |
|------|-----|--------------|-------|
| Primary / Brand | `#5FA987` | `--color-primary` | Nav highlights, links, primary brand moments |
| On Primary | `#FFFFFF` | `--color-on-primary` | Text/icons on primary or accent fills |
| Accent / CTA | `#4E9F76` | `--color-accent` | Buttons, primary actions (slightly deeper than primary for contrast) |
| Background | `#F5FBF8` | `--color-background` | App canvas (mint-tinted off-white) |
| Surface | `#FFFFFF` | `--color-surface` | Cards, inputs, sidebar — always distinct from background |
| Foreground | `#2B332F` | `--color-foreground` | Primary text (warm dark, green undertone) |
| Muted | `#E8F5EE` | `--color-muted` | Secondary surfaces, badges, hover fills |
| Border | `#D7E8DF` | `--color-border` | Card/input borders, dividers |
| Destructive | `#DC4C3F` | `--color-destructive` | Errors, delete actions (softened red, stays in pastel family) |
| Ring | `#5FA987` | `--color-ring` | Focus rings |

**Life Balance radar axis colors** (distinct per axis, same pastel/muted family so the 4-axis chart stays harmonious):

| Axis | Hex | CSS Variable | Meaning |
|------|-----|--------------|---------|
| Công việc (Work) | `#5FA987` | `--color-axis-work` | = Primary. Computed from real task/time data (Epic 7). |
| Tình yêu (Love) | `#E8A0BF` | `--color-axis-love` | Dusty rose pastel — warmth |
| Sức khỏe (Health) | `#7EC8C0` | `--color-axis-health` | Soft teal pastel — calm |
| Tài chính (Finance) | `#E8B86D` | `--color-axis-finance` | Soft amber pastel — prosperity |

**Color Notes:** All colors are intentionally desaturated/muted ("pastel" per the user's explicit request), not neon. `background` is a very light mint tint, not pure white, so white `surface` cards visibly float without needing heavy shadows. Never use raw/saturated green (e.g. `#22C55E`, `#16A34A`) anywhere in this product — it reads as generic "success green," not the brand.

### Typography

- **Heading Font:** Nunito Sans (SemiBold/Bold weights)
- **Body Font:** Nunito Sans (Regular/Medium weights)
- **Mood:** soft, calm, friendly, legible — rounded enough to feel warm, restrained enough to stay professional for dense data screens (Kanban, Timesheet)
- **Google Fonts:** [Nunito Sans](https://fonts.google.com/specimen/Nunito+Sans)

**CSS Import:**
```css
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;500;600;700;800&display=swap');
```

**Type scale:**

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| Display | 40px | Bold (700) | Radar screen hero number, marketing moments |
| Heading 1 | 32px | Bold (700) | Screen titles |
| Heading 2 | 24px | SemiBold (600) | Section titles |
| Heading 3 | 18px | SemiBold (600) | Card titles |
| Body | 16px | Regular (400) | Default body text |
| Label | 14px | Medium (500) | Form labels, nav items |
| Caption | 12px | Regular (400) | Meta text, timestamps |

### Spacing Variables

| Token | Value | Usage |
|-------|-------|-------|
| `--space-xs` | `4px` | Tight gaps |
| `--space-sm` | `8px` | Icon gaps, inline spacing |
| `--space-md` | `16px` | Standard padding |
| `--space-lg` | `24px` | Section padding |
| `--space-xl` | `32px` | Large gaps |
| `--space-2xl` | `48px` | Section margins |
| `--space-3xl` | `64px` | Hero padding |

### Shadow Depths — "Soft UI Evolution"

Softer and more layered than a flat drop shadow, but not full neumorphism (no inset/embossed shadows — those hurt accessibility). Shadows use the primary green at low opacity, not neutral black.

| Level | Value | Usage |
|-------|-------|-------|
| `--shadow-sm` | `0 1px 3px rgba(95,169,135,0.08)` | Inputs, list rows |
| `--shadow-md` | `0 4px 10px rgba(95,169,135,0.12)` | Cards, buttons |
| `--shadow-lg` | `0 10px 20px rgba(95,169,135,0.16)` | Dropdowns, hover state on cards |
| `--shadow-xl` | `0 16px 32px rgba(95,169,135,0.20)` | Modals, dialogs |

Border radius: **8-12px** across the system (not full-pill, not sharp corners) — matches "Soft UI Evolution," reads as calm/professional rather than playful or corporate-sharp.

---

## Component Specs

### Buttons

```css
.btn-primary {
  background: #4E9F76;
  color: #FFFFFF;
  padding: 12px 24px;
  border-radius: 10px;
  font-weight: 600;
  box-shadow: var(--shadow-md);
  transition: all 200ms ease;
  cursor: pointer;
}
.btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: var(--shadow-lg);
}

.btn-secondary {
  background: #FFFFFF;
  color: #4E9F76;
  border: 1.5px solid #4E9F76;
  padding: 12px 24px;
  border-radius: 10px;
  font-weight: 600;
  transition: all 200ms ease;
  cursor: pointer;
}
```

### Cards

```css
.card {
  background: #FFFFFF; /* always distinct from #F5FBF8 background */
  border: 1px solid #D7E8DF;
  border-radius: 12px;
  padding: 24px;
  box-shadow: var(--shadow-md);
  transition: all 200ms ease;
}
.card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
}
```

### Inputs

Standard boxed inputs (not underline — that was v2's reference-driven style, dropped along with the coral palette).

```css
.input {
  background: #FFFFFF;
  padding: 12px 16px;
  border: 1px solid #D7E8DF;
  border-radius: 10px;
  font-size: 16px;
  transition: border-color 200ms ease;
}
.input:focus {
  border-color: #5FA987;
  outline: none;
  box-shadow: 0 0 0 3px rgba(95,169,135,0.15);
}
```

### Icons

Flat 2D icon language, never emoji. Use **Heroicons** (outline, 1.5px stroke) or **Lucide** as the single icon set across the whole product.

- Size tokens: `--icon-sm: 16px`, `--icon-md: 20px`, `--icon-lg: 24px`
- Default color: `--color-foreground`; active/selected nav icons use `--color-accent`
- Icons sit inline with text at 8px gap, never stretched or skewed

### Life Balance Radar Chart (Epic 7 — this product's signature component)

- 4-axis radar/spider chart, scale 0–10 per axis
- Axis line/fill color = the axis token above (`--color-axis-work/love/health/finance`), at ~25% fill opacity + full-opacity stroke
- Center label shows overall balance score (average or weighted)
- Tapping an axis navigates to that axis's detail/history view
- Empty/low-data state: show dashed axis line + "Chưa có dữ liệu" instead of a fake zero value

### Modals

```css
.modal-overlay {
  background: rgba(43, 51, 47, 0.45); /* foreground color at low opacity, not pure black */
  backdrop-filter: blur(4px);
}
.modal {
  background: #FFFFFF;
  border-radius: 16px;
  padding: 32px;
  box-shadow: var(--shadow-xl);
  max-width: 500px;
  width: 90%;
}
```

---

## Style Guidelines

**Style:** Soft UI Evolution — modern, accessible evolution of neumorphism/soft-UI. Chosen because the style database recommends it specifically for "health/wellness + modern business tools," matching this product's dual nature (freelancer work tool + personal life-balance tracker).

**Keywords:** soft layered shadows (not flat, not embossed), pastel/desaturated sage-green palette, 8-12px border radius, calm and legible, WCAG AA+, subtle 200-300ms transitions, icon-heavy (never emoji)

**Best For:** Hybrid productivity + wellness apps, modern SaaS that wants to feel calm rather than corporate or playful

**Key Effects:** Green-tinted soft shadows; hover = subtle lift + shadow bloom; no gradients on data-dense screens (gradients, if used at all, are reserved for the radar chart's axis fills); fast, restrained motion

> **Why this direction (v3):** v1 (auto-generated indigo) was functionally fine but felt generic/unfinished. v2 (coral/pink, from a user-provided e-commerce reference) looked good in isolation but was too vivid for an app used daily across dense data screens (Kanban, Timesheet). After discussing tradeoffs, the user chose a custom soft pastel green — semantically fitting ("balance," "growth," health) and calmer for prolonged daily use. This is the approved, final direction until the user says otherwise.

---

## Anti-Patterns (Do NOT Use)

- ❌ **Emojis as icons** — Use SVG icons (Heroicons, Lucide)
- ❌ **Missing cursor:pointer** — All clickable elements must have cursor:pointer
- ❌ **Layout-shifting hovers** — Avoid scale transforms that shift layout
- ❌ **Low contrast text** — Maintain 4.5:1 minimum contrast ratio
- ❌ **Instant state changes** — Always use transitions (150-300ms)
- ❌ **Invisible focus states** — Focus states must be visible for a11y
- ❌ **Raw/saturated green** (`#22C55E`, `#16A34A`, etc.) — always use the muted brand green tokens above
- ❌ **Full-page vivid gradients on data screens** — gradients are reserved for the radar chart only

---

## Pre-Delivery Checklist

Before delivering any UI code, verify:

- [ ] No emojis used as icons (use SVG instead)
- [ ] All icons from consistent icon set (Heroicons/Lucide)
- [ ] `cursor-pointer` on all clickable elements
- [ ] Hover states with smooth transitions (150-300ms)
- [ ] Text contrast 4.5:1 minimum against `#F5FBF8` and `#FFFFFF` backgrounds
- [ ] Focus states visible for keyboard navigation
- [ ] `prefers-reduced-motion` respected
- [ ] Responsive: 375px, 768px, 1024px, 1440px
- [ ] No content hidden behind fixed navbars
- [ ] No horizontal scroll on mobile
- [ ] Radar chart axis colors match the 4 axis tokens exactly, not ad-hoc colors
