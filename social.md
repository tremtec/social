# Social Tools by TremTec

A portfolio of useful tools and services for Social Impact! We are building a
collection of tools self-served by a modular ERP (Social ERP).

## Requirements

### Social Organizations

> [!NOTE]
>
> ```yaml
> prefix: "/:org_slug/*"
> user:
>   role: member
> ```

- Donations CMS: module to manage donations and communicating with your community
- Transparency Portal: module to with tasks to manage your institutional transparency
- Financial Dashboard: financial module to manage income, outcomes, reports, etc
- Settings: Update Organization settings (Name, info, danger zone)

### System Admin

> [!NOTE]
>
> ```yaml
> prefix: "/admin/*"
> user:
>   role: admin
> ```

- `/` -> Dashboard
- `/users` -> Manage Users
- `/organizations` -> Manage Organizations
- `/settings` -> Manage System Settings

### Non-functional Requirements

- RBAC auth (magic link only)
- DB storage: sqlite
- Realtime updates: Phoenix Framework w/ LiveView for Authenticated areas
- Product focused on Brazilian NPOs (ONGs)
  - LGPD Compliant
  - Internationalization from day 1 (gettext supporting en and pt-br for now)
- Hosting: Docker + Fly.io
- CDN: Cloudflare
- UX Design System: Clean and Cheerful colors, blurs and forms with Dark Theme
  - DaisyUI components > tailwindcss > raw CSS
  - Create a Design System file/folder

## Roadmap

- [x] Groundwork
  - [x] Set up Phoenix Project w/: Auth, SQLite, tailwindcss + DaisyUI
    - [x] Generate phoenix project with `mix phx.new social --live --database sqlite`
    - [x] Generate auth with `mix phx.gen.auth Accounts User users --binary-id --hashing-lib bcrypt`
  - [x] UX Design System definition
    - [x] define components to be used across the project
    - [x] Customize Phoenix Framework theme (colors defined by UX Design System)
    - [x] Create a landing page to show off the design system and test components
  - [x] Set up i18n
    - [x] Replace all hardcoded texts with gettext
    - [x] Add translations to `pt-br`
    - [x] `Accepted-Language` header detection for automatic language switching
  - [x] Set up maestro
  - [x] Set initial landing page

- [ ] Next steps
  - Workflow: Org onboarding
  - Workflow: Admin onboarding
