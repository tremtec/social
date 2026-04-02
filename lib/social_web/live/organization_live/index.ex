defmodule SocialWeb.OrganizationLive.Index do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.private
      flash={@flash}
      current_scope={@current_scope}
      current_org={@current_org}
      active_section="settings"
    >
      <div class="space-y-8">
        <%!-- Header --%>
        <div class="flex items-center justify-between">
          <div>
            <h1 class="text-3xl font-bold">{gettext("Your Organizations")}</h1>
            <p class="text-base-content/70 mt-1">
              {gettext("Manage and switch between your organizations")}
            </p>
          </div>
        </div>

        <%!-- Organizations List --%>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <%!-- Existing Organizations --%>
          <div
            :for={org <- @organizations}
            class="bg-base-200 rounded-3xl p-6 shadow-xl hover:shadow-2xl transition-shadow"
          >
            <div class="flex items-start justify-between mb-4">
              <div class="w-14 h-14 rounded-2xl bg-primary/20 flex items-center justify-center">
                <.icon name="hero-building-office" class="w-7 h-7 text-primary" />
              </div>
              <span class={[
                "badge",
                if(org.role == "admin", do: "badge-primary", else: "badge-ghost")
              ]}>
                {org.role}
              </span>
            </div>
            <h3 class="text-xl font-semibold mb-1">{org.name}</h3>
            <p class="text-sm text-base-content/60 mb-4">@{org.slug}</p>
            <.link
              navigate={"/organizations/#{org.slug}"}
              class="btn btn-primary btn-block"
            >
              <.icon name="hero-arrow-right" class="w-5 h-5 mr-2" />
              {gettext("Enter Organization")}
            </.link>
          </div>

          <%!-- Add Organization Card --%>
          <.link
            navigate="/organizations/new"
            class="group bg-base-200 rounded-3xl p-6 shadow-xl hover:shadow-2xl transition-all border-2 border-dashed border-base-300 hover:border-primary flex flex-col items-center justify-center text-center min-h-[240px]"
          >
            <div class="w-16 h-16 rounded-2xl bg-primary/10 group-hover:bg-primary/20 flex items-center justify-center mb-4 transition-colors">
              <.icon name="hero-plus" class="w-8 h-8 text-primary" />
            </div>
            <h3 class="text-xl font-semibold mb-2">{gettext("Create Organization")}</h3>
            <p class="text-sm text-base-content/60">
              {gettext("Start a new organization")}
            </p>
          </.link>

          <%!-- Join Organization Card --%>
          <.link
            navigate="/organizations/join"
            class="group bg-base-200 rounded-3xl p-6 shadow-xl hover:shadow-2xl transition-all border-2 border-dashed border-base-300 hover:border-secondary flex flex-col items-center justify-center text-center min-h-[240px]"
          >
            <div class="w-16 h-16 rounded-2xl bg-secondary/10 group-hover:bg-secondary/20 flex items-center justify-center mb-4 transition-colors">
              <.icon name="hero-arrow-right-end-on-rectangle" class="w-8 h-8 text-secondary" />
            </div>
            <h3 class="text-xl font-semibold mb-2">{gettext("Join Organization")}</h3>
            <p class="text-sm text-base-content/60">
              {gettext("Join an existing team")}
            </p>
          </.link>
        </div>

        <%!-- Empty State --%>
        <div :if={@organizations == []} class="text-center py-16">
          <div class="w-24 h-24 mx-auto mb-6 rounded-3xl bg-base-200 flex items-center justify-center">
            <.icon name="hero-building-office" class="w-12 h-12 text-base-content/30" />
          </div>
          <h3 class="text-xl font-semibold mb-2">{gettext("No organizations yet")}</h3>
          <p class="text-base-content/60 mb-6 max-w-md mx-auto">
            {gettext(
              "You haven't joined any organizations yet. Create a new one or join an existing organization to get started."
            )}
          </p>
          <div class="flex items-center justify-center gap-4">
            <.link navigate="/organizations/new" class="btn btn-primary">
              <.icon name="hero-plus" class="w-5 h-5 mr-2" />
              {gettext("Create Organization")}
            </.link>
            <.link navigate="/organizations/join" class="btn btn-outline">
              <.icon name="hero-arrow-right-end-on-rectangle" class="w-5 h-5 mr-2" />
              {gettext("Join Organization")}
            </.link>
          </div>
        </div>
      </div>
    </Layouts.private>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user

    # Get user's organizations
    organizations =
      if function_exported?(Social.Accounts, :user_organizations, 1) do
        Social.Accounts.user_organizations(user)
        |> Enum.map(&Map.put(&1, :role, "member"))
      else
        []
      end

    # Set current_org to nil since this is the list page
    {:ok,
     socket
     |> assign(:organizations, organizations)
     |> assign(:current_org, nil)}
  end
end
