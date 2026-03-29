# Typography

The Social Tools design system uses system fonts with Tailwind CSS for consistent, performant typography.

## Font Stack

We use the system font stack for best performance and native feel:

```css
font-family: system-ui, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
```

## Type Scale

### Headings

| Element | Size            | Weight | Line Height |
| ------- | --------------- | ------ | ----------- |
| h1      | 2.5rem (40px)   | 700    | 1.2         |
| h2      | 2rem (32px)     | 700    | 1.25        |
| h3      | 1.5rem (24px)   | 600    | 1.3         |
| h4      | 1.25rem (20px)  | 600    | 1.4         |
| h5      | 1.125rem (18px) | 500    | 1.5         |
| h6      | 1rem (16px)     | 500    | 1.5         |

### Body Text

| Type   | Size            | Weight | Line Height |
| ------ | --------------- | ------ | ----------- |
| Large  | 1.125rem (18px) | 400    | 1.75        |
| Base   | 1rem (16px)     | 400    | 1.5         |
| Small  | 0.875rem (14px) | 400    | 1.5         |
| XSmall | 0.75rem (12px)  | 400    | 1.5         |

## Tailwind Classes

### Headings

```html
<h1 class="text-4xl font-bold">Heading 1</h1>
<h2 class="text-3xl font-bold">Heading 2</h1>
<h3 class="text-2xl font-semibold">Heading 3</h1>
<h4 class="text-xl font-semibold">Heading 4</h1>
<h5 class="text-lg font-medium">Heading 5</h1>
<h6 class="text-base font-medium">Heading 6</h1>
```

### Body

```html
<p class="text-lg">Large body text</p>
<p class="text-base">Base body text</p>
<p class="text-sm">Small body text</p>
<p class="text-xs">Extra small text</p>
```

### Font Weights

```html
<p class="font-light">Light (300)</p>
<p class="font-normal">Normal (400)</p>
<p class="font-medium">Medium (500)</p>
<p class="font-semibold">Semibold (600)</p>
<p class="font-bold">Bold (700)</p>
```

## Text Colors

Use DaisyUI color system:

```html
<p class="text-base-content">Default text</p>
<p class="text-base-content/70">70% opacity</p>
<p class="text-primary">Primary color</p>
<p class="text-secondary">Secondary color</p>
<p class="text-accent">Accent color</p>
<p class="text-success">Success color</p>
<p class="text-warning">Warning color</p>
<p class="text-error">Error color</p>
<p class="text-info">Info color</p>
```

## Best Practices

1. **Use semantic headings** - Always use h1-h6 for structure
2. **Maintain hierarchy** - Don't skip heading levels
3. **Limit line length** - Keep text between 45-75 characters
4. **Use appropriate spacing** - Use Tailwind's spacing scale
5. **Ensure contrast** - Text should meet WCAG AA (4.5:1 ratio)

## Component Typography

### Cards

```html
<div class="card">
  <div class="card-body">
    <h2 class="card-title">Card Title</h2>
    <p>Card content text</p>
  </div>
</div>
```

### Lists

```html
<ul class="list">
  <li class="list-row">
    <div class="list-col-grow">
      <div class="font-bold">Title</div>
      <div class="text-sm opacity-70">Subtitle</div>
    </div>
  </li>
</ul>
```

### Forms

```html
<label class="label">
  <span class="label-text">Label text</span>
</label>
<input class="input" />
<span class="label-text-alt">Helper text</span>
```
