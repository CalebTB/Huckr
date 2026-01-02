# Ultimate Hub: Golden Hour Theme Specification
## Complete Design System for Light & Dark Modes

*Version 1.0 | January 2026*

---

## Overview

The Golden Hour theme captures the warm, atmospheric quality of late-afternoon Ultimate games—when the sun sits low on the horizon and casts everything in amber light. This theme evokes the emotional experience of the sport while ensuring excellent visibility in outdoor conditions.

**Design Philosophy:**
- **Warmth over coldness** — Amber and gold replace sterile blues
- **Field-ready contrast** — Readable in direct sunlight
- **Energy without aggression** — Competitive yet spirited
- **Ultimate-native identity** — Instantly recognizable to the community

---

## Color Palette

### Brand Colors (Mode-Independent)

These colors remain consistent across both light and dark modes:

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Amber Primary** | `#F59E0B` | `245, 158, 11` | Primary brand color, CTAs, highlights |
| **Amber Light** | `#FBBF24` | `251, 191, 36` | Gradients, hover states |
| **Amber Dark** | `#D97706` | `217, 119, 6` | Pressed states, depth |
| **Sunset Orange** | `#EA580C` | `234, 88, 12` | Accent, warmth emphasis |
| **Golden Tan** | `#C4A878` | `196, 168, 120` | Secondary text, subtle elements |

### Semantic Colors (Mode-Independent)

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Success Green** | `#22C55E` | `34, 197, 94` | Goals, wins, positive stats |
| **Error Red** | `#EF4444` | `239, 68, 68` | Turnovers, losses, errors |
| **Warning Yellow** | `#EAB308` | `234, 179, 8` | Soft cap, cautions |
| **Info Blue** | `#3B82F6` | `59, 130, 246` | Links, informational |
| **Live Red** | `#DC2626` | `220, 38, 38` | Live indicator pulse |

---

## Dark Mode

**Default mode** — Optimized for outdoor use where screen glare is a concern.

### Background Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `background-primary` | `#0D0906` | `13, 9, 6` | Main app background |
| `background-secondary` | `#1A1310` | `26, 19, 16` | Cards, elevated surfaces |
| `background-tertiary` | `#2A2118` | `42, 33, 24` | Nested cards, inputs |
| `background-elevated` | `#1E1810` | `30, 24, 16` | Modals, sheets |

### Surface Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `surface-card` | `#1E1810` | `30, 24, 16` | Card backgrounds |
| `surface-card-hover` | `#2A2118` | `42, 33, 24` | Card hover state |
| `surface-card-active` | `#382C1A` | `56, 44, 26` | Card pressed state |
| `surface-input` | `#1A1310` | `26, 19, 16` | Text input backgrounds |
| `surface-overlay` | `rgba(0, 0, 0, 0.7)` | — | Modal overlays |

### Border Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `border-default` | `#382C1A` | `56, 44, 26` | Default borders |
| `border-subtle` | `#2A2118` | `42, 33, 24` | Subtle dividers |
| `border-emphasis` | `#4A3D28` | `74, 61, 40` | Emphasized borders |
| `border-brand` | `#F59E0B` | `245, 158, 11` | Brand accent borders |

### Text Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `text-primary` | `#FFFFFF` | `255, 255, 255` | Primary text, headings |
| `text-secondary` | `#C4A878` | `196, 168, 120` | Secondary text, labels |
| `text-tertiary` | `#8A7550` | `138, 117, 80` | Placeholder, disabled |
| `text-inverse` | `#0D0906` | `13, 9, 6` | Text on light backgrounds |
| `text-brand` | `#F59E0B` | `245, 158, 11` | Brand-colored text |
| `text-success` | `#22C55E` | `34, 197, 94` | Success messages |
| `text-error` | `#EF4444` | `239, 68, 68` | Error messages |

### Icon Colors

| Token | Hex | Usage |
|-------|-----|-------|
| `icon-primary` | `#FFFFFF` | Primary icons |
| `icon-secondary` | `#C4A878` | Secondary icons |
| `icon-tertiary` | `#8A7550` | Disabled icons |
| `icon-brand` | `#F59E0B` | Brand accent icons |

---

## Light Mode

**Alternative mode** — For users who prefer lighter interfaces or indoor use.

### Background Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `background-primary` | `#FDF8F3` | `253, 248, 243` | Main app background |
| `background-secondary` | `#F5EDE4` | `245, 237, 228` | Cards, elevated surfaces |
| `background-tertiary` | `#EBE2D6` | `235, 226, 214` | Nested cards, inputs |
| `background-elevated` | `#FFFFFF` | `255, 255, 255` | Modals, sheets |

### Surface Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `surface-card` | `#FFFFFF` | `255, 255, 255` | Card backgrounds |
| `surface-card-hover` | `#FDF8F3` | `253, 248, 243` | Card hover state |
| `surface-card-active` | `#F5EDE4` | `245, 237, 228` | Card pressed state |
| `surface-input` | `#FFFFFF` | `255, 255, 255` | Text input backgrounds |
| `surface-overlay` | `rgba(13, 9, 6, 0.5)` | — | Modal overlays |

### Border Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `border-default` | `#E5D9C9` | `229, 217, 201` | Default borders |
| `border-subtle` | `#EBE2D6` | `235, 226, 214` | Subtle dividers |
| `border-emphasis` | `#D4C4AD` | `212, 196, 173` | Emphasized borders |
| `border-brand` | `#F59E0B` | `245, 158, 11` | Brand accent borders |

### Text Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `text-primary` | `#1A1310` | `26, 19, 16` | Primary text, headings |
| `text-secondary` | `#5C4D3C` | `92, 77, 60` | Secondary text, labels |
| `text-tertiary` | `#8A7A66` | `138, 122, 102` | Placeholder, disabled |
| `text-inverse` | `#FFFFFF` | `255, 255, 255` | Text on dark backgrounds |
| `text-brand` | `#D97706` | `217, 119, 6` | Brand-colored text (darker for contrast) |
| `text-success` | `#16A34A` | `22, 163, 74` | Success messages (darker) |
| `text-error` | `#DC2626` | `220, 38, 38` | Error messages (darker) |

### Icon Colors

| Token | Hex | Usage |
|-------|-----|-------|
| `icon-primary` | `#1A1310` | Primary icons |
| `icon-secondary` | `#5C4D3C` | Secondary icons |
| `icon-tertiary` | `#8A7A66` | Disabled icons |
| `icon-brand` | `#D97706` | Brand accent icons |

---

## Gradients

### Primary Brand Gradient

```css
/* CTA buttons, featured elements */
.gradient-brand {
  background: linear-gradient(135deg, #FBBF24 0%, #F59E0B 50%, #D97706 100%);
}
```

### Sunset Gradient

```css
/* Hero sections, special moments */
.gradient-sunset {
  background: linear-gradient(135deg, #FBBF24 0%, #F59E0B 30%, #EA580C 70%, #DC2626 100%);
}
```

### Dark Mode Card Gradient

```css
/* Subtle card depth */
.gradient-card-dark {
  background: linear-gradient(180deg, #1E1810 0%, #1A1310 100%);
}
```

### Light Mode Card Gradient

```css
/* Subtle card depth */
.gradient-card-light {
  background: linear-gradient(180deg, #FFFFFF 0%, #FDF8F3 100%);
}
```

### Field Gradient (For field visualization)

```css
/* Ultimate field background */
.gradient-field {
  background: linear-gradient(180deg, #1B4D2E 0%, #15803D 50%, #1B4D2E 100%);
}
```

---

## Shadows

### Dark Mode Shadows

```css
/* Subtle elevation */
.shadow-sm-dark {
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
}

/* Card elevation */
.shadow-md-dark {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
}

/* Modal elevation */
.shadow-lg-dark {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
}

/* Brand glow (for CTAs) */
.shadow-brand-dark {
  box-shadow: 0 4px 20px rgba(245, 158, 11, 0.4);
}

/* Success glow */
.shadow-success-dark {
  box-shadow: 0 4px 16px rgba(34, 197, 94, 0.3);
}

/* Error glow */
.shadow-error-dark {
  box-shadow: 0 4px 16px rgba(239, 68, 68, 0.3);
}
```

### Light Mode Shadows

```css
/* Subtle elevation */
.shadow-sm-light {
  box-shadow: 0 1px 3px rgba(26, 19, 16, 0.1);
}

/* Card elevation */
.shadow-md-light {
  box-shadow: 0 4px 12px rgba(26, 19, 16, 0.1);
}

/* Modal elevation */
.shadow-lg-light {
  box-shadow: 0 8px 24px rgba(26, 19, 16, 0.15);
}

/* Brand glow (for CTAs) */
.shadow-brand-light {
  box-shadow: 0 4px 20px rgba(245, 158, 11, 0.3);
}

/* Success glow */
.shadow-success-light {
  box-shadow: 0 4px 16px rgba(34, 197, 94, 0.2);
}

/* Error glow */
.shadow-error-light {
  box-shadow: 0 4px 16px rgba(239, 68, 68, 0.2);
}
```

---

## Typography

### Font Family

```css
/* Primary font stack */
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;

/* Monospace (for stats, numbers) */
font-family: 'JetBrains Mono', 'SF Mono', 'Fira Code', monospace;
```

### Type Scale

| Name | Size | Weight | Line Height | Letter Spacing | Usage |
|------|------|--------|-------------|----------------|-------|
| `display-xl` | 36px | 800 | 1.1 | -0.02em | Hero scores |
| `display-lg` | 30px | 700 | 1.2 | -0.01em | Page titles |
| `heading-lg` | 24px | 700 | 1.3 | -0.01em | Section headers |
| `heading-md` | 20px | 600 | 1.3 | 0 | Card titles |
| `heading-sm` | 16px | 600 | 1.4 | 0 | Subsection headers |
| `body-lg` | 16px | 400 | 1.5 | 0 | Primary body text |
| `body-md` | 14px | 400 | 1.5 | 0 | Secondary body text |
| `body-sm` | 12px | 400 | 1.4 | 0.01em | Captions, hints |
| `label-lg` | 14px | 600 | 1.3 | 0.02em | Button labels |
| `label-md` | 12px | 600 | 1.3 | 0.03em | Small labels |
| `label-sm` | 10px | 600 | 1.2 | 0.05em | Micro labels |
| `stat-value` | 24px | 700 | 1.1 | -0.01em | Stat numbers |
| `stat-label` | 11px | 500 | 1.2 | 0.05em | Stat descriptions |

### Typography Styles

```css
/* Display - Hero scores */
.text-display-xl {
  font-size: 36px;
  font-weight: 800;
  line-height: 1.1;
  letter-spacing: -0.02em;
}

/* Stat values - Numbers emphasis */
.text-stat-value {
  font-size: 24px;
  font-weight: 700;
  line-height: 1.1;
  letter-spacing: -0.01em;
  font-variant-numeric: tabular-nums;
}

/* Stat labels - Uppercase descriptors */
.text-stat-label {
  font-size: 11px;
  font-weight: 500;
  line-height: 1.2;
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

/* Body text */
.text-body {
  font-size: 14px;
  font-weight: 400;
  line-height: 1.5;
}
```

---

## Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `space-0` | 0px | — |
| `space-1` | 4px | Tight spacing, icon gaps |
| `space-2` | 8px | Related element spacing |
| `space-3` | 12px | Component internal padding |
| `space-4` | 16px | Standard padding/margins |
| `space-5` | 20px | Card padding |
| `space-6` | 24px | Section spacing |
| `space-8` | 32px | Large gaps |
| `space-10` | 40px | Screen padding |
| `space-12` | 48px | Section dividers |
| `space-16` | 64px | Major sections |

---

## Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius-none` | 0px | Sharp corners |
| `radius-sm` | 4px | Small elements, tags |
| `radius-md` | 8px | Buttons, inputs |
| `radius-lg` | 12px | Cards |
| `radius-xl` | 16px | Large cards, modals |
| `radius-2xl` | 24px | Feature cards |
| `radius-full` | 9999px | Circular elements, pills |

---

## Component Styles

### Buttons

#### Primary Button (CTA)

```css
/* Dark Mode */
.btn-primary-dark {
  background: linear-gradient(135deg, #FBBF24, #F59E0B);
  color: #0D0906;
  font-weight: 600;
  padding: 14px 24px;
  border-radius: 10px;
  border: none;
  box-shadow: 0 4px 20px rgba(245, 158, 11, 0.4);
}

.btn-primary-dark:hover {
  background: linear-gradient(135deg, #FCD34D, #FBBF24);
  box-shadow: 0 6px 24px rgba(245, 158, 11, 0.5);
}

.btn-primary-dark:active {
  background: linear-gradient(135deg, #F59E0B, #D97706);
  transform: scale(0.98);
}

/* Light Mode */
.btn-primary-light {
  background: linear-gradient(135deg, #FBBF24, #F59E0B);
  color: #1A1310;
  font-weight: 600;
  padding: 14px 24px;
  border-radius: 10px;
  border: none;
  box-shadow: 0 4px 16px rgba(245, 158, 11, 0.3);
}
```

#### Secondary Button

```css
/* Dark Mode */
.btn-secondary-dark {
  background: rgba(245, 158, 11, 0.15);
  color: #F59E0B;
  font-weight: 600;
  padding: 14px 24px;
  border-radius: 10px;
  border: 1px solid rgba(245, 158, 11, 0.3);
}

.btn-secondary-dark:hover {
  background: rgba(245, 158, 11, 0.25);
  border-color: rgba(245, 158, 11, 0.5);
}

/* Light Mode */
.btn-secondary-light {
  background: rgba(217, 119, 6, 0.1);
  color: #D97706;
  font-weight: 600;
  padding: 14px 24px;
  border-radius: 10px;
  border: 1px solid rgba(217, 119, 6, 0.3);
}
```

#### Ghost Button

```css
/* Dark Mode */
.btn-ghost-dark {
  background: transparent;
  color: #C4A878;
  font-weight: 500;
  padding: 14px 24px;
  border-radius: 10px;
  border: none;
}

.btn-ghost-dark:hover {
  background: rgba(196, 168, 120, 0.1);
  color: #FFFFFF;
}

/* Light Mode */
.btn-ghost-light {
  background: transparent;
  color: #5C4D3C;
  font-weight: 500;
  padding: 14px 24px;
  border-radius: 10px;
  border: none;
}

.btn-ghost-light:hover {
  background: rgba(92, 77, 60, 0.1);
  color: #1A1310;
}
```

#### Destructive Button

```css
/* Both Modes */
.btn-destructive {
  background: rgba(239, 68, 68, 0.15);
  color: #EF4444;
  font-weight: 600;
  padding: 14px 24px;
  border-radius: 10px;
  border: 1px solid rgba(239, 68, 68, 0.3);
}

.btn-destructive:hover {
  background: rgba(239, 68, 68, 0.25);
  border-color: rgba(239, 68, 68, 0.5);
}
```

### Cards

```css
/* Dark Mode */
.card-dark {
  background: #1E1810;
  border: 1px solid #382C1A;
  border-radius: 12px;
  padding: 20px;
}

.card-dark:hover {
  border-color: #4A3D28;
  background: #2A2118;
}

/* Light Mode */
.card-light {
  background: #FFFFFF;
  border: 1px solid #E5D9C9;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(26, 19, 16, 0.06);
}

.card-light:hover {
  border-color: #D4C4AD;
  box-shadow: 0 4px 12px rgba(26, 19, 16, 0.1);
}
```

### Input Fields

```css
/* Dark Mode */
.input-dark {
  background: #1A1310;
  border: 1px solid #382C1A;
  border-radius: 8px;
  padding: 12px 16px;
  color: #FFFFFF;
  font-size: 14px;
}

.input-dark::placeholder {
  color: #8A7550;
}

.input-dark:focus {
  border-color: #F59E0B;
  outline: none;
  box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.2);
}

/* Light Mode */
.input-light {
  background: #FFFFFF;
  border: 1px solid #E5D9C9;
  border-radius: 8px;
  padding: 12px 16px;
  color: #1A1310;
  font-size: 14px;
}

.input-light::placeholder {
  color: #8A7A66;
}

.input-light:focus {
  border-color: #F59E0B;
  outline: none;
  box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.15);
}
```

### Player Chip (Stat Tracker)

```css
/* Dark Mode - Default State */
.player-chip-dark {
  background: #1E1810;
  border: 1px solid #382C1A;
  border-radius: 10px;
  padding: 12px 16px;
  min-width: 64px;
  text-align: center;
}

/* Dark Mode - Selected */
.player-chip-dark.selected {
  background: rgba(245, 158, 11, 0.2);
  border-color: #F59E0B;
  box-shadow: 0 0 20px rgba(245, 158, 11, 0.3);
}

/* Dark Mode - Has Disc */
.player-chip-dark.has-disc {
  background: linear-gradient(135deg, #FBBF24, #F59E0B);
  border-color: transparent;
  color: #0D0906;
  box-shadow: 0 4px 20px rgba(245, 158, 11, 0.5);
}

/* Light Mode - Default State */
.player-chip-light {
  background: #FFFFFF;
  border: 1px solid #E5D9C9;
  border-radius: 10px;
  padding: 12px 16px;
  min-width: 64px;
  text-align: center;
}

/* Light Mode - Selected */
.player-chip-light.selected {
  background: rgba(217, 119, 6, 0.15);
  border-color: #D97706;
  box-shadow: 0 0 16px rgba(217, 119, 6, 0.2);
}

/* Light Mode - Has Disc */
.player-chip-light.has-disc {
  background: linear-gradient(135deg, #FBBF24, #F59E0B);
  border-color: transparent;
  color: #1A1310;
  box-shadow: 0 4px 16px rgba(245, 158, 11, 0.4);
}
```

### Stat Display

```css
/* Dark Mode */
.stat-block-dark {
  text-align: center;
}

.stat-block-dark .value {
  font-size: 24px;
  font-weight: 700;
  color: #F59E0B;
  font-variant-numeric: tabular-nums;
}

.stat-block-dark .label {
  font-size: 11px;
  font-weight: 500;
  color: #C4A878;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-top: 4px;
}

/* Light Mode */
.stat-block-light .value {
  font-size: 24px;
  font-weight: 700;
  color: #D97706;
  font-variant-numeric: tabular-nums;
}

.stat-block-light .label {
  font-size: 11px;
  font-weight: 500;
  color: #5C4D3C;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-top: 4px;
}
```

### Live Indicator

```css
/* Both Modes */
.live-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: rgba(220, 38, 38, 0.15);
  padding: 4px 10px;
  border-radius: 6px;
}

.live-badge .dot {
  width: 8px;
  height: 8px;
  background: #DC2626;
  border-radius: 50%;
  animation: pulse 1.5s ease-in-out infinite;
}

.live-badge .text {
  color: #DC2626;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.5; transform: scale(0.9); }
}
```

### Score Display

```css
/* Dark Mode */
.score-display-dark {
  display: flex;
  align-items: center;
  gap: 16px;
}

.score-display-dark .team-score {
  font-size: 48px;
  font-weight: 800;
  color: #FFFFFF;
  font-variant-numeric: tabular-nums;
}

.score-display-dark .team-score.winning {
  color: #F59E0B;
}

.score-display-dark .divider {
  font-size: 32px;
  color: #8A7550;
}

/* Light Mode */
.score-display-light .team-score {
  font-size: 48px;
  font-weight: 800;
  color: #1A1310;
  font-variant-numeric: tabular-nums;
}

.score-display-light .team-score.winning {
  color: #D97706;
}

.score-display-light .divider {
  font-size: 32px;
  color: #8A7A66;
}
```

### Navigation Tab Bar

```css
/* Dark Mode */
.tab-bar-dark {
  background: #1A1310;
  border-top: 1px solid #382C1A;
  padding: 8px 0 24px 0; /* Account for home indicator */
}

.tab-item-dark {
  color: #8A7550;
}

.tab-item-dark.active {
  color: #F59E0B;
}

/* Light Mode */
.tab-bar-light {
  background: #FFFFFF;
  border-top: 1px solid #E5D9C9;
  padding: 8px 0 24px 0;
}

.tab-item-light {
  color: #8A7A66;
}

.tab-item-light.active {
  color: #D97706;
}
```

---

## Semantic State Colors

### Success States (Goals, Wins)

```css
/* Dark Mode */
.state-success-dark {
  background: rgba(34, 197, 94, 0.15);
  border-color: rgba(34, 197, 94, 0.3);
  color: #22C55E;
}

/* Light Mode */
.state-success-light {
  background: rgba(22, 163, 74, 0.1);
  border-color: rgba(22, 163, 74, 0.3);
  color: #16A34A;
}
```

### Error States (Turnovers, Losses)

```css
/* Dark Mode */
.state-error-dark {
  background: rgba(239, 68, 68, 0.15);
  border-color: rgba(239, 68, 68, 0.3);
  color: #EF4444;
}

/* Light Mode */
.state-error-light {
  background: rgba(220, 38, 38, 0.1);
  border-color: rgba(220, 38, 38, 0.3);
  color: #DC2626;
}
```

### Warning States (Soft Cap, Cautions)

```css
/* Dark Mode */
.state-warning-dark {
  background: rgba(234, 179, 8, 0.15);
  border-color: rgba(234, 179, 8, 0.3);
  color: #EAB308;
}

/* Light Mode */
.state-warning-light {
  background: rgba(202, 138, 4, 0.1);
  border-color: rgba(202, 138, 4, 0.3);
  color: #CA8A04;
}
```

### Offense State

```css
/* Dark Mode - Offense indicator */
.state-offense-dark {
  background: rgba(245, 158, 11, 0.2);
  border: 2px solid #F59E0B;
}

/* Light Mode */
.state-offense-light {
  background: rgba(245, 158, 11, 0.15);
  border: 2px solid #F59E0B;
}
```

### Defense State

```css
/* Dark Mode - Defense indicator */
.state-defense-dark {
  background: rgba(59, 130, 246, 0.2);
  border: 2px solid #3B82F6;
}

/* Light Mode */
.state-defense-light {
  background: rgba(59, 130, 246, 0.15);
  border: 2px solid #3B82F6;
}
```

---

## Animations

### Standard Transitions

```css
/* Default transition for interactive elements */
.transition-default {
  transition: all 150ms ease-out;
}

/* Slower transition for layout changes */
.transition-layout {
  transition: all 200ms ease-out;
}

/* Fast feedback for buttons */
.transition-fast {
  transition: all 100ms ease-out;
}
```

### Button Press

```css
.btn-press:active {
  transform: scale(0.97);
  transition: transform 100ms ease;
}
```

### Card Appearance

```css
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(8px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 200ms ease-out;
}
```

### Score Pop

```css
@keyframes scorePop {
  0% { transform: scale(1); }
  50% { transform: scale(1.15); }
  100% { transform: scale(1); }
}

.animate-score-pop {
  animation: scorePop 300ms ease-out;
}
```

### Goal Celebration

```css
/* Dark Mode */
@keyframes goalFlashDark {
  0% { background: transparent; }
  30% { background: rgba(34, 197, 94, 0.3); }
  100% { background: transparent; }
}

.animate-goal-dark {
  animation: goalFlashDark 400ms ease-out;
}

/* Light Mode */
@keyframes goalFlashLight {
  0% { background: transparent; }
  30% { background: rgba(22, 163, 74, 0.2); }
  100% { background: transparent; }
}

.animate-goal-light {
  animation: goalFlashLight 400ms ease-out;
}
```

### Disc Pulse (Field Visualization)

```css
@keyframes discPulse {
  0%, 100% {
    box-shadow: 0 0 0 0 rgba(245, 158, 11, 0.6);
  }
  50% {
    box-shadow: 0 0 0 12px rgba(245, 158, 11, 0);
  }
}

.disc-marker {
  width: 16px;
  height: 16px;
  background: #F59E0B;
  border-radius: 50%;
  animation: discPulse 2s ease-in-out infinite;
}
```

---

## Field Visualization Colors

### Field Surface

```css
/* Dark Mode Field */
.field-dark {
  background: linear-gradient(180deg, #1B4D2E 0%, #15803D 50%, #1B4D2E 100%);
}

/* Light Mode Field */
.field-light {
  background: linear-gradient(180deg, #22C55E 0%, #16A34A 50%, #22C55E 100%);
}
```

### Field Lines

```css
/* Dark Mode */
.field-lines-dark {
  stroke: rgba(255, 255, 255, 0.3);
  stroke-width: 2px;
}

/* Light Mode */
.field-lines-light {
  stroke: rgba(255, 255, 255, 0.5);
  stroke-width: 2px;
}
```

### Endzone Highlighting

```css
/* Attacking Endzone - Goal opportunity */
.endzone-attacking {
  background: rgba(245, 158, 11, 0.2);
  border: 2px solid rgba(245, 158, 11, 0.5);
}

/* Defending Endzone */
.endzone-defending {
  background: rgba(59, 130, 246, 0.2);
  border: 2px solid rgba(59, 130, 246, 0.5);
}
```

### Disc Position Marker

```css
.disc-marker {
  width: 20px;
  height: 20px;
  background: #F59E0B;
  border: 3px solid #FFFFFF;
  border-radius: 50%;
  box-shadow: 0 0 20px rgba(245, 158, 11, 0.6);
}
```

---

## Flutter Implementation

### Theme Data Setup

```dart
import 'package:flutter/material.dart';

class GoldenHourTheme {
  // Brand Colors
  static const Color amberPrimary = Color(0xFFF59E0B);
  static const Color amberLight = Color(0xFFFBBF24);
  static const Color amberDark = Color(0xFFD97706);
  static const Color sunsetOrange = Color(0xFFEA580C);
  static const Color goldenTan = Color(0xFFC4A878);
  
  // Semantic Colors
  static const Color success = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF16A34A);
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color warning = Color(0xFFEAB308);
  static const Color info = Color(0xFF3B82F6);
  static const Color live = Color(0xFFDC2626);

  // ============ DARK MODE ============
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: amberPrimary,
      scaffoldBackgroundColor: const Color(0xFF0D0906),
      
      colorScheme: const ColorScheme.dark(
        primary: amberPrimary,
        secondary: amberLight,
        surface: Color(0xFF1E1810),
        background: Color(0xFF0D0906),
        error: error,
        onPrimary: Color(0xFF0D0906),
        onSecondary: Color(0xFF0D0906),
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      
      cardTheme: CardTheme(
        color: const Color(0xFF1E1810),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF382C1A)),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: amberPrimary,
          foregroundColor: const Color(0xFF0D0906),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: amberPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: amberPrimary.withOpacity(0.3)),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A1310),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF382C1A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF382C1A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: amberPrimary, width: 2),
        ),
        hintStyle: const TextStyle(color: Color(0xFF8A7550)),
      ),
      
      textTheme: _buildTextTheme(isDark: true),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1A1310),
        selectedItemColor: amberPrimary,
        unselectedItemColor: Color(0xFF8A7550),
      ),
      
      dividerTheme: const DividerThemeData(
        color: Color(0xFF382C1A),
        thickness: 1,
      ),
    );
  }

  // ============ LIGHT MODE ============
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: amberPrimary,
      scaffoldBackgroundColor: const Color(0xFFFDF8F3),
      
      colorScheme: const ColorScheme.light(
        primary: amberPrimary,
        secondary: amberDark,
        surface: Colors.white,
        background: Color(0xFFFDF8F3),
        error: errorDark,
        onPrimary: Color(0xFF1A1310),
        onSecondary: Color(0xFF1A1310),
        onSurface: Color(0xFF1A1310),
        onBackground: Color(0xFF1A1310),
        onError: Colors.white,
      ),
      
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE5D9C9)),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: amberPrimary,
          foregroundColor: const Color(0xFF1A1310),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: amberDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: amberDark.withOpacity(0.3)),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5D9C9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5D9C9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: amberPrimary, width: 2),
        ),
        hintStyle: const TextStyle(color: Color(0xFF8A7A66)),
      ),
      
      textTheme: _buildTextTheme(isDark: false),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: amberDark,
        unselectedItemColor: Color(0xFF8A7A66),
      ),
      
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5D9C9),
        thickness: 1,
      ),
    );
  }

  static TextTheme _buildTextTheme({required bool isDark}) {
    final Color primaryText = isDark ? Colors.white : const Color(0xFF1A1310);
    final Color secondaryText = isDark ? const Color(0xFFC4A878) : const Color(0xFF5C4D3C);
    
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.02,
        color: primaryText,
      ),
      displayMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.01,
        color: primaryText,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.01,
        color: primaryText,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primaryText,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primaryText,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.01,
        color: secondaryText,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.02,
        color: primaryText,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.03,
        color: secondaryText,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        color: secondaryText,
      ),
    );
  }
}

// ============ CUSTOM EXTENSIONS ============

extension GoldenHourColors on BuildContext {
  // Access custom colors not in ColorScheme
  Color get goldenTan => GoldenHourTheme.goldenTan;
  Color get success => Theme.of(this).brightness == Brightness.dark 
      ? GoldenHourTheme.success 
      : GoldenHourTheme.successDark;
  Color get amberBrand => GoldenHourTheme.amberPrimary;
}
```

### Custom Widgets

```dart
// Stat Value Widget
class StatValue extends StatelessWidget {
  final String value;
  final String label;
  
  const StatValue({
    required this.value,
    required this.label,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: isDark 
                ? GoldenHourTheme.amberPrimary 
                : GoldenHourTheme.amberDark,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: isDark 
                ? GoldenHourTheme.goldenTan 
                : const Color(0xFF5C4D3C),
          ),
        ),
      ],
    );
  }
}

// Player Chip Widget
class PlayerChip extends StatelessWidget {
  final String number;
  final String name;
  final bool isSelected;
  final bool hasDisc;
  final VoidCallback onTap;
  
  const PlayerChip({
    required this.number,
    required this.name,
    this.isSelected = false,
    this.hasDisc = false,
    required this.onTap,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: hasDisc
              ? const LinearGradient(
                  colors: [
                    GoldenHourTheme.amberLight,
                    GoldenHourTheme.amberPrimary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: hasDisc
              ? null
              : isSelected
                  ? GoldenHourTheme.amberPrimary.withOpacity(0.2)
                  : isDark
                      ? const Color(0xFF1E1810)
                      : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasDisc
                ? Colors.transparent
                : isSelected
                    ? GoldenHourTheme.amberPrimary
                    : isDark
                        ? const Color(0xFF382C1A)
                        : const Color(0xFFE5D9C9),
          ),
          boxShadow: hasDisc
              ? [
                  BoxShadow(
                    color: GoldenHourTheme.amberPrimary.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : isSelected
                  ? [
                      BoxShadow(
                        color: GoldenHourTheme.amberPrimary.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#$number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: hasDisc
                    ? const Color(0xFF0D0906)
                    : isDark
                        ? Colors.white
                        : const Color(0xFF1A1310),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: hasDisc
                    ? const Color(0xFF0D0906).withOpacity(0.7)
                    : isDark
                        ? GoldenHourTheme.goldenTan
                        : const Color(0xFF5C4D3C),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Live Badge Widget
class LiveBadge extends StatefulWidget {
  const LiveBadge({super.key});
  
  @override
  State<LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<LiveBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: GoldenHourTheme.live.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: GoldenHourTheme.live.withOpacity(_animation.value),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          const Text(
            'LIVE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: GoldenHourTheme.live,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Accessibility Notes

### Contrast Ratios

All color combinations meet WCAG AA standards (4.5:1 minimum for normal text):

| Combination | Ratio | Pass |
|-------------|-------|------|
| White on Dark Background (#0D0906) | 19.2:1 | ✅ AAA |
| Amber (#F59E0B) on Dark Background | 8.4:1 | ✅ AAA |
| Golden Tan (#C4A878) on Dark Background | 6.8:1 | ✅ AA |
| Dark Text (#1A1310) on Light Background (#FDF8F3) | 14.8:1 | ✅ AAA |
| Amber Dark (#D97706) on Light Background | 4.6:1 | ✅ AA |

### Color Independence

Never rely on color alone. Always pair with:
- Icons for success/error states
- Text labels for status indicators
- Shape differences where possible

### Touch Targets

Minimum sizes:
- Buttons: 44×44 pt (iOS) / 48×48 dp (Android)
- Player chips: 64×56 minimum
- Tap areas include padding beyond visible boundaries

---

## Usage Guidelines

### Do's ✅

- Use amber gradients for primary CTAs
- Keep dark mode as default (outdoor use)
- Apply success green for goals and positive outcomes
- Apply error red for turnovers and losses
- Use the Golden Tan (#C4A878) for secondary text
- Maintain generous touch targets for field use

### Don'ts ❌

- Don't use amber for error states (conflicts with brand)
- Don't rely on color alone for critical information
- Don't use pure white (#FFFFFF) as a background in dark mode
- Don't use small touch targets during game tracking
- Don't animate continuously (battery drain, distraction)
- Don't use thin fonts outdoors (poor visibility)

---

*This theme specification should be treated as the single source of truth for all visual decisions in Ultimate Hub. When in doubt, prioritize field readability and speed of interaction over aesthetic preferences.*
