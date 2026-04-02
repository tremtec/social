defmodule SocialWeb.OrganizationLive.Show do
  use SocialWeb, :live_view
  use Gettext, backend: SocialWeb.Gettext

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.private
      flash={@flash}
      current_scope={@current_scope}
      current_org={@org}
      active_section="dashboard"
    >
      <div class="space-y-8">
        <%!-- Welcome Section --%>
        <div class="bg-gradient-to-r from-primary/20 to-secondary/20 rounded-3xl p-8">
          <div class="flex items-center gap-6">
            <div class="w-20 h-20 rounded-2xl bg-primary flex items-center justify-center shadow-lg">
              <.icon name="hero-building-office" class="w-10 h-10 text-primary-content" />
            </div>
            <div>
              <h1 class="text-3xl font-bold mb-1">{@org.name}</h1>
              <p class="text-base-content/70 flex items-center gap-2">
                <.icon name="hero-link" class="w-4 h-4" /> @{@org.slug}
              </p>
            </div>
          </div>
        </div>

        <%!-- Stats Cards --%>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <.stat_card
            icon="hero-users"
            color="primary"
            label={gettext("Volunteers")}
            value={Enum.random([12, 24, 48, 96])}
          />
          <.stat_card
            icon="hero-banknotes"
            color="success"
            label={gettext("Total Donations")}
            value="R$ #{Enum.random([1500, 3200, 8500, 15000])}"
          />
          <.stat_card
            icon="hero-calendar"
            color="info"
            label={gettext("Upcoming Events")}
            value={Enum.random([3, 7, 12, 24])}
          />
          <.stat_card
            icon="hero-megaphone"
            color="warning"
            label={gettext("Active Campaigns")}
            value={Enum.random([1, 2, 5, 8])}
          />
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <%!-- Quick Actions --%>
          <div class="lg:col-span-2 bg-base-200 rounded-3xl p-6 shadow-xl">
            <h2 class="text-xl font-semibold mb-6 flex items-center gap-2">
              <.icon name="hero-rocket-launch" class="w-6 h-6 text-primary" />
              {gettext("Quick Actions")}
            </h2>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
              <.action_button icon="hero-user-plus" color="primary" label={gettext("Add Volunteer")} />
              <.action_button
                icon="hero-currency-dollar"
                color="success"
                label={gettext("Record Donation")}
              />
              <.action_button icon="hero-calendar-plus" color="info" label={gettext("Create Event")} />
              <.action_button
                icon="hero-speaker-wave"
                color="warning"
                label={gettext("New Campaign")}
              />
            </div>
          </div>

          <%!-- Recent Activity --%>
          <div class="bg-base-200 rounded-3xl p-6 shadow-xl">
            <h2 class="text-xl font-semibold mb-6 flex items-center gap-2">
              <.icon name="hero-clock" class="w-6 h-6 text-secondary" />
              {gettext("Recent Activity")}
            </h2>
            <div class="space-y-4">
              <.activity_item :for={activity <- @recent_activities} activity={activity} />
            </div>
            <.link class="btn btn-ghost btn-sm w-full mt-4">
              {gettext("View All Activity")}
              <.icon name="hero-arrow-right" class="w-4 h-4 ml-2" />
            </.link>
          </div>
        </div>

        <%!-- Upcoming Events Preview --%>
        <div class="bg-base-200 rounded-3xl p-6 shadow-xl">
          <div class="flex items-center justify-between mb-6">
            <h2 class="text-xl font-semibold flex items-center gap-2">
              <.icon name="hero-calendar" class="w-6 h-6 text-info" />
              {gettext("Upcoming Events")}
            </h2>
            <.link class="btn btn-ghost btn-sm">
              {gettext("View All")}
              <.icon name="hero-arrow-right" class="w-4 h-4 ml-2" />
            </.link>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <.event_card
              title="Food Drive Collection"
              date="Tomorrow, 9:00 AM"
              location="Community Center"
              volunteers={12}
            />
            <.event_card
              title="Fundraising Gala"
              date="Dec 15, 7:00 PM"
              location="Grand Hotel"
              volunteers={8}
            />
            <.event_card
              title="Volunteer Training"
              date="Dec 18, 2:00 PM"
              location="Online (Zoom)"
              volunteers={25}
            />
          </div>
        </div>
      </div>
    </Layouts.private>
    """
  end

  @impl true
  def mount(%{"org_slug" => org_slug}, _session, socket) do
    # In a real app, we'd fetch the organization from the database
    org = %{
      name: String.split(org_slug, "-") |> Enum.map(&String.capitalize/1) |> Enum.join(" "),
      slug: org_slug
    }

    recent_activities = [
      %{
        user: "Maria Santos",
        action: "Registered 3 new volunteers",
        time: "2 hours ago",
        icon: "hero-user-plus"
      },
      %{
        user: "João Silva",
        action: "Recorded R$ 500 donation",
        time: "5 hours ago",
        icon: "hero-banknotes"
      },
      %{
        user: "Ana Costa",
        action: "Created 'Summer Festival' event",
        time: "Yesterday",
        icon: "hero-calendar"
      },
      %{
        user: "Pedro Oliveira",
        action: "Updated campaign goals",
        time: "2 days ago",
        icon: "hero-megaphone"
      }
    ]

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:recent_activities, recent_activities)}
  end

  # Components

  defp stat_card(assigns) do
    ~H"""
    <div class="bg-base-200 rounded-2xl p-6 shadow-lg hover:shadow-xl transition-shadow">
      <div class="flex items-center gap-4 mb-4">
        <div class={["w-12 h-12 rounded-xl flex items-center justify-center", "bg-#{@color}/20"]}>
          <.icon name={@icon} class={["w-6 h-6", "text-#{@color}"]} />
        </div>
      </div>
      <p class="text-3xl font-bold">{@value}</p>
      <p class="text-sm text-base-content/60 mt-1">{@label}</p>
    </div>
    """
  end

  defp action_button(assigns) do
    ~H"""
    <button class={[
      "flex flex-col items-center gap-3 p-6 rounded-2xl transition-all duration-200 group",
      "bg-base-100 hover:bg-#{@color} hover:shadow-lg"
    ]}>
      <div class={[
        "w-12 h-12 rounded-xl flex items-center justify-center transition-colors",
        "bg-#{@color}/20 group-hover:bg-white/20"
      ]}>
        <.icon name={@icon} class={["w-6 h-6", "text-#{@color} group-hover:text-white"]} />
      </div>
      <span class={["text-sm font-medium text-center", "text-base-content group-hover:text-white"]}>
        {@label}
      </span>
    </button>
    """
  end

  defp activity_item(assigns) do
    ~H"""
    <div class="flex items-start gap-4 p-4 bg-base-100 rounded-xl hover:bg-base-300/50 transition-colors">
      <div class="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center flex-shrink-0">
        <span class="text-primary font-semibold text-sm">
          {String.first(@activity[:user])}
        </span>
      </div>
      <div class="flex-1 min-w-0">
        <p class="font-medium text-sm">{@activity[:action]}</p>
        <p class="text-xs text-base-content/60 mt-1">
          {@activity[:user]} • {@activity[:time]}
        </p>
      </div>
    </div>
    """
  end

  defp event_card(assigns) do
    ~H"""
    <div class="bg-base-100 rounded-2xl p-5 hover:bg-base-300/50 transition-colors cursor-pointer group">
      <div class="flex items-start justify-between mb-3">
        <h4 class="font-semibold group-hover:text-primary transition-colors">{@title}</h4>
        <span class="badge badge-info badge-sm">{gettext("Upcoming")}</span>
      </div>
      <div class="space-y-2 text-sm text-base-content/70">
        <div class="flex items-center gap-2">
          <.icon name="hero-calendar" class="w-4 h-4" />
          <span>{@date}</span>
        </div>
        <div class="flex items-center gap-2">
          <.icon name="hero-map-pin" class="w-4 h-4" />
          <span>{@location}</span>
        </div>
        <div class="flex items-center gap-2">
          <.icon name="hero-users" class="w-4 h-4" />
          <span>{@volunteers} {gettext("volunteers")}</span>
        </div>
      </div>
    </div>
    """
  end
end
