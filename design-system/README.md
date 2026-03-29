# Social Tools Design System

A comprehensive design system for **Social Tools** - a Social ERP platform targeting Brazilian NPOs (ONGs).

## Philosophy

Warm, welcoming, and professional design for Brazilian nonprofit organizations.

### Core Values

- **Clean**: Simple, uncluttered interfaces that reduce cognitive load
- **Cheerful**: Warm colors that inspire trust and positivity
- **Modern**: Blurs, glassmorphism, smooth transitions

### Design Principles

1. **Accessibility First**: All components meet WCAG 2.1 AA standards
2. **Consistency**: Reusable components ensure uniform experience
3. **Performance**: Lightweight components with minimal JS overhead
4. **Internationalization**: i18n-ready with gettext support

## Tech Stack

- **Phoenix 1.8** - Web framework
- **LiveView** - Reactive UI
- **Tailwind CSS 4** - Utility-first CSS
- **DaisyUI 5** - Component library
- **OKLCH Colors** - Modern color system for consistency
- **Heroicons** - Icon set

## Theme Support

- **Light Mode**: Clean, bright interface
- **Dark Mode**: Deep, comfortable viewing
- **System Preference**: Automatic detection

## Getting Started

See the component documentation for usage:

- [Colors](colors.md) - Color palette and usage
- [Typography](typography.md) - Font system
- [Spacing](spacing.md) - Spacing scale
- [Components](components.md) - Component patterns

## Project Structure

```
lib/social_web/
├── components/
│   ├── core_components.ex     # Phoenix default components
│   ├── social_components.ex   # Custom Social components
│   └── layouts.ex             # Layouts
design-system/
├── README.md                   # This file
├── colors.md                   # Color palette
├── typography.md               # Typography system
├── spacing.md                  # Spacing scale
└── components.md               # Component patterns
```
