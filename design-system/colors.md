# Color Palette

The Social Tools design system uses the **OKLCH color model** for consistent, accessible colors across light and dark themes.

## Overview

Our colors are built on DaisyUI themes with custom OKLCH values, providing:

- Automatic dark/light mode support
- High contrast ratios (WCAG AA compliant)
- Vibrant colors that work in both themes

## Brand Colors

### Primary

Used for main actions, links, and key UI elements.

| Theme | OKLCH                      | Usage                          |
| ----- | -------------------------- | ------------------------------ |
| Light | `oklch(70% 0.213 47.604)`  | Primary buttons, active states |
| Dark  | `oklch(58% 0.233 277.117)` | Primary buttons, active states |

### Secondary

Used for secondary actions and accents.

| Theme | OKLCH                      | Usage                   |
| ----- | -------------------------- | ----------------------- |
| Light | `oklch(55% 0.027 264.364)` | Secondary buttons, tags |
| Dark  | `oklch(58% 0.233 277.117)` | Secondary buttons, tags |

### Accent

Used for highlights and attention-grabbing elements.

| Theme | OKLCH                     | Usage               |
| ----- | ------------------------- | ------------------- |
| Light | `oklch(0% 0 0)`           | Accents (black)     |
| Dark  | `oklch(60% 0.25 292.717)` | Accents, highlights |

## Semantic Colors

### Success

For positive actions and confirmations.

- Light: `oklch(70% 0.14 182.503)`
- Dark: `oklch(60% 0.118 184.704)`
- Content: `oklch(98% 0.014 180.72)`

### Warning

For caution states and important notices.

- Light/Dark: `oklch(66% 0.179 58.318)`
- Content: `oklch(98% 0.022 95.277)`

### Error

For errors, destructive actions, and alerts.

- Light/Dark: `oklch(58% 0.253 17.585)`
- Content: `oklch(96% 0.015 12.422)`

### Info

For informational content.

- Light: `oklch(62% 0.214 259.815)`
- Dark: `oklch(58% 0.158 241.966)`
- Content: `oklch(97% 0.013 236.62)`

## Neutral Colors

Used for backgrounds, borders, and text.

### Light Theme

| Name     | OKLCH                      | Usage             |
| -------- | -------------------------- | ----------------- |
| Base 100 | `oklch(98% 0 0)`           | Main background   |
| Base 200 | `oklch(96% 0.001 286.375)` | Card backgrounds  |
| Base 300 | `oklch(92% 0.004 286.32)`  | Borders, dividers |
| Content  | `oklch(21% 0.006 285.885)` | Primary text      |

### Dark Theme

| Name     | OKLCH                          | Usage             |
| -------- | ------------------------------ | ----------------- |
| Base 100 | `oklch(30.33% 0.016 252.42)`   | Main background   |
| Base 200 | `oklch(25.26% 0.014 253.1)`    | Card backgrounds  |
| Base 300 | `oklch(20.15% 0.012 254.09)`   | Borders, dividers |
| Content  | `oklch(97.807% 0.029 256.847)` | Primary text      |

## DaisyUI Classes

Use DaisyUI classes for colors:

```html
<!-- Buttons -->
<button class="btn btn-primary">Primary</button>
<button class="btn btn-secondary">Secondary</button>
<button class="btn btn-accent">Accent</button>

<!-- Alerts -->
<div class="alert alert-success">Success!</div>
<div class="alert alert-warning">Warning</div>
<div class="alert alert-error">Error</div>
<div class="alert alert-info">Info</div>

<!-- Badges -->
<span class="badge badge-primary">Primary</span>
<span class="badge badge-secondary">Secondary</span>
<span class="badge badge-accent">Accent</span>
<span class="badge badge-ghost">Ghost</span>
```

## Custom Color Classes

Additional custom classes for specific needs:

```css
/* Glass effect backgrounds */
.glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
}

[data-theme="dark"] .glass {
  background: rgba(0, 0, 0, 0.2);
}

/* Subtle gradients */
.gradient-primary {
  background: linear-gradient(
    135deg,
    var(--color-primary),
    var(--color-secondary)
  );
}
```
