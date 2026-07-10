# Design System Master File

> **LOGIC:** When building a specific page, first check `design-system/pages/[page-name].md`.
> If that file exists, its rules **override** this Master file.
> If not, strictly follow the rules below.

---

**Project:** Life Balance
**Generated:** 2026-07-11 00:40:40
**Category:** Freelancer Platform

---

## Global Rules

### Color Palette

| Role | Hex | CSS Variable |
|------|-----|--------------|
| Primary | `#6366F1` | `--color-primary` |
| On Primary | `#FFFFFF` | `--color-on-primary` |
| Secondary | `#818CF8` | `--color-secondary` |
| Accent/CTA | `#16A34A` | `--color-accent` |
| Background | `#EEF2FF` | `--color-background` |
| Foreground | `#312E81` | `--color-foreground` |
| Muted | `#EBEFF9` | `--color-muted` |
| Border | `#C7D2FE` | `--color-border` |
| Destructive | `#DC2626` | `--color-destructive` |
| Ring | `#6366F1` | `--color-ring` |

**Color Notes:** Creative indigo + hire green [Accent adjusted from #22C55E for WCAG 3:1]. `background` (#EEF2FF) is the page/app canvas; `muted` (#EBEFF9) is for subtle secondary surfaces (sidebar, disabled fills); actual cards/inputs use white (`#FFFFFF`, not a separate token) with a tinted shadow so they float above the canvas — see Component Specs.

### Typography

- **Heading Font:** Plus Jakarta Sans
- **Body Font:** Plus Jakarta Sans
- **Mood:** enterprise, saas, b2b, professional, indigo, modern, approachable, legible, ios dynamic type, android scaling
- **Google Fonts:** [Plus Jakarta Sans + Plus Jakarta Sans](https://fonts.google.com/share?selection.family=Plus+Jakarta+Sans:ital,wght@0,400;0,600;0,700;0,800;1,400)

**CSS Import:**
```css
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:ital,wght@0,400;0,600;0,700;0,800;1,400&display=swap');
```

### Spacing Variables

| Token | Value | Usage |
|-------|-------|-------|
| `--space-xs` | `4px` / `0.25rem` | Tight gaps |
| `--space-sm` | `8px` / `0.5rem` | Icon gaps, inline spacing |
| `--space-md` | `16px` / `1rem` | Standard padding |
| `--space-lg` | `24px` / `1.5rem` | Section padding |
| `--space-xl` | `32px` / `2rem` | Large gaps |
| `--space-2xl` | `48px` / `3rem` | Section margins |
| `--space-3xl` | `64px` / `4rem` | Hero padding |

### Shadow Depths

> **Override note:** the auto-generated base style ("Flat Design") defaults to no shadows. This project intentionally overrides that — cards float on a tinted indigo background, so shadows use the brand color (not neutral black) for a polished, non-flat feel similar to Linear/Notion.

| Level | Value | Usage |
|-------|-------|-------|
| `--shadow-sm` | `0 1px 2px rgba(99,102,241,0.06)` | Subtle lift (inputs, list rows) |
| `--shadow-md` | `0 4px 12px rgba(99,102,241,0.10)` | Cards, buttons |
| `--shadow-lg` | `0 10px 24px rgba(99,102,241,0.14)` | Dropdowns, popovers, hover state on cards |
| `--shadow-xl` | `0 20px 40px rgba(99,102,241,0.18)` | Modals, dialogs |

---

## Component Specs

### Buttons

```css
/* Primary Button */
.btn-primary {
  background: #16A34A;
  color: white;
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: 600;
  transition: all 200ms ease;
  cursor: pointer;
}

.btn-primary:hover {
  opacity: 0.9;
  transform: translateY(-1px);
}

/* Secondary Button */
.btn-secondary {
  background: transparent;
  color: #6366F1;
  border: 2px solid #6366F1;
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: 600;
  transition: all 200ms ease;
  cursor: pointer;
}
```

### Cards

Cards use a **white surface** (`#FFFFFF`) distinct from the page background (`#EEF2FF`) so they visibly float, plus a tinted shadow for depth — this is the main fix for the "flat/no depth" feedback.

```css
.card {
  background: #FFFFFF; /* distinct from page background for float effect */
  border: 1px solid #C7D2FE;
  border-radius: 12px;
  padding: 24px;
  box-shadow: var(--shadow-md);
  transition: all 200ms ease;
  cursor: pointer;
}

.card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
}
```

### Inputs

```css
.input {
  background: #FFFFFF;
  padding: 12px 16px;
  border: 1px solid #C7D2FE;
  border-radius: 8px;
  font-size: 16px;
  transition: border-color 200ms ease;
}

.input:focus {
  border-color: #6366F1;
  outline: none;
  box-shadow: 0 0 0 3px #6366F120;
}
```

### Icons

Flat 2D icon language, but never emoji. Use **Heroicons** (outline, 1.5px stroke) or **Lucide** as the single icon set across the whole product.

- Size tokens: `--icon-sm: 16px`, `--icon-md: 20px`, `--icon-lg: 24px`
- Default color: `--color-foreground` (`#312E81`); active/selected nav icons use `--color-accent` (`#16A34A`)
- Icons sit inline with text at 8px gap (`--space-sm`), never stretched or skewed
- Sidebar nav, empty states, and stat cards should always pair an icon with its label — icon-only is reserved for well-known actions (close, search) with an `aria-label`

### Modals

```css
.modal-overlay {
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(4px);
}

.modal {
  background: white;
  border-radius: 16px;
  padding: 32px;
  box-shadow: var(--shadow-xl);
  max-width: 500px;
  width: 90%;
}
```

---

## Style Guidelines

**Style:** Flat Design, overridden with light depth ("Enterprise SaaS" polish)

**Keywords:** 2D, minimalist, bold colors, clean lines, simple shapes, typography-focused, modern, icon-heavy, tinted shadows, floating cards

**Best For:** Web apps, mobile apps, cross-platform, startup MVPs, user-friendly, SaaS, dashboards, corporate

**Key Effects:** Colored (indigo-tinted) shadows on cards/buttons — not neutral gray, not shadow-free; simple hover (color/opacity shift + subtle lift); fast loading; clean transitions (150-200ms ease); icon-heavy (Heroicons/Lucide, never emoji)

> **Why the override:** the base "Flat Design" style forbids shadows entirely, which read as bare/unfinished in review. Keeping flat 2D shapes and bold typography, but adding tinted shadows + a white card surface on top of the light indigo background restores depth without turning into skeuomorphism.

### Page Pattern

**Pattern Name:** App Store Style Landing

- **Conversion Strategy:** Show real screenshots. Include ratings (4.5+ stars). QR code for mobile. Platform-specific CTAs.
- **CTA Placement:** Download buttons prominent (App Store + Play Store) throughout
- **Section Order:** 1. Hero with device mockup, 2. Screenshots carousel, 3. Features with icons, 4. Reviews/ratings, 5. Download CTAs

---

## Anti-Patterns (Do NOT Use)

- ❌ Poor profiles
- ❌ No reviews

### Additional Forbidden Patterns

- ❌ **Emojis as icons** — Use SVG icons (Heroicons, Lucide, Simple Icons)
- ❌ **Missing cursor:pointer** — All clickable elements must have cursor:pointer
- ❌ **Layout-shifting hovers** — Avoid scale transforms that shift layout
- ❌ **Low contrast text** — Maintain 4.5:1 minimum contrast ratio
- ❌ **Instant state changes** — Always use transitions (150-300ms)
- ❌ **Invisible focus states** — Focus states must be visible for a11y

---

## Pre-Delivery Checklist

Before delivering any UI code, verify:

- [ ] No emojis used as icons (use SVG instead)
- [ ] All icons from consistent icon set (Heroicons/Lucide)
- [ ] `cursor-pointer` on all clickable elements
- [ ] Hover states with smooth transitions (150-300ms)
- [ ] Light mode: text contrast 4.5:1 minimum
- [ ] Focus states visible for keyboard navigation
- [ ] `prefers-reduced-motion` respected
- [ ] Responsive: 375px, 768px, 1024px, 1440px
- [ ] No content hidden behind fixed navbars
- [ ] No horizontal scroll on mobile
