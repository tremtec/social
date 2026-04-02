defmodule SocialWeb.OrganizationLive.Donations.New do
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

      <div class="max-w-2xl mx-auto">
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <div class="flex items-center gap-4 mb-6">
            <div class="w-12 h-12 rounded-xl bg-success/20 flex items-center justify-center">
              <.icon name="hero-plus" class="w-6 h-6 text-success" />
            </div>
            <div>
              <h3 class="text-xl font-semibold">{gettext("Record New Donation")}</h3>
              <p class="text-base-content/70">{gettext("Add a new donation to your records")}</p>
            </div>
          </div>

          <.form for={@form} phx-submit="save" class="space-y-6">
            <.input field={@form[:donor_name]} type="text" label={gettext("Donor Name")} required />
            <.input field={@form[:email]} type="email" label={gettext("Email")} />
            <.input field={@form[:amount]} type="number" label={gettext("Amount (R$)")} required />

            <div class="form-control">
              <label class="label">
                <span class="label-text">{gettext("Donation Type")}</span>
              </label>
              <select name="donation[type]" class="select select-bordered w-full">
                <option value="one_time">{gettext("One-time")}</option>
                <option value="monthly">{gettext("Monthly Recurring")}</option>
                <option value="annual">{gettext("Annual Recurring")}</option>
              </select>
            </div>

            <div class="form-control">
              <label class="label">
                <span class="label-text">{gettext("Payment Method")}</span>
              </label>
              <select name="donation[payment_method]" class="select select-bordered w-full">
                <option value="credit_card">{gettext("Credit Card")}</option>
                <option value="pix">{gettext("PIX")}</option>
                <option value="bank_transfer">{gettext("Bank Transfer")}</option>
                <option value="cash">{gettext("Cash")}</option>
              </select>
            </div>

            <.input field={@form[:notes]} type="textarea" label={gettext("Notes (Optional)")} />

            <div class="flex gap-4 pt-4">
              <.link navigate={"/organizations/#{@org.slug}/donations"} class="btn btn-ghost flex-1">
                {gettext("Cancel")}
              </.link>
              <.button
                type="submit"
                class="btn btn-success flex-1"
                phx-disable-with={gettext("Saving...")}
              >
                <.icon name="hero-check" class="w-5 h-5 mr-2" />
                {gettext("Record Donation")}
              </.button>
            </div>
          </.form>
        </div>
      </div>
    </Layouts.private>
    """
  end

  @impl true
  def mount(%{"org_slug" => org_slug}, _session, socket) do
    org = %{name: String.capitalize(org_slug), slug: org_slug}
    form = to_form(%{}, as: "donation")

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:form, form)
     |> assign(:active_tab, "new")}
  end

  @impl true
  def handle_event("save", _params, socket) do
    {:noreply,
     socket
     |> put_flash(:info, gettext("Donation recorded successfully!"))
     |> push_navigate(to: "/organization/#{socket.assigns.org.slug}/donations")}
  end
end
