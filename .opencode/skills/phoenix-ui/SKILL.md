---
name: phoenix-ui
description: Phoenix UI/UX patterns - Tailwind CSS v4, icons, layouts, and component design
license: MIT
compatibility: opencode
metadata:
  scope: phoenix
  category: ui
---

## What I do

Ensure consistent UI implementation using Tailwind CSS v4, hero icons, and Phoenix component patterns.

## When to use me

- Creating UI components
- Styling templates with Tailwind
- Adding icons
- Implementing responsive designs

## Rules

### Tailwind CSS v4

1. **Use the correct import syntax** in `app.css`:

   ```css
   @import "tailwindcss" source(none);
   @source "../css";
   @source "../js";
   @source "../../lib/social_web";
   ```

2. **Tailwind v4 no longer needs `tailwind.config.js`** - configuration is CSS-based

3. **Never use `@apply`** when writing raw CSS

4. **Use Tailwind classes directly** in templates:
   ```heex
   <div class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
     <h2 class="text-2xl font-bold text-gray-900">Title</h2>
   </div>
   ```

### Icons

1. **Always use `<.icon>` component** - never use Heroicons modules directly:

   ```heex
   <!-- CORRECT -->
   <.icon name="hero-x-mark" class="w-5 h-5" />
   <.icon name="hero-plus" class="w-6 h-6 text-blue-500" />

   <!-- WRONG -->
   <Heroicons.x_mark class="w-5 h-5" />
   ```

2. **Common icon names** (from Heroicons):
   - `hero-x-mark`, `hero-plus`, `hero-check`, `hero-trash`
   - `hero-pencil`, `hero-user`, `hero-cog`, `hero-bell`
   - `hero-arrow-right`, `hero-arrow-left`, `hero-home`

### Layouts

1. **Always wrap content in `<Layouts.app>`**:

   ```heex
   <Layouts.app flash={@flash} current_scope={@current_scope}>
     <div class="container mx-auto px-4">
       <!-- page content -->
     </div>
   </Layouts.app>
   ```

2. **The `Layouts` module is already aliased** in `social_web.ex` - no need to alias again

3. **`<.flash_group>` is ONLY available in `layouts.ex`** - never call it elsewhere

### Class Attributes

**Always use list syntax for conditional classes**:

```heex
<a class={[
  "px-2 text-white",
  @some_flag && "py-5",
  if(@other_condition, do: "border-red-500", else: "border-blue-100")
]}>
  Link
</a>
```

**Wrap `if` expressions in parens** inside `{...}`:

```heex
<div class={[
  "base-classes",
  if(@condition, do: "active", else: "inactive")
]}>
```

### Design Principles

1. **Produce world-class UI designs** with focus on:
   - Usability
   - Aesthetics
   - Modern design principles

2. **Implement subtle micro-interactions**:
   - Button hover effects
   - Smooth transitions
   - Loading states

3. **Ensure clean typography, spacing, and layout balance** for a premium look

4. **Focus on delightful details**:
   - Hover effects
   - Loading states
   - Smooth page transitions

### Custom Components

The project has custom components in `lib/social_web/components/social_components.ex`:

- `.social_card` - Card components
- `.social_avatar` - Avatar display
- `.social_badge` - Badge/status indicators
- `.nav_item` - Navigation items

## Key Files

- `assets/css/app.css` - Tailwind imports
- `lib/social_web/components/core_components.ex` - Core UI components
- `lib/social_web/components/social_components.ex` - Custom components
- `lib/social_web/components/layouts.ex` - Layout components
- `design-system/` - Design system documentation
