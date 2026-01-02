# 🌅 Golden Hour Theme Style Guide

> **Warm sunset & amber glow** — A rich, luxurious theme inspired by the magical light of golden hour photography.

---

## Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [Color Palette](#color-palette)
3. [Typography](#typography)
4. [Components](#components)
5. [Icons & Imagery](#icons--imagery)
6. [Animations & Effects](#animations--effects)
7. [Accessibility](#accessibility)
8. [Implementation Examples](#implementation-examples)

---

## Design Philosophy

The Golden Hour theme captures the warmth and richness of sunset light. It should feel:

- **Warm & Inviting** — Like the comfort of a sunset
- **Luxurious** — Gold accents convey premium quality
- **Organic** — Deep browns and ambers feel natural
- **Confident** — Bold amber highlights command attention

### Mood Keywords
`sunset` · `amber` · `warmth` · `luxury` · `golden` · `rich` · `cozy` · `premium`

---

## Color Palette

### Dark Mode (Primary)

| Role | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Background** | `#0C0A05` | `12, 10, 5` | Main app background |
| **Surface** | `#141008` | `20, 16, 8` | Elevated surfaces, modals |
| **Card** | `#1E1810` | `30, 24, 16` | Cards, containers |
| **Card Border** | `#382C1A` | `56, 44, 26` | Subtle borders |
| **Text Primary** | `#FFFFFF` | `255, 255, 255` | Headlines, important text |
| **Text Secondary** | `#C4A878` | `196, 168, 120` | Body text, descriptions |
| **Text Tertiary** | `#8A7550` | `138, 117, 80` | Captions, placeholders |
| **Accent** | `#F59E0B` | `245, 158, 11` | Primary actions, highlights |
| **Accent Light** | `#FBBF24` | `251, 191, 36` | Hover states, gradients |
| **Accent Muted** | `rgba(245,158,11,0.15)` | — | Backgrounds, overlays |
| **Success** | `#22C55E` | `34, 197, 94` | Win states, confirmations |
| **Error** | `#EF4444` | `239, 68, 68` | Loss states, errors |

### Light Mode

| Role | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Background** | `#FFFDF5` | `255, 253, 245` | Main app background |
| **Surface** | `#FFF9E8` | `255, 249, 232` | Elevated surfaces |
| **Card** | `#FFFFFF` | `255, 255, 255` | Cards, containers |
| **Card Border** | `#FFE8B8` | `255, 232, 184` | Subtle borders |
| **Text Primary** | `#1E1810` | `30, 24, 16` | Headlines, important text |
| **Text Secondary** | `#8A7550` | `138, 117, 80` | Body text, descriptions |
| **Text Tertiary** | `#C4A878` | `196, 168, 120` | Captions, placeholders |
| **Accent** | `#D97706` | `217, 119, 6` | Primary actions (darker for contrast) |
| **Accent Light** | `#F59E0B` | `245, 158, 11` | Hover states |

### Gradients

```css
/* Primary Gradient - Use for CTAs, highlights */
background: linear-gradient(135deg, #FBBF24 0%, #F59E0B 100%);

/* Warm Fade - Use for backgrounds, overlays */
background: linear-gradient(180deg, #1E1810 0%, #0C0A05 100%);

/* Sunset Glow - Use for special elements */
background: linear-gradient(135deg, #F59E0B 0%, #D97706 50%, #92400E 100%);
```

---

## Typography

### Font Stack
```css
font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
```

### Scale & Usage

| Element | Size | Weight | Color | Letter Spacing |
|---------|------|--------|-------|----------------|
| **App Title** | 24px | 700 (Bold) | `#FFFFFF` | -0.5px |
| **Section Headers** | 12px | 600 (Semibold) | `#C4A878` | 1.5px (uppercase) |
| **Card Title** | 17px | 600 (Semibold) | `#FFFFFF` | 0 |
| **Card Subtitle** | 14px | 400 (Regular) | `#C4A878` | 0 |
| **Body Text** | 15px | 400 (Regular) | `#FFFFFF` | 0 |
| **Caption** | 12px | 500 (Medium) | `#8A7550` | 0.5px |
| **Score Numbers** | 24-28px | 700 (Bold) | `#FFFFFF` | 0 (tabular-nums) |
| **Stat Values** | 20px | 700 (Bold) | `#F59E0B` | 0 (tabular-nums) |
| **Badges** | 12px | 600 (Semibold) | Varies | 0 |

### Text Shadows (Dark Mode)
```css
/* Headlines with glow */
text-shadow: 0 0 20px rgba(245, 158, 11, 0.3);

/* Accent text emphasis */
text-shadow: 0 0 10px rgba(245, 158, 11, 0.5);
```

---

## Components

### 1. Cards

**Standard Card**
```css
.card {
  background-color: #1E1810;
  border: 1px solid #382C1A;
  border-radius: 16px;
  padding: 16px;
}
```

**Highlighted Card (Featured)**
```css
.card-featured {
  background-color: #1E1810;
  border: 1px solid rgba(245, 158, 11, 0.3);
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 0 30px rgba(245, 158, 11, 0.15);
}
```

**Card with Accent Top Border**
```css
.card-accent {
  background-color: #1E1810;
  border: 1px solid #382C1A;
  border-top: 3px solid #F59E0B;
  border-radius: 16px;
}
```

---

### 2. Buttons

**Primary Button (CTA)**
```css
.btn-primary {
  background: linear-gradient(135deg, #FBBF24, #F59E0B);
  color: #000000;
  font-weight: 600;
  padding: 14px 24px;
  border-radius: 12px;
  border: none;
  box-shadow: 0 4px 20px rgba(245, 158, 11, 0.4);
}

.btn-primary:hover {
  box-shadow: 0 6px 30px rgba(245, 158, 11, 0.6);
  transform: translateY(-1px);
}
```

**Secondary Button**
```css
.btn-secondary {
  background: rgba(245, 158, 11, 0.15);
  color: #F59E0B;
  font-weight: 600;
  padding: 12px 20px;
  border-radius: 10px;
  border: 1px solid rgba(245, 158, 11, 0.3);
}

.btn-secondary:hover {
  background: rgba(245, 158, 11, 0.25);
}
```

**Ghost Button**
```css
.btn-ghost {
  background: transparent;
  color: #C4A878;
  font-weight: 500;
  padding: 10px 16px;
  border-radius: 8px;
  border: 1px solid #382C1A;
}

.btn-ghost:hover {
  border-color: #F59E0B;
  color: #F59E0B;
}
```

---

### 3. Badges & Tags

**Win Badge**
```css
.badge-win {
  background: rgba(34, 197, 94, 0.15);
  color: #22C55E;
  font-size: 12px;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: 6px;
}
```

**Loss Badge**
```css
.badge-loss {
  background: rgba(239, 68, 68, 0.1);
  color: #EF4444;
  font-size: 12px;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: 6px;
}
```

**Live Indicator**
```css
.badge-live {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #EF4444;
  font-size: 10px;
  font-weight: 600;
}

.badge-live::before {
  content: '';
  width: 6px;
  height: 6px;
  background: #EF4444;
  border-radius: 50%;
  animation: pulse 1.5s infinite;
}
```

**Accent Tag**
```css
.tag-accent {
  background: rgba(245, 158, 11, 0.15);
  color: #F59E0B;
  font-size: 11px;
  font-weight: 600;
  padding: 3px 8px;
  border-radius: 5px;
}
```

---

### 4. Navigation

**Bottom Tab Bar**
```css
.tab-bar {
  background: #0C0A05;
  border-top: 1px solid #382C1A;
  padding: 10px 0;
}

.tab-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.tab-item.active .tab-icon {
  color: #F59E0B;
}

.tab-item.inactive .tab-icon {
  color: #8A7550;
}

.tab-label {
  font-size: 10px;
  font-weight: 500;
}

.tab-label.active {
  color: #F59E0B;
  font-weight: 600;
}

.tab-label.inactive {
  color: #8A7550;
}
```

---

### 5. Input Fields

**Text Input**
```css
.input {
  background: #141008;
  border: 1px solid #382C1A;
  border-radius: 10px;
  padding: 12px 16px;
  color: #FFFFFF;
  font-size: 15px;
}

.input:focus {
  border-color: #F59E0B;
  outline: none;
  box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.2);
}

.input::placeholder {
  color: #8A7550;
}
```

---

### 6. Score Display

**Game Score**
```css
.score-container {
  display: flex;
  align-items: center;
  gap: 8px;
}

.score-home {
  font-size: 28px;
  font-weight: 700;
  color: #FFFFFF; /* or #22C55E if winning */
  font-variant-numeric: tabular-nums;
}

.score-away {
  font-size: 28px;
  font-weight: 700;
  color: #C4A878; /* muted for losing team */
  font-variant-numeric: tabular-nums;
}

.score-divider {
  color: #8A7550;
  font-size: 18px;
}
```

---

### 7. Stat Cards

**Individual Stat**
```css
.stat-card {
  background: #1E1810;
  border: 1px solid #382C1A;
  border-radius: 12px;
  padding: 12px;
  text-align: center;
}

.stat-value {
  font-size: 20px;
  font-weight: 700;
  color: #F59E0B;
  margin: 0;
  font-variant-numeric: tabular-nums;
}

.stat-label {
  font-size: 11px;
  color: #C4A878;
  margin-top: 4px;
}
```

---

### 8. Progress Bars

**Standard Progress**
```css
.progress-track {
  background: #382C1A;
  height: 6px;
  border-radius: 3px;
  overflow: hidden;
}

.progress-fill {
  background: linear-gradient(90deg, #F59E0B, #FBBF24);
  height: 100%;
  border-radius: 3px;
  transition: width 0.3s ease;
}
```

---

### 9. Lists & Dividers

**List Item**
```css
.list-item {
  padding: 14px 0;
  border-bottom: 1px solid #382C1A;
}

.list-item:last-child {
  border-bottom: none;
}
```

**Section Divider**
```css
.divider {
  height: 1px;
  background: linear-gradient(90deg, transparent, #382C1A, transparent);
  margin: 16px 0;
}
```

---

## Icons & Imagery

### Icon Colors

| State | Color |
|-------|-------|
| Active | `#F59E0B` |
| Inactive | `#8A7550` |
| Disabled | `#382C1A` |

### Icon Style Guidelines

- Use **outlined** icons for inactive states
- Use **filled** icons for active states
- Stroke width: **2px**
- Maintain consistent 24x24 or 22x22 sizing

### Recommended Icon Set
- Heroicons (outline/solid)
- Lucide Icons
- Custom SVGs matching stroke weight

---

## Animations & Effects

### Box Shadows

```css
/* Subtle elevation */
box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);

/* Card glow (featured content) */
box-shadow: 0 0 30px rgba(245, 158, 11, 0.2);

/* Button glow */
box-shadow: 0 4px 20px rgba(245, 158, 11, 0.4);

/* Strong accent glow */
box-shadow: 0 0 40px rgba(245, 158, 11, 0.5);
```

### Transitions

```css
/* Standard transition */
transition: all 0.2s ease;

/* Button hover */
transition: transform 0.15s ease, box-shadow 0.2s ease;

/* Color change */
transition: color 0.15s ease, background-color 0.15s ease;
```

### Keyframe Animations

```css
/* Pulse (for live indicators) */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}

/* Glow pulse (for featured elements) */
@keyframes glowPulse {
  0%, 100% { box-shadow: 0 0 20px rgba(245, 158, 11, 0.3); }
  50% { box-shadow: 0 0 40px rgba(245, 158, 11, 0.5); }
}

/* Subtle float */
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}
```

---

## Accessibility

### Contrast Ratios (Dark Mode)

| Combination | Ratio | Status |
|-------------|-------|--------|
| `#FFFFFF` on `#0C0A05` | 19.5:1 | ✅ AAA |
| `#C4A878` on `#0C0A05` | 8.2:1 | ✅ AAA |
| `#F59E0B` on `#0C0A05` | 8.9:1 | ✅ AAA |
| `#8A7550` on `#0C0A05` | 4.8:1 | ✅ AA |
| `#000000` on `#F59E0B` | 9.1:1 | ✅ AAA |

### Focus States

```css
*:focus-visible {
  outline: 2px solid #F59E0B;
  outline-offset: 2px;
}
```

### Touch Targets

- Minimum touch target: **44x44px**
- Buttons: minimum **48px height**
- List items: minimum **48px height**

---

## Implementation Examples

### React/JSX Theme Object

```jsx
const goldenHourTheme = {
  dark: {
    bg: '#0C0A05',
    surface: '#141008',
    card: '#1E1810',
    cardBorder: '#382C1A',
    text: '#FFFFFF',
    textSecondary: '#C4A878',
    textTertiary: '#8A7550',
    accent: '#F59E0B',
    accentLight: '#FBBF24',
    accentMuted: 'rgba(245,158,11,0.15)',
    success: '#22C55E',
    error: '#EF4444',
    gradient: 'linear-gradient(135deg, #FBBF24, #F59E0B)',
  },
  light: {
    bg: '#FFFDF5',
    surface: '#FFF9E8',
    card: '#FFFFFF',
    cardBorder: '#FFE8B8',
    text: '#1E1810',
    textSecondary: '#8A7550',
    textTertiary: '#C4A878',
    accent: '#D97706',
    accentLight: '#F59E0B',
    accentMuted: 'rgba(217,119,6,0.1)',
    success: '#22C55E',
    error: '#EF4444',
    gradient: 'linear-gradient(135deg, #FBBF24, #F59E0B)',
  }
};
```

### Tailwind CSS Config

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        golden: {
          bg: '#0C0A05',
          surface: '#141008',
          card: '#1E1810',
          border: '#382C1A',
          accent: '#F59E0B',
          'accent-light': '#FBBF24',
          'text-primary': '#FFFFFF',
          'text-secondary': '#C4A878',
          'text-tertiary': '#8A7550',
        }
      }
    }
  }
}
```

### CSS Variables

```css
:root {
  /* Dark Mode (default) */
  --golden-bg: #0C0A05;
  --golden-surface: #141008;
  --golden-card: #1E1810;
  --golden-border: #382C1A;
  --golden-text: #FFFFFF;
  --golden-text-secondary: #C4A878;
  --golden-text-tertiary: #8A7550;
  --golden-accent: #F59E0B;
  --golden-accent-light: #FBBF24;
  --golden-accent-muted: rgba(245, 158, 11, 0.15);
  --golden-success: #22C55E;
  --golden-error: #EF4444;
}

[data-theme="light"] {
  --golden-bg: #FFFDF5;
  --golden-surface: #FFF9E8;
  --golden-card: #FFFFFF;
  --golden-border: #FFE8B8;
  --golden-text: #1E1810;
  --golden-text-secondary: #8A7550;
  --golden-text-tertiary: #C4A878;
  --golden-accent: #D97706;
  --golden-accent-light: #F59E0B;
  --golden-accent-muted: rgba(217, 119, 6, 0.1);
}
```

---

## Screen-by-Screen Application

### Home Screen
- **Background**: `#0C0A05` solid
- **App Logo**: Gradient icon with amber glow shadow
- **CTA Button**: Full gradient background, black text
- **Cards**: `#1E1810` with subtle border
- **Stats**: Accent color values, secondary color labels

### Games Screen  
- **Filter Pills**: Active = gradient fill, Inactive = border only
- **Live Game Cards**: Red accent for live indicator, amber border glow
- **Score Display**: Winner in white, loser in secondary color

### Stats Screen
- **Stat Values**: Always use `#F59E0B` accent
- **Progress Bars**: Gradient fill on dark track
- **Section Headers**: Secondary text color, uppercase, tracked

### Teams Screen
- **Team Cards**: Subtle amber border on hover
- **Roster List**: Alternating subtle backgrounds
- **Role Badges**: Accent muted background

### Profile Screen
- **Avatar Ring**: Gradient border
- **Settings Items**: Ghost button style
- **Achievement Badges**: Gold accent fills

---

## Do's and Don'ts

### ✅ Do

- Use gradients sparingly for emphasis
- Maintain warm, amber tones throughout
- Keep text highly readable with proper contrast
- Use glows subtly to add depth
- Apply gold accents to interactive elements

### ❌ Don't

- Overuse bright amber (causes eye strain)
- Mix cool colors (blue, purple) with the palette
- Use pure white backgrounds in light mode
- Apply glows to everything
- Forget to dim amber for non-interactive text

---

## Resources

- **Figma Color Styles**: [Link to Figma]
- **Icon Library**: Heroicons / Lucide
- **Font**: System UI stack

---

*Last updated: December 2024*
*Version: 1.0*
