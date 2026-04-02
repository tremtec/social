defmodule SocialWeb.OrganizationLive.Transparency.Settings do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.private
      flash={@flash}
      current_scope={@current_scope}
      current_org={@org}
      active_section="transparency"
    >
      <:tabs>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/transparency"}
          active={@active_tab == "overview"}
        >
          <.icon name="hero-eye" class="w-4 h-4" />
          {gettext("Overview")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/transparency/reports"}
          active={@active_tab == "reports"}
        >
          <.icon name="hero-document-text" class="w-4 h-4" />
          {gettext("Reports")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/transparency/documents"}
          active={@active_tab == "documents"}
        >
          <.icon name="hero-folder" class="w-4 h-4" />
          {gettext("Documents")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/transparency/settings"}
          active={@active_tab == "settings"}
        >
          <.icon name="hero-cog-6-tooth" class="w-4 h-4" />
          {gettext("Settings")}
        </Layouts.tab>
      </:tabs>

      <div class="max-w-3xl mx-auto space-y-6">
        <%!-- Visibility Settings --%>
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <h3 class="text-xl font-semibold mb-6 flex items-center gap-2">
            <.icon name="hero-eye" class="w-6 h-6 text-info" />
            {gettext("Public Visibility")}
          </h3>

          <.form for={@form} phx-submit="save" class="space-y-6">
            <div class="form-control">
              <label class="label cursor-pointer justify-start gap-4">
                <input
                  type="checkbox"
                  name="settings[public_page]"
                  class="toggle toggle-primary"
                  checked
                />
                <div>
                  <span class="label-text font-medium">{gettext("Public Transparency Page")}</span>
                  <p class="text-sm text-base-content/60">
                    {gettext("Make your transparency reports visible to the public")}
                  </p>
                </div>
              </label>
            </div>

            <div class="form-control">
              <label class="label cursor-pointer justify-start gap-4">
                <input type="checkbox" name="settings[show_donors]" class="toggle toggle-primary" />
                <div>
                  <span class="label-text font-medium">{gettext("Show Donor Names")}</span>
                  <p class="text-sm text-base-content/60">
                    {gettext("Display donor names on public reports (with their consent)")}
                  </p>
                </div>
              </label>
            </div>

            <div class="form-control">
              <label class="label cursor-pointer justify-start gap-4">
                <input
                  type="checkbox"
                  name="settings[show_amounts]"
                  class="toggle toggle-primary"
                  checked
                />
                <div>
                  <span class="label-text font-medium">{gettext("Show Donation Amounts")}</span>
                  <p class="text-sm text-base-content/60">
                    {gettext("Display donation amounts in public reports")}
                  </p>
                </div>
              </label>
            </div>

            <.button type="submit" class="btn btn-primary w-full">
              <.icon name="hero-check" class="w-5 h-5 mr-2" />
              {gettext("Save Settings")}
            </.button>
          </.form>
        </div>

        <%!-- Report Templates --%>
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <h3 class="text-xl font-semibold mb-6 flex items-center gap-2">
            <.icon name="hero-document-duplicate" class="w-6 h-6 text-secondary" />
            {gettext("Report Templates")}
          </h3>

          <div class="space-y-3">
            <div class="flex items-center justify-between p-4 bg-base-100 rounded-xl">
              <div class="flex items-center gap-3">
                <.icon name="hero-document-text" class="w-5 h-5 text-base-content/60" />
                <span>{gettext("Monthly Financial Report")}</span>
              </div>
              <div class="flex gap-2">
                <button class="btn btn-ghost btn-sm">
                  <.icon name="hero-pencil" class="w-4 h-4" />
                </button>
                <button class="btn btn-ghost btn-sm">
                  <.icon name="hero-trash" class="w-4 h-4" />
                </button>
              </div>
            </div>
            <div class="flex items-center justify-between p-4 bg-base-100 rounded-xl">
              <div class="flex items-center gap-3">
                <.icon name="hero-document-text" class="w-5 h-5 text-base-content/60" />
                <span>{gettext("Annual Impact Report")}</span>
              </div>
              <div class="flex gap-2">
                <button class="btn btn-ghost btn-sm">
                  <.icon name="hero-pencil" class="w-4 h-4" />
                </button>
                <button class="btn btn-ghost btn-sm">
                  <.icon name="hero-trash" class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>

          <button class="btn btn-outline btn-block mt-4">
            <.icon name="hero-plus" class="w-5 h-5 mr-2" />
            {gettext("Create New Template")}
          </button>
        </div>
      </div>
    </Layouts.private>
    """
  end

  @impl true
  def mount(%{"org_slug" => org_slug}, _session, socket) do
    org = %{name: String.capitalize(org_slug), slug: org_slug}
    form = to_form(%{}, as: "settings")

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:form, form)
     |> assign(:active_tab, "settings")}
  end

  @impl true
  def handle_event("save", _params, socket) do
    {:noreply, put_flash(socket, :info, gettext("Settings saved successfully!"))}
  end
end
