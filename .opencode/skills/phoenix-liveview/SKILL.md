---
name: phoenix-liveview
description: Phoenix LiveView best practices for streams, forms, JS hooks, and component patterns
license: MIT
compatibility: opencode
metadata:
  scope: phoenix
  category: liveview
---

## What I do

Enforce Phoenix LiveView best practices for building reactive, performant UI components.

## When to use me

- Creating new LiveViews
- Implementing collections/lists with streams
- Adding JavaScript interop with hooks
- Handling forms and events

## Rules

### LiveView Structure

1. **Always begin templates with `<Layouts.app flash={@flash} ...>`**:

   ```heex
   <Layouts.app flash={@flash} current_scope={@current_scope} current_user={@current_scope.user}>
     <!-- content -->
   </Layouts.app>
   ```

2. **Never use deprecated `live_redirect`/`live_patch`** - use these instead:
   - Templates: `<.link navigate={href}>` or `<.link patch={href}>`
   - LiveViews: `push_navigate` and `push_patch`

3. **Avoid LiveComponents** unless you have a strong, specific need

### LiveView Streams

**Always use streams for collections** to avoid memory ballooning:

```elixir
# Basic append
stream(socket, :messages, [new_msg])

# Reset stream (e.g., for filtering)
stream(socket, :messages, messages, reset: true)

# Prepend to stream
stream(socket, :messages, [new_msg], at: -1)

# Delete items
stream_delete(socket, :messages, msg)
```

**Template requirements**:

```heex
<div id="messages" phx-update="stream">
  <div :for={{id, msg} <- @streams.messages} id={id}>
    {msg.text}
  </div>
</div>
```

**Important**: Streams are not enumerable - you cannot use `Enum.filter/2` on them. To filter, refetch and re-stream with `reset: true`.

### JavaScript Interop

1. **Always set `phx-update="ignore"`** when using `phx-hook` that manages DOM
2. **Always provide unique DOM id** alongside `phx-hook`

**Colocated hooks** (preferred for inline scripts):

```heex
<input type="text" phx-hook=".PhoneNumber" />
<script :type={Phoenix.LiveView.ColocatedHook} name=".PhoneNumber">
  export default {
    mounted() {
      this.el.addEventListener("input", e => { ... })
    }
  }
</script>
```

**External hooks** (place in `assets/js/`):

```javascript
const MyHook = { mounted() { ... } }
let liveSocket = new LiveSocket("/live", Socket, { hooks: { MyHook } })
```

### Form Handling

See `phoenix-forms` skill for detailed form patterns.

## Testing

- Use `Phoenix.LiveViewTest` and `LazyHTML` for assertions
- Reference key element IDs in tests with `element/2`, `has_element/2`
- Never test against raw HTML

```elixir
assert has_element?(view, "#my-form")
```

## Key Files

- `lib/social_web/live/` - LiveView modules
- `assets/js/` - JavaScript hooks
- `lib/social_web/components/layouts.ex` - Layout components
