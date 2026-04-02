defmodule SocialWeb.OrganizationLive.Onboarding do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-gradient-to-br from-primary/5 via-base-100 to-secondary/5 flex items-center justify-center p-4">
        <div class="max-w-4xl w-full">
          <%!-- Progress Stepper --%>
          <div class="flex items-center justify-center mb-12">
            <div class="flex items-center gap-4">
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-primary text-primary-content flex items-center justify-center text-sm font-bold">
                  1
                </div>
                <span class="text-sm font-medium text-primary">{gettext("Welcome")}</span>
              </div>
              <div class="w-12 h-0.5 bg-base-300"></div>
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-base-300 text-base-content/50 flex items-center justify-center text-sm font-bold">
                  2
                </div>
                <span class="text-sm font-medium text-base-content/50">{gettext("Setup")}</span>
              </div>
              <div class="w-12 h-0.5 bg-base-300"></div>
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-base-300 text-base-content/50 flex items-center justify-center text-sm font-bold">
                  3
                </div>
                <span class="text-sm font-medium text-base-content/50">{gettext("Dashboard")}</span>
              </div>
            </div>
          </div>

          <%!-- Welcome Header --%>
          <div class="text-center mb-12">
            <div class="w-24 h-24 mx-auto mb-6 rounded-3xl bg-primary flex items-center justify-center shadow-xl">
              <.icon name="hero-rocket-launch" class="w-12 h-12 text-primary-content" />
            </div>
            <h1 class="text-4xl md:text-5xl font-bold mb-4">{gettext("Welcome to Social Tools")}</h1>
            <p class="text-xl text-base-content/70 max-w-2xl mx-auto">
              {gettext("Let's get you started. Choose an option below to begin your journey.")}
            </p>
          </div>

          <%!-- Options Grid --%>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <%!-- Create Organization Card --%>
            <.link
              navigate="/onboarding/create-organization"
              class="group relative bg-base-200 rounded-3xl p-8 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1 overflow-hidden"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
              <div class="relative">
                <div class="w-20 h-20 rounded-2xl bg-primary flex items-center justify-center mb-6 shadow-lg group-hover:scale-110 transition-transform">
                  <.icon name="hero-plus" class="w-10 h-10 text-primary-content" />
                </div>
                <h2 class="text-2xl font-bold mb-3">{gettext("Create Organization")}</h2>
                <p class="text-base-content/70 mb-6">
                  {gettext(
                    "Start your own organization and invite team members to collaborate. Perfect for NGOs, foundations, and social projects."
                  )}
                </p>
                <div class="flex items-center text-primary font-semibold">
                  <span>{gettext("Get Started")}</span>
                  <.icon
                    name="hero-arrow-right"
                    class="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform"
                  />
                </div>
              </div>
            </.link>

            <%!-- Join Organization Card --%>
            <.link
              navigate="/onboarding/join-organization"
              class="group relative bg-base-200 rounded-3xl p-8 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1 overflow-hidden"
            >
              <div class="absolute inset-0 bg-gradient-to-br from-secondary/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
              <div class="relative">
                <div class="w-20 h-20 rounded-2xl bg-secondary flex items-center justify-center mb-6 shadow-lg group-hover:scale-110 transition-transform">
                  <.icon
                    name="hero-arrow-right-end-on-rectangle"
                    class="w-10 h-10 text-secondary-content"
                  />
                </div>
                <h2 class="text-2xl font-bold mb-3">{gettext("Join Organization")}</h2>
                <p class="text-base-content/70 mb-6">
                  {gettext(
                    "Already have an invitation? Enter your organization's unique slug to join an existing team and start collaborating."
                  )}
                </p>
                <div class="flex items-center text-secondary font-semibold">
                  <span>{gettext("Join Now")}</span>
                  <.icon
                    name="hero-arrow-right"
                    class="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform"
                  />
                </div>
              </div>
            </.link>
          </div>

          <%!-- Help Section --%>
          <div class="mt-12 text-center">
            <p class="text-base-content/60">
              {gettext("Need help getting started?")}
              <.link href="#" class="text-primary hover:underline ml-1">
                {gettext("Contact our support team")}
              </.link>
            </p>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
