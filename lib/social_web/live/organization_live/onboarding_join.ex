defmodule SocialWeb.OrganizationLive.OnboardingJoin do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-gradient-to-br from-secondary/5 via-base-100 to-primary/5 py-12">
        <div class="max-w-xl mx-auto px-4">
          <%!-- Progress Stepper --%>
          <div class="flex items-center justify-center mb-8">
            <div class="flex items-center gap-4">
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-primary text-primary-content flex items-center justify-center text-sm font-bold">
                  1
                </div>
                <span class="text-sm font-medium text-primary">{gettext("Welcome")}</span>
              </div>
              <div class="w-12 h-0.5 bg-primary"></div>
              <div class="flex items-center gap-2">
                <div class="w-8 h-8 rounded-full bg-primary text-primary-content flex items-center justify-center text-sm font-bold">
                  2
                </div>
                <span class="text-sm font-medium text-primary">{gettext("Join Org")}</span>
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

          <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
            <div class="text-center mb-8">
              <div class="w-20 h-20 mx-auto mb-4 rounded-2xl bg-secondary flex items-center justify-center shadow-lg">
                <.icon name="hero-user-plus" class="w-10 h-10 text-secondary-content" />
              </div>
              <h1 class="text-3xl font-bold mb-2">{gettext("Join an Organization")}</h1>
              <p class="text-base-content/70">
                {gettext("Enter the organization slug to request access.")}
              </p>
            </div>

            <.form for={@form} id="join-organization-form" phx-submit="join" class="space-y-6">
              <div class="form-control">
                <label class="label">
                  <span class="label-text font-medium">{gettext("Organization Slug")}</span>
                </label>
                <div class="join w-full">
                  <div class="join-item flex items-center px-4 bg-base-300 border border-r-0 border-base-300 rounded-l-xl">
                    <span class="text-base-content/50">@</span>
                  </div>
                  <input
                    type="text"
                    name="join[slug]"
                    placeholder={gettext("organization-slug")}
                    class="input input-bordered join-item flex-1"
                    required
                  />
                </div>
                <label class="label">
                  <span class="label-text-alt text-base-content/60">
                    {gettext("Ask your organization admin for the slug")}
                  </span>
                </label>
              </div>

              <.button
                phx-disable-with={gettext("Joining...")}
                class="btn btn-secondary w-full btn-lg"
              >
                <.icon name="hero-arrow-right-end-on-rectangle" class="w-5 h-5 mr-2" />
                {gettext("Request to Join")}
              </.button>
            </.form>

            <div class="divider my-8">{gettext("OR")}</div>

            <div class="text-center">
              <p class="text-base-content/70 mb-4">
                {gettext("Want to create your own organization?")}
              </p>
              <.link navigate="/onboarding/create-organization" class="btn btn-outline btn-primary">
                <.icon name="hero-plus" class="w-5 h-5 mr-2" />
                {gettext("Create Organization")}
              </.link>
            </div>
          </div>

          <%!-- Help Card --%>
          <div class="mt-8 bg-info/10 border border-info/30 rounded-2xl p-6">
            <div class="flex items-start gap-4">
              <div class="w-10 h-10 rounded-xl bg-info/20 flex items-center justify-center flex-shrink-0">
                <.icon name="hero-question-mark-circle" class="w-6 h-6 text-info" />
              </div>
              <div>
                <h4 class="font-semibold mb-1">{gettext("How do I get the slug?")}</h4>
                <p class="text-sm text-base-content/70">
                  {gettext(
                    "The organization slug is the unique identifier used in the organization's URL. Contact your organization administrator to get the correct slug."
                  )}
                </p>
              </div>
            </div>
          </div>

          <%!-- Back Button --%>
          <div class="mt-8 text-center">
            <.link navigate="/onboarding" class="btn btn-ghost">
              <.icon name="hero-arrow-left" class="w-5 h-5 mr-2" />
              {gettext("Back to Welcome")}
            </.link>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "join")
    {:ok, assign(socket, :form, form)}
  end

  @impl true
  def handle_event("join", %{"join" => %{"slug" => slug}}, socket) do
    # TODO: Real backend logic to verify slug exists and join organization

    {:noreply,
     socket
     |> put_flash(:info, gettext("Joined organization successfully!"))
     |> push_navigate(to: "/organizations/#{slug}")}
  end
end
