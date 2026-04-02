---
name: phoenix-i18n
description: Phoenix i18n with Gettext - enforce internationalization best practices
license: MIT
compatibility: opencode
metadata:
  scope: phoenix
  category: internationalization
---

## What I do

Ensure all user-facing text is properly internationalized using Gettext according to the project's i18n standards.

## When to use me

- Creating new LiveViews, components, or modules with user-facing text
- Adding/modifying translations
- Reviewing code for i18n compliance

## Rules

1. **Always import Gettext** in modules with translatable strings:

   ```elixir
   use Gettext, backend: SocialWeb.Gettext
   ```

2. **Never hardcode user-facing text** - always wrap with `gettext()`:

   ```elixir
   # CORRECT
   gettext("Hello World")
   gettext("Welcome, %{name}!", name: user.name)

   # WRONG
   "Hello World"
   ```

3. **Use `dgettext` for domain-specific strings**:

   ```elixir
   dgettext("app", "Custom domain text")
   ```

4. **Run `mix gettext.extract`** after adding new translatable strings to update POT files

5. **Add translations to both locale files**:
   - `priv/gettext/en/LC_MESSAGES/app.po`
   - `priv/gettext/pt_br/LC_MESSAGES/app.po`

6. **Access locale via assigns**:
   ```elixir
   @locale  # Available in all LiveViews
   ```

## Key Files

- `lib/social_web/plugs/locale.ex` - Locale detection plug
- `lib/social_web/hooks/locale.ex` - LiveView locale hook
- `lib/social_web/gettext.ex` - Gettext backend
- `priv/gettext/en/LC_MESSAGES/app.po` - English translations
- `priv/gettext/pt_br/LC_MESSAGES/app.po` - Portuguese translations

## Best Practices

- Use meaningful msgid strings in English
- Group translations by feature using comments in .po files
- Test with both locales to ensure translations display correctly
- Keep translations organized and up-to-date
