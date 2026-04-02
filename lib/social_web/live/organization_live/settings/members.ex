defmodule SocialWeb.OrganizationLive.Settings.Members do
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

      <div class="space-y-6">
        <%!-- Invite Member --%>
        <div class="bg-base-200 rounded-3xl p-8 shadow-xl">
          <h3 class="text-xl font-semibold mb-6">{gettext("Invite Team Member")}</h3>
          <div class="flex gap-4">
            <.input
              field={@form[:email]}
              type="email"
              placeholder={gettext("email@example.com")}
            />
            <select class="select select-bordered">
              <option value="admin">{gettext("Admin")}</option>
              <option value="manager">{gettext("Manager")}</option>
              <option value="member">{gettext("Member")}</option>
            </select>
            <button class="btn btn-primary">
              <.icon name="hero-envelope" class="w-5 h-5 mr-2" />
              {gettext("Invite")}
            </button>
          </div>
        </div>

        <%!-- Members List --%>
        <div class="bg-base-200 rounded-3xl shadow-xl overflow-hidden">
          <div class="p-6 border-b border-base-300">
            <h3 class="text-xl font-semibold">{gettext("Team Members")}</h3>
          </div>
          <div class="divide-y divide-base-300">
            <.member_row
              :for={member <- @members}
              member={member}
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
    form = to_form(%{}, as: "invite")

    members = [
      %{id: 1, name: "Maria Santos", email: "maria@example.com", role: "Admin", status: "active"},
      %{id: 2, name: "João Silva", email: "joao@example.com", role: "Manager", status: "active"},
      %{id: 3, name: "Ana Costa", email: "ana@example.com", role: "Member", status: "pending"},
      %{
        id: 4,
        name: "Pedro Oliveira",
        email: "pedro@example.com",
        role: "Member",
        status: "active"
      }
    ]

    {:ok,
     socket
     |> assign(:org, org)
     |> assign(:form, form)
     |> assign(:members, members)
     |> assign(:active_tab, "members")}
  end

  defp member_row(assigns) do
    ~H"""
    <div class="p-4 flex items-center justify-between hover:bg-base-300/50 transition-colors">
      <div class="flex items-center gap-4">
        <div class="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center">
          <span class="text-primary font-semibold">
            {String.first(@member.name)}
          </span>
        </div>
        <div>
          <p class="font-medium">{@member.name}</p>
          <p class="text-sm text-base-content/60">{@member.email}</p>
        </div>
      </div>
      <div class="flex items-center gap-4">
        <span class={[
          "badge badge-sm",
          if(@member.status == "active", do: "badge-success", else: "badge-warning")
        ]}>
          {@member.status}
        </span>
        <select class="select select-bordered select-sm">
          <option selected={@member.role == "Admin"}>Admin</option>
          <option selected={@member.role == "Manager"}>Manager</option>
          <option selected={@member.role == "Member"}>Member</option>
        </select>
        <button class="btn btn-ghost btn-sm text-error">
          <.icon name="hero-trash" class="w-4 h-4" />
        </button>
      </div>
    </div>
    """
  end
end
