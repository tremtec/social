defmodule SocialWeb.OrganizationLive.Join do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.private
      flash={@flash}
      current_scope={@current_scope}
      current_org={nil}
      active_section="settings"
    >
      <div class="max-w-xl mx-auto">
        <%!-- Breadcrumb --%>
        <div class="flex items-center gap-2 text-sm text-base-content/60 mb-6">
          <.link navigate="/organizations" class="hover:text-primary transition-colors">
            {gettext("Organizations")}
          </.link>
          <.icon name="hero-chevron-right" class="w-4 h-4" />
          <span>{gettext("Join")}</span>
        </div>

        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <div class="text-center mb-8">
            <div class="w-20 h-20 mx-auto mb-4 rounded-2xl bg-secondary/20 flex items-center justify-center">
              <.icon name="hero-user-plus" class="w-10 h-10 text-secondary" />
            </div>
            <h1 class="text-3xl font-bold mb-2">{gettext("Join Organization")}</h1>
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
                <.input
                  field={@form[:slug]}
                  type="text"
                  placeholder={gettext("organization-slug")}
                  required
                  class="join-item flex-1"
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
            <.link navigate="/organizations/new" class="btn btn-outline btn-primary">
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
      </div>
    </Layouts.private>
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
    # For prototype, we'll just redirect to a fake org

    {:noreply,
     socket
     |> put_flash(:info, gettext("Joined organization successfully!"))
     |> push_navigate(to: "/organizations/#{slug}")}
  end
end
