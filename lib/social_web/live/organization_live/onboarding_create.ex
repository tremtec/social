defmodule SocialWeb.OrganizationLive.OnboardingCreate do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="min-h-screen bg-gradient-to-br from-primary/5 via-base-100 to-secondary/5 py-12">
        <div class="max-w-2xl mx-auto px-4">
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
                <span class="text-sm font-medium text-primary">{gettext("Create Org")}</span>
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
              <div class="w-20 h-20 mx-auto mb-4 rounded-2xl bg-primary flex items-center justify-center shadow-lg">
                <.icon name="hero-plus" class="w-10 h-10 text-primary-content" />
              </div>
              <h1 class="text-3xl font-bold mb-2">{gettext("Create Your Organization")}</h1>
              <p class="text-base-content/70">
                {gettext("Let's set up your organization. This will only take a few minutes.")}
              </p>
            </div>

            <.form for={@form} id="create-organization-form" phx-submit="create" class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <.input
                  field={@form[:name]}
                  type="text"
                  label={gettext("Organization Name")}
                  placeholder={gettext("e.g., TremTec Foundation")}
                  required
                />

                <.input
                  field={@form[:slug]}
                  type="text"
                  label={gettext("URL Slug")}
                  placeholder={gettext("e.g., tremtec-foundation")}
                  required
                />
              </div>

              <.input
                field={@form[:cnpj]}
                type="text"
                label={gettext("CNPJ")}
                placeholder={gettext("e.g., 12.345.678/0001-90")}
                required
              />

              <.input
                field={@form[:description]}
                type="textarea"
                label={gettext("Description")}
                placeholder={gettext("Brief description of your organization")}
                required
              />

              <.input
                field={@form[:mission]}
                type="textarea"
                label={gettext("Mission")}
                placeholder={gettext("Your organization's mission statement")}
                required
              />

              <div class="form-control">
                <label class="label">
                  <span class="label-text font-medium">{gettext("Founding Date")}</span>
                </label>
                <input
                  type="date"
                  name="organization[founding_date]"
                  id="organization_founding_date"
                  class="input input-bordered w-full"
                  required
                />
              </div>

              <div class="flex items-center gap-4 pt-4">
                <.link
                  navigate="/onboarding"
                  class="btn btn-ghost flex-1"
                >
                  <.icon name="hero-arrow-left" class="w-5 h-5 mr-2" />
                  {gettext("Back")}
                </.link>
                <.button
                  phx-disable-with={gettext("Creating...")}
                  class="btn btn-primary flex-1"
                >
                  <.icon name="hero-check" class="w-5 h-5 mr-2" />
                  {gettext("Create Organization")}
                </.button>
              </div>
            </.form>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "organization")
    {:ok, assign(socket, :form, form)}
  end

  @impl true
  def handle_event("create", %{"organization" => _params}, socket) do
    # TODO: Real backend logic to create organization
    fake_slug = "org-#{:rand.uniform(9999)}"

    {:noreply,
     socket
     |> put_flash(:info, gettext("Organization created successfully!"))
     |> push_navigate(to: "/organizations/#{fake_slug}")}
  end
end
