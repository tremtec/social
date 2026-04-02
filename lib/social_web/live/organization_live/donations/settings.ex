defmodule SocialWeb.OrganizationLive.Donations.Settings do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.private
      flash={@flash}
      current_scope={@current_scope}
      current_org={@org}
      active_section="donations"
    >
      <:tabs>
        <Layouts.tab href={"/organizations/#{@org.slug}/donations"} active={@active_tab == "list"}>
          <.icon name="hero-list-bullet" class="w-4 h-4" />
          {gettext("All Donations")}
        </Layouts.tab>
        <Layouts.tab href={"/organizations/#{@org.slug}/donations/new"} active={@active_tab == "new"}>
          <.icon name="hero-plus" class="w-4 h-4" />
          {gettext("New Donation")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/donations/reports"}
          active={@active_tab == "reports"}
        >
          <.icon name="hero-chart-bar" class="w-4 h-4" />
          {gettext("Reports")}
        </Layouts.tab>
        <Layouts.tab
          href={"/organizations/#{@org.slug}/donations/settings"}
          active={@active_tab == "settings"}
        >
          <.icon name="hero-cog-6-tooth" class="w-4 h-4" />
          {gettext("Settings")}
        </Layouts.tab>
      </:tabs>

      <div class="max-w-3xl mx-auto space-y-6">
        <%!-- General Settings --%>
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <h3 class="text-xl font-semibold mb-6 flex items-center gap-2">
            <.icon name="hero-cog-6-tooth" class="w-6 h-6 text-primary" />
            {gettext("Donation Settings")}
          </h3>

          <.form for={@form} phx-submit="save" class="space-y-6">
            <div class="form-control">
              <label class="label cursor-pointer justify-start gap-4">
                <input
                  type="checkbox"
                  name="settings[enable_recurring]"
                  class="checkbox checkbox-primary"
                  checked
                />
                <div>
                  <span class="label-text font-medium">{gettext("Enable Recurring Donations")}</span>
                  <p class="text-sm text-base-content/60">
                    {gettext("Allow donors to set up monthly or annual donations")}
                  </p>
                </div>
              </label>
            </div>

            <div class="form-control">
              <label class="label cursor-pointer justify-start gap-4">
                <input
                  type="checkbox"
                  name="settings[enable_anonymous]"
                  class="checkbox checkbox-primary"
                  checked
                />
                <div>
                  <span class="label-text font-medium">{gettext("Allow Anonymous Donations")}</span>
                  <p class="text-sm text-base-content/60">
                    {gettext("Let donors contribute without revealing their identity")}
                  </p>
                </div>
              </label>
            </div>

            <.input
              field={@form[:minimum_amount]}
              type="number"
              label={gettext("Minimum Donation Amount (R$)")}
              value="10"
            />

            <.input
              field={@form[:thank_you_message]}
              type="textarea"
              label={gettext("Thank You Message")}
              value="Thank you for your generous donation!"
            />

            <.button type="submit" class="btn btn-primary w-full">
              <.icon name="hero-check" class="w-5 h-5 mr-2" />
              {gettext("Save Settings")}
            </.button>
          </.form>
        </div>

        <%!-- Danger Zone --%>
        <div class="bg-error/10 border border-error/30 rounded-3xl p-8">
          <h3 class="text-xl font-semibold mb-4 text-error flex items-center gap-2">
            <.icon name="hero-exclamation-triangle" class="w-6 h-6" />
            {gettext("Danger Zone")}
          </h3>
          <p class="text-base-content/70 mb-4">
            {gettext("These actions are irreversible. Please be careful.")}
          </p>
          <button class="btn btn-error btn-outline">
            <.icon name="hero-trash" class="w-5 h-5 mr-2" />
            {gettext("Delete All Donation Records")}
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
