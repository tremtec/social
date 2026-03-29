# Components

The Social Tools design system provides reusable Phoenix components for common UI patterns.

## Overview

Components are implemented as Phoenix Components using `use Phoenix.Component`. They complement DaisyUI and Tailwind CSS with domain-specific patterns.

## Available Components

### Buttons

Located in `SocialComponents.social_button/1`

**Variants:**

- `primary` - Main actions (default)
- `secondary` - Secondary actions
- `ghost` - Subtle actions
- `danger` - Destructive actions
- `link` - Text links

**Sizes:**

- `sm` - Small
- `md` - Medium (default)
- `lg` - Large

**States:**

- `disabled` - Disabled state
- `loading` - Loading state with spinner

**Usage:**

```heex
<.social_button variant="primary" size="md">
  Save
</.social_button>

<.social_button variant="danger" phx-click="delete">
  Delete
</.social_button>

<.social_button variant="link" navigate={~p"/users"}>
  View All
</.social_button>
```

### Cards

Located in `SocialComponents.social_card/1`

**Features:**

- Optional glass effect
- Optional hover animation
- Customizable padding
- Header, body, and footer slots

**Usage:**

```heex
<.social_card>
  <:header>Card Title</:header>
  <p>Card content goes here</p>
  <:footer>
    <button class="btn btn-sm">Action</button>
  </:footer>
</.social_card>

<.social_card glass hover>
  <p>Glass card with hover effect</p>
</.social_card>
```

### Inputs

Located in `SocialComponents.social_input/1`

**Features:**

- Wraps CoreComponents.input
- Adds icons support
- Consistent styling

**Usage:**

```heex
<.social_input
  field={@form[:name]}
  label={gettext("Name")}
  icon="hero-user"
/>

<.social_input
  type="password"
  name="password"
  label={gettext("Password")}
  icon="hero-lock-closed"
/>
```

### Badges

Located in `SocialComponents.social_badge/1`

**Variants:**

- `primary`, `secondary`, `accent`
- `success`, `warning`, `error`, `info`
- `ghost`

**Usage:**

```heex
<.social_badge variant="success">Active</.social_badge>
<.social_badge variant="warning">Pending</.social_badge>
<.social_badge variant="error">Failed</.social_badge>
```

### Avatars

Located in `SocialComponents.social_avatar/1`

**Features:**

- Image or initials fallback
- Multiple sizes
- Online/offline status indicator
- Group support

**Usage:**

```heex
<.social_avatar src={@user.avatar_url} />
<.social_avatar name={@user.name} size="lg" />
<.social_avatar src={@org.logo_url} status="online" />
```

### Empty States

Located in `SocialComponents.social_empty_state/1`

**Features:**

- Icon display
- Title and description
- Call-to-action button

**Usage:**

```heex
<.social_empty_state
  icon="hero-inbox"
  title={gettext("No items yet")}
  description={gettext("Create your first item to get started")}
/>

<.social_empty_state
  icon="hero-user-group"
  title={gettext("No volunteers")}
  action={gettext("Add Volunteer")}
  action_click="add_volunteer"
/>
```

### Stats

Located in `SocialComponents.social_stat/1`

**Usage:**

```heex
<.social_stat
  title={gettext("Total Volunteers")}
  value={@volunteer_count}
  icon="hero-user-group"
/>

<.social_stat
  title={gettext("Active")}
  value={@active_count}
  trend={:up}
  trend_value="+12%"
/>
```

### Modals

Located in `SocialComponents.social_modal/1`

**Usage:**

```heex
<.social_modal
  id="confirm-delete"
  title={gettext("Confirm Delete")}
  on_confirm={JS.push("delete")}
>
  <p>Are you sure you want to delete this item?</p>
  <:cancel>Cancel</:cancel>
  <:confirm>Delete</:confirm>
</.social_modal>
```

### Alerts

Located in `SocialComponents.social_alert/1`

**Variants:**

- `success`, `warning`, `error`, `info`

**Usage:**

```heex
<.social_alert variant="success" title="Success!">
  Your changes have been saved.
</.social_alert>

<.social_alert variant="warning">
  Please review your information.
</.social_alert>
```

## DaisyUI Components

For additional components, use DaisyUI directly:

### Dropdowns

```html
<div class="dropdown">
  <div tabindex="0" role="button" class="btn m-1">Click</div>
  <ul
    tabindex="0"
    class="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm"
  >
    <li><a>Item 1</a></li>
    <li><a>Item 2</a></li>
  </ul>
</div>
```

### Tabs

```html
<div class="tabs">
  <a class="tab">Tab 1</a>
  <a class="tab tab-active">Tab 2</a>
  <a class="tab">Tab 3</a>
</div>
```

### Accordions

```html
<div class="collapse collapse-arrow bg-base-200">
  <input type="radio" name="my-accordion-2" checked="checked" />
  <div class="collapse-title text-xl font-medium">Click to open</div>
  <div class="collapse-content">
    <p>Content</p>
  </div>
</div>
```

### Toasts

```html
<div class="toast">
  <div class="alert alert-info">
    <span>New mail arrived.</span>
  </div>
</div>
```

## Best Practices

1. **Use SocialComponents** for domain-specific patterns
2. **Use DaisyUI** for base components and layout
3. **Combine both** - SocialComponents wrap DaisyUI
4. **Customize with props** - Most components accept `class` for overrides
5. **i18n ready** - Use `gettext()` for all user-facing strings
