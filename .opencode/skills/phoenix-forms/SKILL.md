---
name: phoenix-forms
description: Phoenix form handling with to_form/2, core_components, and LiveView forms
license: MIT
compatibility: opencode
metadata:
  scope: phoenix
  category: forms
---

## What I do

Ensure proper form handling using `to_form/2`, `<.form>` component, and `<.input>` from core_components.

## When to use me

- Creating forms in LiveViews
- Adding form inputs
- Handling form validation and submission
- Creating reusable form components

## Rules

### Form Creation

1. **Always use `to_form/2`** in the LiveView, never pass changesets directly:

   ```elixir
   # CORRECT
   def mount(_params, _session, socket) do
     changeset = Accounts.change_user_registration(%User{})
     {:ok, assign(socket, form: to_form(changeset))}
   end

   # WRONG
   {:ok, assign(socket, changeset: changeset)}
   ```

2. **Access forms via `@form` assign in templates**:
   ```heex
   <.form for={@form} id="user-form" phx-submit="save">
     <.input field={@form[:email]} type="email" />
   </.form>
   ```

### Form Inputs

1. **Always use `<.input>` component** from core_components.ex:

   ```heex
   <.input field={@form[:email]} type="email" label="Email" />
   <.input field={@form[:password]} type="password" label="Password" />
   ```

2. **If overriding input classes**, you must provide ALL classes (no inheritance):
   ```heex
   <.input
     field={@form[:name]}
     class="myclass px-2 py-1 rounded-lg"
   />
   ```

### Form Structure

1. **Always provide unique DOM IDs** for forms and key elements:

   ```heex
   <.form for={@form} id="organization-form" phx-submit="save">
     <.input field={@form[:name]} id="organization-name" />
   </.form>
   ```

2. **Never use `<.form let={f} ...>`** - use `for={@form}` instead:

   ```heex
   <!-- WRONG -->
   <.form let={f} for={@changeset}>
     <%= f.text_input :name %>
   </.form>

   <!-- CORRECT -->
   <.form for={@form} id="my-form">
     <.input field={@form[:name]} type="text" />
   </.form>
   ```

### Form Handling Events

**From params**:

```elixir
def handle_event("submitted", params, socket) do
  {:noreply, assign(socket, form: to_form(params))}
end

# With nesting
def handle_event("submitted", %{"user" => user_params}, socket) do
  {:noreply, assign(socket, form: to_form(user_params, as: :user))}
end
```

**From changesets**:

```elixir
def handle_event("validate", %{"user" => user_params}, socket) do
  changeset =
    %User{}
    |> Accounts.change_user(user_params)
    |> Map.put(:action, :validate)

  {:noreply, assign(socket, form: to_form(changeset))}
end
```

## Key Components

The following are available from `core_components.ex`:

- `<.input>` - Form inputs (text, email, password, etc.)
- `<.form>` - Form wrapper
- `<.inputs_for>` - Nested forms (has_many/has_one associations)
- `<.error>` - Error messages
- `<.label>` - Form labels

## Key Files

- `lib/social_web/components/core_components.ex` - Form components
- `lib/social_web/live/` - LiveViews with forms
