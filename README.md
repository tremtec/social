# Social ERP

### A Modern Social Enterprise Resource Planning Platform for Brazilian NGOs

---

<p align="center">
  <img src="https://img.shields.io/badge/Elixir-1.15+-4B275F?style=for-the-badge&logo=elixir&logoColor=white" alt="Elixir">
  <img src="https://img.shields.io/badge/Phoenix-1.8-EC2659?style=for-the-badge&logo=phoenix&logoColor=white" alt="Phoenix">
  <img src="https://img.shields.io/badge/LiveView-1.1-2F5ABC?style=for-the-badge&logo=LiveView&logoColor=white" alt="LiveView">
  <img src="https://img.shields.io/badge/License-MIT-38B2AC?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/PRs-Welcome!-38B2AC?style=for-the-badge" alt="PRs Welcome">
</p>

<p align="center">
  <img src="https://img.shields.io/github/actions/workflow/status/tremtec/social/ci.yml?style=flat-square" alt="CI">
  <img src="https://img.shields.io/hexpm/v/social?color=4B275F&style=flat-square" alt="Hex.pm">
  <img src="https://img.shields.io/hexpm/dt/social?color=EC2659&style=flat-square" alt="Downloads">
</p>

---

## What is Social?

**Social** is an open-source, modular ERP platform built specifically for Brazilian nonprofit organizations (ONGs). We believe that technology should empower social impact, not hinder it.

Built with **Phoenix + LiveView**, Social provides real-time, reactive interfaces for managing donations, transparency portals, financial dashboards, and organizational settings—all under a beautiful, accessible design system.

## Why Social?

<p align="center">
  <strong>🌎 Built for Brazil</strong> &nbsp;|&nbsp;
  <strong>🔒 LGPD Compliant</strong> &nbsp;|&nbsp;
  <strong>🌐 i18n Ready</strong> &nbsp;|&nbsp;
  <strong>⚡ Real-time Updates</strong> &nbsp;|&nbsp;
  <strong>🎨 Beautiful Design</strong>
</p>

### Core Modules

| Module | Description |
|--------|-------------|
| **💰 Donations CMS** | Manage donations and communicate with your community |
| **📊 Transparency Portal** | Task-based tools for institutional transparency |
| **💼 Financial Dashboard** | Income, outcomes, reports, and more |
| **⚙️ Organization Settings** | Customize your organization's profile |

### Non-Functional Requirements

- **Authentication**: Magic link (passwordless) with RBAC
- **Database**: SQLite (development/production ready)
- **Real-time**: Phoenix LiveView for instant updates
- **Internationalization**: English & Brazilian Portuguese (pt-BR)
- **Hosting**: Docker + Fly.io ready
- **CDN**: Cloudflare optimized
- **Design**: Dark theme, blurs, and modern forms

## Tech Stack

<p align="center">
  <img src="https://skillicons.dev/icons?i=elixir,phoenix,liveview,tailwind,sqlite,docker,cloudflare" />
</p>

| Technology | Purpose |
|------------|---------|
| **Elixir 1.15+** | Core language with excellent concurrency |
| **Phoenix 1.8** | Web framework with proven scalability |
| **LiveView 1.1** | Real-time reactive UI |
| **Tailwind CSS 4** | Utility-first CSS |
| **DaisyUI 5** | Component library |
| **SQLite + Ecto** | Database with type-safe queries |
| **Gettext** | Internationalization |
| **Bandit** | HTTP server |

## Getting Started

### Prerequisites

- Elixir 1.15+
- Erlang/OTP 26+
- Node.js 18+
- SQLite

### Installation

```bash
# Clone the repository
git clone https://github.com/tremtec/social.git
cd social

# Install dependencies
mix setup

# Start the server
mix phx.server

# Or run in interactive mode
iex -S mix phx.server
```

Visit [http://localhost:4000](http://localhost:4000) to see your app.

### Development

```bash
# Run tests
mix test

# Run tests with coverage
mix test --cover

# Format code
mix format

# Run linter
mix precommit
```

## Project Structure

```
social/
├── lib/
│   ├── social/
│   │   ├── accounts/          # User authentication & RBAC
│   │   ├── organizations/      # Organization management
│   │   └── ...
│   └── social_web/
│       ├── components/         # UI components
│       ├── live/              # LiveView modules
│       │   ├── organization_live/   # Org-specific modules
│       │   │   ├── donations/       # Donations CMS
│       │   │   ├── transparency/    # Transparency portal
│       │   │   └── settings/        # Organization settings
│       │   └── user_live/           # User authentication
│       ├── controllers/        # Phoenix controllers
│       └── router.ex          # Routes
├── design-system/             # Design system documentation
│   ├── colors.md
│   ├── typography.md
│   ├── spacing.md
│   └── components.md
└── priv/
    ├── gettext/              # i18n translations
    └── repo/seeds.exs        # Database seeds
```

## Design System

Social ships with a comprehensive, documented design system:

- 🎨 **Colors**: OKLCH-based palette with light/dark modes
- ✏️ **Typography**: Consistent font scale
- 📐 **Spacing**: Unified spacing scale
- 🧩 **Components**: Reusable patterns

See [design-system/README.md](design-system/README.md) for details.

## Roadmap

- [x] Groundwork (Phoenix, Auth, SQLite, Tailwind)
- [x] UX Design System
- [x] Internationalization (en, pt-BR)
- [ ] Organization Onboarding
  - [ ] Welcome page with create/join organization
  - [ ] Invite code system
- [ ] Donations CMS
- [ ] Transparency Portal
- [ ] Financial Dashboard
- [ ] Admin Panel

## Contributing

Contributions are welcome! We follow a structured workflow:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please read [AGENTS.md](AGENTS.md) for our development workflow and conventions.

## License

This project is open source under the [MIT License](LICENSE).

---

<p align="center">
  <strong>Built with 💜 by <a href="https://tremtec.com">TremTec</a></strong>
  <br>
  <sub>Empowering social impact through technology</sub>
</p>
