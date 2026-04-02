defmodule SocialWeb.OrganizationLive.Settings.Index do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.private
      flash={@flash}
      current_scope={@current_scope}
      current_org={@org}
      active_section="settings"
    >
      <:tabs>
        <Layouts.tab href={"/organizations/#{@org.slug}/settings"} active={@active_tab == "general"}>
          <.icon name="hero-cog-6-tooth" class="w-4 h-4" />
          {gettext("General")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/settings/members"}
          active={@active_tab == "members"}
        >
          <.icon name="hero-users" class="w-4 h-4" />
          {gettext("Members")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/settings/billing"}
          active={@active_tab == "billing"}
        >
          <.icon name="hero-credit-card" class="w-4 h-4" />
          {gettext("Billing")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/settings/advanced"}
          active={@active_tab == "advanced"}
        >
          <.icon name="hero-wrench" class="w-4 h-4" />
          {gettext("Advanced")}
        </Layouts.tab>
      </:tabs>

      <div class="max-w-3xl mx-auto space-y-6">
        <%!-- Organization Info --%>
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <h3 class="text-xl font-semibold mb-6">{gettext("Organization Information")}</h3>

          <.form for={@form} phx-submit="save" class="space-y-6">
            <.input
              field={@form[:name]}
              type="text"
              label={gettext("Organization Name")}
              value={@org.name}
            />
            <.input
              field={@form[:slug]}
              type="text"
              label={gettext("URL Slug")}
              value={@org.slug}
              disabled
            />
            <.input
              field={@form[:cnpj]}
              type="text"
              label={gettext("CNPJ")}
              value="12.345.678/0001-90"
            />
            <.input field={@form[:description]} type="textarea" label={gettext("Description")} />
            <.input field={@form[:mission]} type="textarea" label={gettext("Mission")} />

            <div class="form-control">
              <label class="label">
                <span class="label-text">{gettext("Organization Logo")}</span>
              </label>
              <div class="flex items-center gap-4">
                <div class="w-20 h-20 rounded-2xl bg-primary/20 flex items-center justify-center">
                  <.icon name="hero-building-office" class="w-10 h-10 text-primary" />
                </div>
                <button type="button" class="btn btn-outline">
                  <.icon name="hero-arrow-up-tray" class="w-5 h-5 mr-2" />
                  {gettext("Upload New Logo")}
                </button>
              </div>
            </div>

            <.button type="submit" class="btn btn-primary w-full">
              <.icon name="hero-check" class="w-5 h-5 mr-2" />
              {gettext("Save Changes")}
            </.button>
          </.form>
        </div>

        <%!-- Contact Info --%>
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <h3 class="text-xl font-semibold mb-6">{gettext("Contact Information")}</h3>

          <div class="space-y-4">
            <.input
              field={@form[:email]}
              type="email"
              label={gettext("Public Email")}
              placeholder="contact@organization.org"
            />
            <.input
              field={@form[:phone]}
              type="tel"
              label={gettext("Phone")}
              placeholder="+55 (11) 99999-9999"
            />
            <.input
              field={@form[:website]}
              type="url"
              label={gettext("Website")}
              placeholder="https://www.organization.org"
            />
            <.input field={@form[:address]} type="textarea" label={gettext("Address")} />
          </div>
        </div>
      </div>
    </Layouts.private>
    """
  end

  @impl true
  def mount(%{"org_slug" => org_slug}, _session, socket) do
    org = %{name: String.capitalize(org_slug), slug: org_slug}
    form = to_form(%{}, as: "organization")

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:form, form)
     |> assign(:active_tab, "general")}
  end

  @impl true
  def handle_event("save", _params, socket) do
    {:noreply, put_flash(socket, :info, gettext("Settings saved successfully!"))}
  end
end
