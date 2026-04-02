defmodule SocialWeb.OrganizationLive.Donations.Index do
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

      <div class="space-y-6">
        <%!-- Summary Cards --%>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <.summary_card
            icon="hero-banknotes"
            color="success"
            label={gettext("Total This Month")}
            value="R$ 12,450.00"
          />
          <.summary_card
            icon="hero-users"
            color="primary"
            label={gettext("Total Donors")}
            value="48"
          />
          <.summary_card
            icon="hero-calendar"
            color="info"
            label={gettext("Last Donation")}
            value="2 hours ago"
          />
        </div>

        <%!-- Donations List --%>
        <div class="bg-base-200 rounded-3xl shadow-xl overflow-hidden">
          <div class="p-6 border-b border-base-300 flex items-center justify-between">
            <h3 class="text-lg font-semibold">{gettext("Recent Donations")}</h3>
            <.link
              navigate={"/organizations/#{@org.slug}/donations/new"}
              class="btn btn-primary btn-sm"
            >
              <.icon name="hero-plus" class="w-4 h-4 mr-2" />
              {gettext("Add Donation")}
            </.link>
          </div>
          <div class="divide-y divide-base-300">
            <.donation_row
              :for={donation <- @donations}
              donation={donation}
            />
          </div>
        </div>
      </div>
    </Layouts.private>
    """
  end

  @impl true
  def mount(%{"org_slug" => org_slug}, _session, socket) do
    org = %{name: String.capitalize(org_slug), slug: org_slug}

    donations = [
      %{
        id: 1,
        donor: "João Silva",
        amount: "R$ 500,00",
        date: "Today",
        type: "Monthly",
        status: "confirmed"
      },
      %{
        id: 2,
        donor: "Maria Santos",
        amount: "R$ 1.200,00",
        date: "Yesterday",
        type: "One-time",
        status: "confirmed"
      },
      %{
        id: 3,
        donor: "Pedro Costa",
        amount: "R$ 150,00",
        date: "3 days ago",
        type: "Monthly",
        status: "pending"
      },
      %{
        id: 4,
        donor: "Ana Oliveira",
        amount: "R$ 2.000,00",
        date: "1 week ago",
        type: "One-time",
        status: "confirmed"
      }
    ]

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:donations, donations)
     |> assign(:active_tab, "list")}
  end

  defp summary_card(assigns) do
    ~H"""
    <div class="bg-base-200 rounded-2xl p-6 shadow-lg">
      <div class="flex items-center gap-4 mb-3">
        <div class={["w-12 h-12 rounded-xl flex items-center justify-center", "bg-#{@color}/20"]}>
          <.icon name={@icon} class={["w-6 h-6", "text-#{@color}"]} />
        </div>
      </div>
      <p class="text-2xl font-bold">{@value}</p>
      <p class="text-sm text-base-content/60">{@label}</p>
    </div>
    """
  end

  defp donation_row(assigns) do
    ~H"""
    <div class="p-4 flex items-center justify-between hover:bg-base-300/50 transition-colors">
      <div class="flex items-center gap-4">
        <div class="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center">
          <span class="text-primary font-semibold">
            {String.first(@donation.donor)}
          </span>
        </div>
        <div>
          <p class="font-medium">{@donation.donor}</p>
          <p class="text-sm text-base-content/60">
            {@donation.type} • {@donation.date}
          </p>
        </div>
      </div>
      <div class="flex items-center gap-4">
        <span class="font-semibold text-success">{@donation.amount}</span>
        <span class={[
          "badge badge-sm",
          if(@donation.status == "confirmed", do: "badge-success", else: "badge-warning")
        ]}>
          {@donation.status}
        </span>
      </div>
    </div>
    """
  end
end
