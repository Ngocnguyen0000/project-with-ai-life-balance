# Design System Master File

> **LOGIC:** When building a specific page, first check `design-system/pages/[page-name].md`.
> If that file exists, its rules **override** this Master file.
> If not, strictly follow the rules below.

---

**Project:** Life Balance
**Generated:** 2026-07-11 00:40:40 (superseded 2026-07-11 — palette/style replaced per user reference image)
**Category:** Freelancer Platform

---

## Global Rules

### Color Palette (v2 — coral/pink gradient, per user reference image)

| Role | Hex | CSS Variable |
|------|-----|--------------|
| Primary | `#FF6B7A` | `--color-primary` |
| On Primary | `#FFFFFF` | `--color-on-primary` |
| Accent/CTA (solid) | `#FF5F6D` | `--color-accent` |
| Accent gradient start | `#FF9A8B` | `--color-accent-gradient-start` |
| Accent gradient end | `#FF5F6D` | `--color-accent-gradient-end` |
| Background | `#FFF1F1` | `--color-background` |
| Surface (cards) | `#FFFFFF` | `--color-surface` |
| Foreground | `#33262A` | `--color-foreground` |
| Muted | `#FFE3E6` | `--color-muted` |
| Border | `#FFD3D9` | `--color-border` |
| Destructive | `#E63946` | `--color-destructive` |
| Ring | `#FF6B7A` | `--color-ring` |

**Color Notes:** Warm coral/pink palette replacing the earlier indigo system, per a reference mobile-app mockup (gradient coral background, white floating cards, pill gradient buttons, underline inputs). `background` (#FFF1F1) is a soft flat blush for data-dense app screens (Dashboard, Kanban, Timesheet) — readability first. Marketing-flavored screens (auth/onboarding) may use the full vivid two-stop gradient (`accent-gradient-start` → `accent-gradient-end`, diagonal) as the page background instead of flat `background`, matching the reference exactly. Cards are always white (`surface`) with a tinted coral shadow, never gradient-filled (gradient is reserved for buttons and small decorative headers only, so data stays readable).

### Typography (v2)

- **Heading Font:** Varela Round
- **Body Font:** Nunito Sans
- **Mood:** soft, rounded, friendly, approachable, warm — matches the reference's rounded corners and gradient card style
- **Google Fonts:** [Varela Round + Nunito Sans](https://fonts.google.com/share?selection.family=Nunito+Sans:wght@300;400;500;600;700|Varela+Round)

**CSS Import:**
```css
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;500;600;700&family=Varela+Round&display=swap');
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

### Buttons (v2 — full pill, gradient fill)

```css
/* Primary Button — pill shape, coral gradient, per reference */
.btn-primary {
  background: linear-gradient(135deg, #FF9A8B 0%, #FF5F6D 100%);
  color: white;
  padding: 14px 32px;
  border-radius: 999px; /* full pill, not 8px */
  font-weight: 700;
  font-family: 'Varela Round';
  box-shadow: 0 8px 20px rgba(255, 95, 109, 0.35); /* colored shadow, not neutral */
  transition: all 200ms ease;
  cursor: pointer;
}

.btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: 0 10px 24px rgba(255, 95, 109, 0.45);
}

/* Secondary Button */
.btn-secondary {
  background: white;
  color: #FF6B7A;
  border: 2px solid #FF6B7A;
  padding: 12px 30px;
  border-radius: 999px;
  font-weight: 700;
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

### Inputs (v2 — underline style with icon + small-caps label, per reference)

```html
<label class="input-label">CARDHOLDER NAME</label>
<div class="input-underline">
  <svg class="input-icon"><!-- 16px icon --></svg>
  <input placeholder="Lorem Ipsum" />
</div>
```

```css
.input-label {
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: #33262A99; /* foreground at ~60% */
  margin-bottom: 6px;
  display: block;
}

.input-underline {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 2px;
  border: none;
  border-bottom: 1.5px solid #FFD3D9; /* border token, bottom only — no box */
  background: transparent;
  transition: border-color 200ms ease;
}

.input-underline:focus-within {
  border-bottom-color: #FF6B7A;
}

.input-icon {
  width: 16px;
  height: 16px;
  color: #FF6B7A;
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

**Style (v2):** Soft Gradient / Rounded Consumer — replaces the earlier "Enterprise SaaS indigo" direction after the user shared a reference mockup (coral/pink checkout-flow UI) and asked to match it directly.

**Keywords:** full-pill rounded buttons, coral-to-salmon gradient fills, white floating cards on a soft blush canvas, underline inputs with icon + uppercase micro-label, rounded friendly typography (Varela Round/Nunito Sans), colored (coral) drop shadows, illustration-friendly

**Best For:** Consumer-facing mobile apps, checkout/onboarding flows, friendly SaaS tools that want to feel approachable rather than corporate

**Key Effects:** Coral-tinted shadows (not neutral, not indigo); gradient reserved for buttons + optional card headers/hero bands (never full-page for data-dense screens); hover = lift + shadow bloom; fast loading; icon-heavy (simple line icons, never emoji)

> **Why the second override:** first pass (Flat Design → Enterprise SaaS indigo) was functionally sound per the skill's auto-recommendation, but didn't match the user's actual taste. Design taste is ultimately a subjective creative-direction call — once the user provided a concrete reference image, that reference takes priority over the algorithmic recommendation. Keep the accessibility/depth/icon discipline from the first override; swap only the palette, shape language (pill vs 8px radius), and input style to match the reference.

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
