defmodule SocialWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use SocialWeb, :html
  use Gettext, backend: SocialWeb.Gettext

  alias Social.Accounts

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  attr :hide_navbar, :boolean, default: false

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <main>
      <%!-- show navbar conditionally based on `@hide_navbar` assign, which is used for onboarding flow to hide navbar for unauthenticated users --%>
      {unless @hide_navbar do
        public_navbar(%{current_scope: @current_scope})
      end}

      {render_slot(@inner_block)}
    </main>

    <.flash_group flash={@flash} />
    """
  end

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  defp public_navbar(assigns) do
    ~H"""
    <header class="navbar px-4 sm:px-6 lg:px-8">
      <div class="flex-1">
        <a href="/" class="flex-1 flex w-fit items-center gap-2 text-[currentColor]">
          <.logo size="md" />
          <span class="text-sm font-semibold">{gettext("Social Tools")}</span>
        </a>
      </div>
      <div class="flex-none">
        <ul class="flex flex-column px-1 space-x-4 items-center">
          <li>
            <.theme_toggle />
          </li>

          <%= if @current_scope && @current_scope.user do %>
            <li>
              <.link
                navigate={dashboard_path(@current_scope.user)}
                class="btn btn-primary btn-sm"
              >
                {gettext("Go To Dashboard")}
              </.link>
            </li>
          <% else %>
            <li>
              <.link
                navigate={~p"/users/log-in"}
                class="btn btn-ghost btn-sm"
              >
                {gettext("Log in")}
              </.link>
            </li>

            <li>
              <.link
                navigate={~p"/users/register"}
                class="btn btn-primary btn-sm"
              >
                {gettext("Join Us")}
              </.link>
            </li>
          <% end %>
        </ul>
      </div>
    </header>
    """
  end

  # Helper function to determine the appropriate dashboard path for a user
  # based on their organization membership.
  # Returns:
  #   - /onboarding if user has no organizations
  #   - /organizations/:slug if user has one organization
  #   - /organizations if user has multiple organizations
  defp dashboard_path(user) do
    organizations = Accounts.user_organizations(user)

    cond do
      Enum.empty?(organizations) -> ~p"/onboarding"
      length(organizations) == 1 -> ~p"/organizations/#{List.first(organizations).slug}"
      true -> ~p"/organizations"
    end
  end

  @doc """
  Renders a private layout with sidebar and navigation.
  This layout is used for authenticated pages within an organization context.

  ## Examples

      <Layouts.private flash={@flash} current_scope={@current_scope} current_org={@current_org}>
        <h1>Content</h1>
      </Layouts.private>
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :current_scope, :map, required: true, doc: "the current user scope"
  attr :current_org, :any, default: nil, doc: "the current organization"

  attr :active_section, :string,
    default: "donations",
    doc: "the active section (donations, transparency, settings)"

  slot :inner_block, required: true
  slot :tabs, doc: "optional internal tabs navigation"

  def private(assigns) do
    ~H"""
    <div class="min-h-screen bg-base-100 flex">
      <%!-- Sidebar --%>
      <aside class="w-64 bg-base-200 border-r border-base-300 flex flex-col fixed h-full">
        <%!-- Logo --%>
        <div class="p-6 border-b border-base-300">
          <a href="/" class="flex items-center gap-3 text-[currentColor]">
            <.logo size="lg" />
            <div>
              <span class="text-lg font-bold block leading-tight">{gettext("Social")}</span>
              <span class="text-xs text-base-content/60">{gettext("Tools")}</span>
            </div>
          </a>
        </div>

        <%!-- Organization Selector --%>
        <div class="p-4">
          <.link
            navigate="/organizations"
            class="flex items-center gap-3 p-3 bg-base-300 rounded-xl hover:bg-base-100 transition-colors"
          >
            <div class="w-10 h-10 rounded-lg bg-primary/20 flex items-center justify-center">
              <.icon name="hero-building-office" class="w-5 h-5 text-primary" />
            </div>
            <div class="flex-1 min-w-0">
              <p class="font-medium truncate">
                {if @current_org, do: @current_org.name, else: gettext("Select Organization")}
              </p>
              <p class="text-xs text-base-content/60">{gettext("Click to switch")}</p>
            </div>
            <.icon name="hero-chevron-right" class="w-4 h-4 text-base-content/40" />
          </.link>
        </div>

        <%!-- Main Navigation --%>
        <nav class="flex-1 px-4 py-2 space-y-1 overflow-y-auto">
          <.nav_item
            href={if @current_org, do: "/organizations/#{@current_org.slug}/donations", else: "/"}
            icon="hero-banknotes"
            active={@active_section == "donations"}
          >
            {gettext("Donations")}
          </.nav_item>

          <.nav_item
            href={if @current_org, do: "/organizations/#{@current_org.slug}/transparency", else: "/"}
            icon="hero-eye"
            active={@active_section == "transparency"}
          >
            {gettext("Transparency")}
          </.nav_item>

          <.nav_item
            href={if @current_org, do: "/organizations/#{@current_org.slug}/settings", else: "/"}
            icon="hero-cog-6-tooth"
            active={@active_section == "settings"}
          >
            {gettext("Settings")}
          </.nav_item>
        </nav>

        <%!-- Bottom Actions --%>
        <div class="p-4 border-t border-base-300 space-y-2">
          <div class="flex items-center gap-3 px-3 py-2">
            <.theme_toggle />
          </div>

          <.link
            href={~p"/users/log-out"}
            method="delete"
            class="flex items-center gap-3 px-3 py-2 rounded-xl text-base-content/70 hover:bg-base-300 hover:text-error transition-colors"
          >
            <.icon name="hero-arrow-right-on-rectangle" class="w-5 h-5" />
            <span>{gettext("Log out")}</span>
          </.link>
        </div>
      </aside>

      <%!-- Main Content --%>
      <main class="flex-1 ml-64">
        <%!-- Top Bar --%>
        <div class="h-16 bg-base-200/50 backdrop-blur border-b border-base-300 flex items-center justify-between px-8 sticky top-0 z-10">
          <div class="flex items-center gap-4">
            <h2 class="text-lg font-semibold capitalize">
              {@active_section}
            </h2>
          </div>

          <div class="flex items-center gap-4">
            <div class="flex items-center gap-2 text-sm text-base-content/70">
              <.icon name="hero-user-circle" class="w-5 h-5" />
              <span>{@current_scope.user.email}</span>
            </div>
          </div>
        </div>

        <%!-- Internal Tabs Navigation --%>
        <%= if @tabs != [] and @tabs != nil do %>
          <div class="bg-base-200 border-b border-base-300 px-8">
            <div class="flex items-center gap-1 -mb-px">
              {render_slot(@tabs)}
            </div>
          </div>
        <% end %>

        <%!-- Page Content --%>
        <div class="p-8">
          {render_slot(@inner_block)}
        </div>
      </main>

      <.flash_group flash={@flash} />
    </div>
    """
  end

  @doc """
  Renders a tab for internal navigation.
  """
  attr :href, :string, required: true
  attr :active, :boolean, default: false
  slot :inner_block, required: true

  def tab(assigns) do
    ~H"""
    <.link
      href={@href}
      class={[
        "inline-flex items-center gap-2 px-4 py-3 text-sm font-medium border-b-2 transition-colors",
        if(@active,
          do: "border-primary text-primary",
          else:
            "border-transparent text-base-content/70 hover:text-base-content hover:border-base-300"
        )
      ]}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  attr :href, :string, required: true
  attr :icon, :string, required: true
  attr :active, :boolean, default: false
  slot :inner_block, required: true

  defp nav_item(assigns) do
    ~H"""
    <.link
      href={@href}
      class={[
        "flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group",
        if(@active,
          do: "bg-primary text-primary-content font-medium",
          else: "text-base-content/70 hover:bg-base-300 hover:text-base-content"
        )
      ]}
    >
      <.icon
        name={@icon}
        class={[
          "w-5 h-5 transition-colors",
          if(@active, do: "text-primary-content", else: "group-hover:text-base-content")
        ]}
      />
      <span>{render_slot(@inner_block)}</span>
      <%= if @active do %>
        <div class="ml-auto w-1.5 h-1.5 rounded-full bg-primary-content" />
      <% end %>
    </.link>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full w-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=social-light]_&]:left-1/3 [[data-theme=social-dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3 justify-center"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
        title={gettext("System theme")}
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3 justify-center"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="social-light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3 justify-center"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="social-dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
