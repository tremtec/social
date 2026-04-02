defmodule SocialWeb.OrganizationLive.Transparency.Index do
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

      <div class="space-y-8">
        <%!-- Transparency Score Card --%>
        <div class="bg-gradient-to-r from-info/20 to-success/20 rounded-3xl p-8">
          <div class="flex items-center gap-6">
            <div class="w-24 h-24 rounded-full bg-success flex items-center justify-center shadow-lg">
              <span class="text-3xl font-bold text-success-content">92%</span>
            </div>
            <div>
              <h3 class="text-2xl font-bold mb-1">{gettext("Transparency Score")}</h3>
              <p class="text-base-content/70">
                {gettext("Great job! Your organization is very transparent. Keep up the good work!")}
              </p>
            </div>
          </div>
        </div>

        <%!-- Public Stats --%>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
          <.stat_card icon="hero-banknotes" value="R$ 45.2K" label={gettext("Total Raised")} />
          <.stat_card icon="hero-users" value="128" label={gettext("Total Donors")} />
          <.stat_card icon="hero-document-text" value="24" label={gettext("Reports Published")} />
          <.stat_card icon="hero-calendar" value="365" label={gettext("Days Active")} />
        </div>

        <%!-- Recent Reports --%>
        <div class="bg-base-200 rounded-3xl shadow-xl overflow-hidden">
          <div class="p-6 border-b border-base-300 flex items-center justify-between">
            <h3 class="text-lg font-semibold">{gettext("Recent Transparency Reports")}</h3>
            <.link
              navigate={"/organizations/#{@org.slug}/transparency/reports/new"}
              class="btn btn-primary btn-sm"
            >
              <.icon name="hero-plus" class="w-4 h-4 mr-2" />
              {gettext("New Report")}
            </.link>
          </div>
          <div class="divide-y divide-base-300">
            <.report_row
              :for={report <- @reports}
              report={report}
              org_slug={@org.slug}
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

    reports = [
      %{
        id: 1,
        title: "Q4 2024 Financial Report",
        date: "Dec 1, 2024",
        status: "published",
        views: 234
      },
      %{
        id: 2,
        title: "Annual Impact Report 2024",
        date: "Nov 15, 2024",
        status: "published",
        views: 567
      },
      %{
        id: 3,
        title: "October Donation Summary",
        date: "Oct 31, 2024",
        status: "published",
        views: 189
      },
      %{id: 4, title: "Q3 Financial Statement", date: "Sep 30, 2024", status: "draft", views: 0}
    ]

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:reports, reports)
     |> assign(:active_tab, "overview")}
  end

  defp stat_card(assigns) do
    ~H"""
    <div class="bg-base-200 rounded-2xl p-6 text-center shadow-lg">
      <.icon name={@icon} class="w-8 h-8 text-primary mx-auto mb-3" />
      <p class="text-2xl font-bold">{@value}</p>
      <p class="text-sm text-base-content/60">{@label}</p>
    </div>
    """
  end

  defp report_row(assigns) do
    ~H"""
    <div class="p-4 flex items-center justify-between hover:bg-base-300/50 transition-colors">
      <div class="flex items-center gap-4">
        <div class="w-10 h-10 rounded-lg bg-info/20 flex items-center justify-center">
          <.icon name="hero-document-text" class="w-5 h-5 text-info" />
        </div>
        <div>
          <p class="font-medium">{@report.title}</p>
          <p class="text-sm text-base-content/60">
            {@report.date} • {@report.views} {gettext("views")}
          </p>
        </div>
      </div>
      <div class="flex items-center gap-3">
        <span class={[
          "badge badge-sm",
          if(@report.status == "published", do: "badge-success", else: "badge-ghost")
        ]}>
          {@report.status}
        </span>
        <.link
          navigate={"/organizations/#{@org_slug}/transparency/reports/#{@report.id}"}
          class="btn btn-ghost btn-sm"
        >
          <.icon name="hero-eye" class="w-4 h-4" />
        </.link>
      </div>
    </div>
    """
  end
end
