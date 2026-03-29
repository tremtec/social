# Spacing

The Social Tools design system uses Tailwind CSS's spacing scale for consistent, responsive spacing.

## Spacing Scale

| Class      | Pixels  | Rem  | Usage         |
| ---------- | ------- | ---- | ------------- |
| `space-0`  | 0       | 0    | No spacing    |
| `space-1`  | 0.25rem | 4px  | Tight spacing |
| `space-2`  | 0.5rem  | 8px  | Default tight |
| `space-3`  | 0.75rem | 12px | Small         |
| `space-4`  | 1rem    | 16px | Default base  |
| `space-5`  | 1.25rem | 20px | Medium        |
| `space-6`  | 1.5rem  | 24px | Large         |
| `space-8`  | 2rem    | 32px | XL            |
| `space-10` | 2.5rem  | 40px | 2XL           |
| `space-12` | 3rem    | 48px | 3XL           |
| `space-16` | 4rem    | 64px | 4XL           |

## Padding

### Padding All Sides

```html
<div class="p-1">p-1 (4px)</div>
<div class="p-2">p-2 (8px)</div>
<div class="p-3">p-3 (12px)</div>
<div class="p-4">p-4 (16px)</div>
<div class="p-6">p-6 (24px)</div>
<div class="p-8">p-8 (32px)</div>
```

### Padding by Direction

```html
<!-- Padding X (horizontal) -->
<div class="px-4">px-4</div>

<!-- Padding Y (vertical) -->
<div class="py-4">py-4</div>

<!-- Specific sides -->
<div class="pt-4">pt-4 (top)</div>
<div class="pr-4">pr-4 (right)</div>
<div class="pb-4">pb-4 (bottom)</div>
<div class="pl-4">pl-4 (left)</div>
```

## Margin

### Margin All Sides

```html
<div class="m-1">m-1 (4px)</div>
<div class="m-2">m-2 (8px)</div>
<div class="m-4">m-4 (16px)</div>
<div class="m-auto">m-auto (auto centering)</div>
```

### Negative Margins

```html
<div class="-m-4">Negative margin</div>
```

### Margin by Direction

```html
<div class="mx-auto">mx-auto (center horizontally)</div>
<div class="my-4">my-4 (vertical)</div>
<div class="mt-4">mt-4 (top)</div>
<div class="mr-4">mr-4 (right)</div>
<div class="mb-4">mb-4 (bottom)</div>
<div class="ml-4">ml-4 (left)</div>
```

## Gap

For flexbox and grid spacing:

```html
<!-- Flex gap -->
<div class="flex gap-2">
  <div>Item 1</div>
  <div>Item 2</div>
</div>

<!-- Grid gap -->
<div class="grid grid-cols-3 gap-4">
  <div>Item 1</div>
  <div>Item 2</div>
  <div>Item 3</div>
</div>

<!-- Row/Column gap -->
<div class="flex gap-x-4 gap-y-2">
  <div>Item</div>
</div>
```

## Container

```html
<div class="container mx-auto px-4">
  <!-- Centered container with horizontal padding -->
</div>
```

## Component Spacing Patterns

### Card Spacing

```html
<div class="card bg-base-200">
  <div class="card-body">
    <h2 class="card-title">Title</h2>
    <p>Content with proper spacing</p>
    <div class="card-actions justify-end">
      <button class="btn btn-primary">Action</button>
    </div>
  </div>
</div>
```

### Form Spacing

```html
<div class="form-control w-full max-w-xs">
  <label class="label">
    <span class="label-text">Label</span>
  </label>
  <input type="text" class="input input-bordered w-full" />
  <label class="label">
    <span class="label-text-alt">Helper text</span>
  </label>
</div>
```

### List Spacing

```html
<ul class="menu bg-base-200 rounded-box">
  <li><a>Item 1</a></li>
  <li><a>Item 2</a></li>
  <li><a>Item 3</a></li>
</ul>
```

## Responsive Spacing

Use responsive prefixes:

```html
<!-- Small on mobile, larger on larger screens -->
<div class="p-2 md:p-4 lg:p-6">Responsive padding</div>

<!-- Gap changes with breakpoints -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2 md:gap-4">
  Grid items
</div>
```
