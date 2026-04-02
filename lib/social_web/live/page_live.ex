defmodule SocialWeb.PageLive do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-base-100">
        <!-- Hero Section -->
        <section class="relative overflow-hidden bg-gradient-to-br from-primary/10 via-base-100 to-secondary/10 py-24 lg:py-32">
          <!-- Animated Background -->
          <div class="absolute inset-0 overflow-hidden">
            <div class="absolute -top-40 -right-40 w-80 h-80 bg-primary/20 rounded-full blur-3xl animate-pulse" />
            <div class="absolute -bottom-40 -left-40 w-80 h-80 bg-secondary/20 rounded-full blur-3xl animate-pulse delay-700" />
            <svg class="absolute inset-0 h-full w-full opacity-30" xmlns="http://www.w3.org/2000/svg">
              <defs>
                <pattern id="grid" width="60" height="60" patternUnits="userSpaceOnUse">
                  <circle cx="30" cy="30" r="1" fill="currentColor" class="text-primary/10" />
                </pattern>
              </defs>
              <rect width="100%" height="100%" fill="url(#grid)" />
            </svg>
          </div>

          <div class="relative mx-auto max-w-6xl px-4">
            <div class="text-center max-w-4xl mx-auto">
              <div class="inline-flex items-center gap-2 px-5 py-2.5 rounded-full bg-primary/15 text-primary mb-8 shadow-lg shadow-primary/20 animate-fade-in-up">
                <.icon name="hero-sparkles" class="w-5 h-5" />
                <span class="text-sm font-semibold tracking-wide uppercase">
                  {gettext("By TremTec")}
                </span>
              </div>

              <h1 class="text-5xl md:text-6xl lg:text-7xl font-bold text-base-content mb-6 leading-tight">
                {gettext("Transform How")} <br />
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary">
                  {gettext("You Impact Society")}
                </span>
              </h1>

              <p class="text-xl md:text-2xl text-base-content/70 max-w-2xl mx-auto mb-10 leading-relaxed">
                {gettext(
                  "The complete platform for NGOs to manage volunteers, donations, and events—all in one powerful, intuitive solution."
                )}
              </p>

              <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                <a
                  href={~p"/users/register"}
                  class="btn btn-primary btn-lg gap-2 shadow-xl shadow-primary/30 hover:shadow-primary/50 transition-all duration-300 transform hover:-translate-y-1"
                >
                  <.icon name="hero-rocket-launch" class="w-6 h-6" />
                  {gettext("Start Free Trial")}
                </a>
                <a href="#features" class="btn btn-ghost btn-lg gap-2">
                  <.icon name="hero-arrow-down" class="w-6 h-6" />
                  {gettext("Explore Features")}
                </a>
              </div>
              
    <!-- Hero Stats -->
              <div class="grid grid-cols-3 gap-6 mt-16 max-w-xl mx-auto">
                <div class="text-center">
                  <div class="text-3xl md:text-4xl font-bold text-primary">500+</div>
                  <div class="text-sm text-base-content/60 mt-1">{gettext("Organizations")}</div>
                </div>
                <div class="text-center">
                  <div class="text-3xl md:text-4xl font-bold text-secondary">50K+</div>
                  <div class="text-sm text-base-content/60 mt-1">{gettext("Volunteers")}</div>
                </div>
                <div class="text-center">
                  <div class="text-3xl md:text-4xl font-bold text-warning">R$ 10M+</div>
                  <div class="text-sm text-base-content/60 mt-1">{gettext("Donations Managed")}</div>
                </div>
              </div>
            </div>
          </div>
        </section>
        
    <!-- Trusted By / Logos -->
        <section class="py-12 bg-base-200/30 border-y border-base-200/50">
          <div class="mx-auto max-w-6xl px-4">
            <p class="text-center text-base-content/50 text-sm font-medium mb-8 uppercase tracking-widest">
              {gettext("Trusted by leading organizations")}
            </p>
            <div class="flex flex-wrap justify-center items-center gap-8 md:gap-16 opacity-60">
              <div class="flex items-center gap-2 text-lg font-bold text-base-content/70">
                <.icon name="hero-heart" class="w-6 h-6 text-secondary" />
                {gettext("NGO Brasil")}
              </div>
              <div class="flex items-center gap-2 text-lg font-bold text-base-content/70">
                <.icon name="hero-user-group" class="w-6 h-6 text-primary" />
                {gettext("Voluntários")}
              </div>
              <div class="flex items-center gap-2 text-lg font-bold text-base-content/70">
                <.icon name="hero-hand-heart" class="w-6 h-6 text-warning" />
                {gettext("DoeBem")}
              </div>
              <div class="flex items-center gap-2 text-lg font-bold text-base-content/70">
                <.icon name="hero-users" class="w-6 h-6 text-primary" />
                {gettext("Comunidade")}
              </div>
            </div>
          </div>
        </section>
        
    <!-- Features Section -->
        <section id="features" class="py-24 px-4">
          <div class="mx-auto max-w-6xl">
            <div class="text-center mb-16">
              <div class="inline-block px-4 py-1.5 rounded-full bg-primary/10 text-primary text-sm font-semibold mb-4">
                {gettext("Features")}
              </div>
              <h2 class="text-4xl md:text-5xl font-bold text-base-content mb-6">
                {gettext("Everything You Need to Make a Difference")}
              </h2>
              <p class="text-xl text-base-content/60 max-w-2xl mx-auto">
                {gettext(
                  "Powerful tools designed specifically for social organizations. Focus on what matters most—making an impact."
                )}
              </p>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
              <!-- Feature 1 -->
              <.social_card glass hover padding="large" class="group">
                <div class="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-box" />
                <div class="relative">
                  <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/15 text-primary mb-6 group-hover:scale-110 transition-transform duration-300">
                    <.icon name="hero-user-group" class="w-8 h-8" />
                  </div>
                  <h3 class="text-xl font-bold text-base-content mb-3">
                    {gettext("Volunteer Management")}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {gettext(
                      "Easily register, organize, and track your volunteers. Schedule activities, assign tasks, and measure impact—all in one place."
                    )}
                  </p>
                  <ul class="mt-4 space-y-2">
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Activity tracking"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Skill matching"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Hours reporting"
                      )}
                    </li>
                  </ul>
                </div>
              </.social_card>
              
    <!-- Feature 2 -->
              <.social_card glass hover padding="large" class="group">
                <div class="absolute inset-0 bg-gradient-to-br from-secondary/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-box" />
                <div class="relative">
                  <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-secondary/15 text-secondary mb-6 group-hover:scale-110 transition-transform duration-300">
                    <.icon name="hero-currency-dollar" class="w-8 h-8" />
                  </div>
                  <h3 class="text-xl font-bold text-base-content mb-3">
                    {gettext("Donation Control")}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {gettext(
                      "Manage financial and material donations with complete transparency. Generate reports and keep your donors informed."
                    )}
                  </p>
                  <ul class="mt-4 space-y-2">
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Real-time tracking"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Donor management"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Tax receipts"
                      )}
                    </li>
                  </ul>
                </div>
              </.social_card>
              
    <!-- Feature 3 -->
              <.social_card glass hover padding="large" class="group">
                <div class="absolute inset-0 bg-gradient-to-br from-warning/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-box" />
                <div class="relative">
                  <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-warning/15 text-warning mb-6 group-hover:scale-110 transition-transform duration-300">
                    <.icon name="hero-calendar-days" class="w-8 h-8" />
                  </div>
                  <h3 class="text-xl font-bold text-base-content mb-3">
                    {gettext("Event Planning")}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {gettext(
                      "Organize events and campaigns with powerful planning tools. Coordinate teams, manage budgets, and maximize attendance."
                    )}
                  </p>
                  <ul class="mt-4 space-y-2">
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Event registration"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Budget planning"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Attendance tracking"
                      )}
                    </li>
                  </ul>
                </div>
              </.social_card>
              
    <!-- Feature 4 -->
              <.social_card glass hover padding="large" class="group">
                <div class="absolute inset-0 bg-gradient-to-br from-info/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-box" />
                <div class="relative">
                  <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-info/15 text-info mb-6 group-hover:scale-110 transition-transform duration-300">
                    <.icon name="hero-chart-bar" class="w-8 h-8" />
                  </div>
                  <h3 class="text-xl font-bold text-base-content mb-3">
                    {gettext("Analytics & Reports")}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {gettext(
                      "Get actionable insights with powerful analytics. Understand your impact and make data-driven decisions."
                    )}
                  </p>
                  <ul class="mt-4 space-y-2">
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Impact metrics"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Custom reports"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Export options"
                      )}
                    </li>
                  </ul>
                </div>
              </.social_card>
              
    <!-- Feature 5 -->
              <.social_card glass hover padding="large" class="group">
                <div class="absolute inset-0 bg-gradient-to-br from-accent/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-box" />
                <div class="relative">
                  <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-accent/15 text-accent mb-6 group-hover:scale-110 transition-transform duration-300">
                    <.icon name="hero-bell" class="w-8 h-8" />
                  </div>
                  <h3 class="text-xl font-bold text-base-content mb-3">
                    {gettext("Automated Notifications")}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {gettext(
                      "Keep everyone informed with automated reminders and notifications. Never miss an important event or deadline."
                    )}
                  </p>
                  <ul class="mt-4 space-y-2">
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext("Email & SMS")}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Scheduled reminders"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Custom templates"
                      )}
                    </li>
                  </ul>
                </div>
              </.social_card>
              
    <!-- Feature 6 -->
              <.social_card glass hover padding="large" class="group">
                <div class="absolute inset-0 bg-gradient-to-br from-error/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-box" />
                <div class="relative">
                  <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-error/15 text-error mb-6 group-hover:scale-110 transition-transform duration-300">
                    <.icon name="hero-shield-check" class="w-8 h-8" />
                  </div>
                  <h3 class="text-xl font-bold text-base-content mb-3">
                    {gettext("Secure & Compliant")}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {gettext(
                      "Your data is protected with enterprise-grade security. Full GDPR compliance and data encryption."
                    )}
                  </p>
                  <ul class="mt-4 space-y-2">
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Data encryption"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext(
                        "Role-based access"
                      )}
                    </li>
                    <li class="flex items-center gap-2 text-sm text-base-content/70">
                      <.icon name="hero-check" class="w-4 h-4 text-success" /> {gettext("Audit logs")}
                    </li>
                  </ul>
                </div>
              </.social_card>
            </div>
          </div>
        </section>
        
    <!-- How It Works -->
        <section class="py-24 px-4 bg-base-200/30">
          <div class="mx-auto max-w-6xl">
            <div class="text-center mb-16">
              <div class="inline-block px-4 py-1.5 rounded-full bg-secondary/10 text-secondary text-sm font-semibold mb-4">
                {gettext("How It Works")}
              </div>
              <h2 class="text-4xl md:text-5xl font-bold text-base-content mb-6">
                {gettext("Get Started in Minutes")}
              </h2>
            </div>

            <div class="grid md:grid-cols-3 gap-8 relative">
              <!-- Connecting line (desktop) -->
              <div class="hidden md:block absolute top-20 left-1/6 right-1/6 h-0.5 bg-gradient-to-r from-primary via-secondary to-warning" />
              
    <!-- Step 1 -->
              <div class="relative text-center">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary text-primary-content text-2xl font-bold mb-6 shadow-lg shadow-primary/30">
                  1
                </div>
                <h3 class="text-xl font-bold text-base-content mb-3">
                  {gettext("Create Your Organization")}
                </h3>
                <p class="text-base-content/60">
                  {gettext("Sign up and set up your organization's profile in just a few clicks.")}
                </p>
              </div>
              
    <!-- Step 2 -->
              <div class="relative text-center">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-secondary text-secondary-content text-2xl font-bold mb-6 shadow-lg shadow-secondary/30">
                  2
                </div>
                <h3 class="text-xl font-bold text-base-content mb-3">
                  {gettext("Invite Your Team")}
                </h3>
                <p class="text-base-content/60">
                  {gettext("Add volunteers and team members with customizable access levels.")}
                </p>
              </div>
              
    <!-- Step 3 -->
              <div class="relative text-center">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-warning text-warning-content text-2xl font-bold mb-6 shadow-lg shadow-warning/30">
                  3
                </div>
                <h3 class="text-xl font-bold text-base-content mb-3">
                  {gettext("Start Making Impact")}
                </h3>
                <p class="text-base-content/60">
                  {gettext("Begin managing volunteers, donations, and events effectively.")}
                </p>
              </div>
            </div>
          </div>
        </section>
        
    <!-- Testimonials -->
        <section class="py-24 px-4">
          <div class="mx-auto max-w-6xl">
            <div class="text-center mb-16">
              <div class="inline-block px-4 py-1.5 rounded-full bg-primary/10 text-primary text-sm font-semibold mb-4">
                {gettext("Testimonials")}
              </div>
              <h2 class="text-4xl md:text-5xl font-bold text-base-content mb-6">
                {gettext("Loved by Social Organizations")}
              </h2>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
              <.social_card padding="large" class="relative">
                <div class="absolute -top-4 left-6">
                  <.icon name="hero-quote-left" class="w-8 h-8 text-primary/30" />
                </div>
                <p class="text-base-content/70 italic mb-6 leading-relaxed">
                  {gettext(
                    "\"SocialTools transformed how we manage our 200+ volunteers. The transparency in donations has increased donor trust significantly.\""
                  )}
                </p>
                <div class="flex items-center gap-4">
                  <.social_avatar name="Maria Santos" size="lg" />
                  <div>
                    <div class="font-semibold text-base-content">{gettext("Maria Santos")}</div>
                    <div class="text-sm text-base-content/60">{gettext("Director, NGO Brasil")}</div>
                  </div>
                </div>
              </.social_card>

              <.social_card padding="large" class="relative">
                <div class="absolute -top-4 left-6">
                  <.icon name="hero-quote-left" class="w-8 h-8 text-secondary/30" />
                </div>
                <p class="text-base-content/70 italic mb-6 leading-relaxed">
                  {gettext(
                    "\"The event planning features saved us countless hours. Our last fundraiser was our most successful ever!\""
                  )}
                </p>
                <div class="flex items-center gap-4">
                  <.social_avatar name="João Silva" size="lg" />
                  <div>
                    <div class="font-semibold text-base-content">{gettext("João Silva")}</div>
                    <div class="text-sm text-base-content/60">{gettext("Coordinator, DoeBem")}</div>
                  </div>
                </div>
              </.social_card>

              <.social_card padding="large" class="relative">
                <div class="absolute -top-4 left-6">
                  <.icon name="hero-quote-left" class="w-8 h-8 text-warning/30" />
                </div>
                <p class="text-base-content/70 italic mb-6 leading-relaxed">
                  {gettext(
                    "\"Finally, a tool that understands the unique needs of social organizations. Highly recommended!\""
                  )}
                </p>
                <div class="flex items-center gap-4">
                  <.social_avatar name="Ana Costa" size="lg" />
                  <div>
                    <div class="font-semibold text-base-content">{gettext("Ana Costa")}</div>
                    <div class="text-sm text-base-content/60">{gettext("Founder, Comunidade")}</div>
                  </div>
                </div>
              </.social_card>
            </div>
          </div>
        </section>
        
    <!-- Pricing Preview -->
        <section class="py-24 px-4 bg-base-200/30">
          <div class="mx-auto max-w-6xl">
            <div class="text-center mb-16">
              <div class="inline-block px-4 py-1.5 rounded-full bg-secondary/10 text-secondary text-sm font-semibold mb-4">
                {gettext("Pricing")}
              </div>
              <h2 class="text-4xl md:text-5xl font-bold text-base-content mb-6">
                {gettext("Simple, Transparent Pricing")}
              </h2>
              <p class="text-xl text-base-content/60 max-w-2xl mx-auto">
                {gettext("Start free and scale as you grow. No hidden fees, cancel anytime.")}
              </p>
            </div>

            <div class="grid md:grid-cols-3 gap-8 max-w-5xl mx-auto">
              <!-- Free Plan -->
              <.social_card padding="large" class="text-center">
                <h3 class="text-xl font-bold text-base-content mb-2">{gettext("Starter")}</h3>
                <div class="text-4xl font-bold text-base-content mb-1">{gettext("Free")}</div>
                <p class="text-base-content/60 text-sm mb-6">
                  {gettext("Perfect for small organizations")}
                </p>
                <ul class="text-left space-y-3 mb-8">
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Up to 50 volunteers"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Basic analytics"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext("Email support")}
                  </li>
                </ul>
                <a href={~p"/users/register"} class="btn btn-outline btn-primary btn-block">
                  {gettext("Get Started")}
                </a>
              </.social_card>
              
    <!-- Pro Plan -->
              <.social_card
                padding="large"
                class="text-center relative transform md:scale-105 border-2 border-primary"
              >
                <div class="absolute -top-3 left-1/2 -translate-x-1/2">
                  <.social_badge variant="primary">{gettext("Most Popular")}</.social_badge>
                </div>
                <h3 class="text-xl font-bold text-base-content mb-2">{gettext("Professional")}</h3>
                <div class="text-4xl font-bold text-primary mb-1">
                  R$ 97<span class="text-lg text-base-content/60">/mo</span>
                </div>
                <p class="text-base-content/60 text-sm mb-6">
                  {gettext("For growing organizations")}
                </p>
                <ul class="text-left space-y-3 mb-8">
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Unlimited volunteers"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Advanced analytics"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Priority support"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Custom branding"
                    )}
                  </li>
                </ul>
                <a href={~p"/users/register"} class="btn btn-primary btn-block">
                  {gettext("Start Free Trial")}
                </a>
              </.social_card>
              
    <!-- Enterprise Plan -->
              <.social_card padding="large" class="text-center">
                <h3 class="text-xl font-bold text-base-content mb-2">{gettext("Enterprise")}</h3>
                <div class="text-4xl font-bold text-base-content mb-1">{gettext("Custom")}</div>
                <p class="text-base-content/60 text-sm mb-6">{gettext("For large organizations")}</p>
                <ul class="text-left space-y-3 mb-8">
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Everything in Pro"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Dedicated manager"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext(
                      "Custom integrations"
                    )}
                  </li>
                  <li class="flex items-center gap-2 text-base-content/70">
                    <.icon name="hero-check" class="w-5 h-5 text-success" /> {gettext("SLA guarantee")}
                  </li>
                </ul>
                <a href="#" class="btn btn-outline btn-primary btn-block">
                  {gettext("Contact Sales")}
                </a>
              </.social_card>
            </div>
          </div>
        </section>
        
    <!-- CTA Section -->
        <section class="py-24 px-4">
          <div class="mx-auto max-w-4xl text-center">
            <.social_card glass padding="large" class="relative overflow-hidden">
              <div class="absolute inset-0 bg-gradient-to-r from-primary/10 via-secondary/10 to-warning/10" />
              <div class="relative">
                <h2 class="text-3xl md:text-4xl font-bold text-base-content mb-4">
                  {gettext("Ready to Amplify Your Impact?")}
                </h2>
                <p class="text-xl text-base-content/60 mb-8 max-w-xl mx-auto">
                  {gettext(
                    "Join 500+ organizations already making a difference with SocialTools. Start your free trial today."
                  )}
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                  <a
                    href={~p"/users/register"}
                    class="btn btn-primary btn-lg gap-2 shadow-xl shadow-primary/30"
                  >
                    <.icon name="hero-rocket-launch" class="w-5 h-5" />
                    {gettext("Start Free Trial")}
                  </a>
                  <a href="#" class="btn btn-ghost btn-lg gap-2">
                    <.icon name="hero-chat-bubble-left" class="w-5 h-5" />
                    {gettext("Talk to Consultant")}
                  </a>
                </div>
                <p class="text-sm text-base-content/50 mt-4">
                  {gettext("No credit card required. 14-day free trial.")}
                </p>
              </div>
            </.social_card>
          </div>
        </section>
        
    <!-- Footer -->
        <footer class="py-12 px-4 bg-base-200/50 border-t border-base-200">
          <div class="mx-auto max-w-6xl">
            <div class="grid md:grid-cols-4 gap-8 mb-8">
              <div class="md:col-span-2">
                <div class="flex items-center gap-3 mb-4 text-[currentColor]">
                  <.logo size="lg" />
                  <span class="text-lg font-bold text-base-content">SocialTools</span>
                </div>
                <p class="text-base-content/60 max-w-sm">
                  {gettext(
                    "The complete platform for NGOs to manage volunteers, donations, and events. Making social impact easier than ever."
                  )}
                </p>
              </div>
              <div>
                <h4 class="font-semibold text-base-content mb-4">{gettext("Product")}</h4>
                <ul class="space-y-2 text-base-content/60">
                  <li>
                    <a href="#features" class="hover:text-primary transition-colors">
                      {gettext("Features")}
                    </a>
                  </li>
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">{gettext("Pricing")}</a>
                  </li>
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">
                      {gettext("Integrations")}
                    </a>
                  </li>
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">{gettext("API")}</a>
                  </li>
                </ul>
              </div>
              <div>
                <h4 class="font-semibold text-base-content mb-4">{gettext("Company")}</h4>
                <ul class="space-y-2 text-base-content/60">
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">{gettext("About")}</a>
                  </li>
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">{gettext("Blog")}</a>
                  </li>
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">{gettext("Careers")}</a>
                  </li>
                  <li>
                    <a href="#" class="hover:text-primary transition-colors">{gettext("Contact")}</a>
                  </li>
                </ul>
              </div>
            </div>
            <div class="flex flex-col md:flex-row justify-between items-center gap-4 pt-8 border-t border-base-200">
              <div class="flex items-center gap-2 text-base-content/60">
                <.icon name="hero-heart" class="w-5 h-5 text-secondary" />
                <span>{gettext("SocialTools by TremTec")}</span>
              </div>
              <div class="flex items-center gap-4">
                <a href="#" class="text-base-content/60 hover:text-primary transition-colors">
                  <.icon name="hero-globe-alt" class="w-5 h-5" />
                </a>
                <a href="#" class="text-base-content/60 hover:text-primary transition-colors">
                  <.icon name="hero-chat-bubble-left-right" class="w-5 h-5" />
                </a>
                <a href="#" class="text-base-content/60 hover:text-primary transition-colors">
                  <.icon name="hero-link" class="w-5 h-5" />
                </a>
              </div>
              <Layouts.theme_toggle />
            </div>
          </div>
        </footer>
      </div>
    </Layouts.app>
    """
  end
end
