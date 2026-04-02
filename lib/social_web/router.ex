defmodule SocialWeb.Router do
  use SocialWeb, :router

  import SocialWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_user
    plug SocialWeb.Plugs.Locale
    plug :put_root_layout, html: {SocialWeb.Layouts, :root}
  end

  # Pipeline for routes that require an organization
  pipeline :org_required do
    plug SocialWeb.Plugs.RequireOrganization
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SocialWeb do
    pipe_through :browser

    # Landing page - uses the existing :current_user live_session below
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:social, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SocialWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", SocialWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [
        {SocialWeb.UserAuth, :mount_current_scope},
        {SocialWeb.Hooks.Locale, :set_locale}
      ] do
      # User settings
      live "/users/settings", UserLive.Settings, :edit
      live "/users/settings/confirm-email/:token", UserLive.Settings, :confirm_email

      # Onboarding flow (NO SIDEBAR)
      # These pages are for users without organizations
      live "/onboarding", OrganizationLive.Onboarding, :index
      live "/onboarding/create-organization", OrganizationLive.OnboardingCreate, :new
      live "/onboarding/join-organization", OrganizationLive.OnboardingJoin, :new
    end

    post "/users/update-password", UserSessionController, :update_password
  end

  # Routes that require an organization - uses org_required pipeline
  scope "/organizations", SocialWeb do
    pipe_through [:browser, :require_authenticated_user, :org_required]

    live_session :require_authenticated_user_org,
      on_mount: [
        {SocialWeb.UserAuth, :mount_current_scope},
        {SocialWeb.Hooks.Locale, :set_locale}
      ] do
      # Organizations index - shows all user's orgs with options to add/join (WITH SIDEBAR)
      live "/", OrganizationLive.Index, :index

      # Standalone pages for creating/joining organizations (NO SIDEBAR)
      live "/new", OrganizationLive.New, :new
      live "/join", OrganizationLive.Join, :new

      # Organization Dashboard (WITH SIDEBAR - requires org context)
      live "/:org_slug", OrganizationLive.Show, :show

      # Donations Section (WITH SIDEBAR and internal tabs)
      live "/:org_slug/donations", OrganizationLive.Donations.Index, :index
      live "/:org_slug/donations/new", OrganizationLive.Donations.New, :new
      live "/:org_slug/donations/settings", OrganizationLive.Donations.Settings, :settings

      # Transparency Section (WITH SIDEBAR and internal tabs)
      live "/:org_slug/transparency", OrganizationLive.Transparency.Index, :index
      live "/:org_slug/transparency/settings", OrganizationLive.Transparency.Settings, :settings

      # Organization Settings Section (WITH SIDEBAR and internal tabs)
      live "/:org_slug/settings", OrganizationLive.Settings.Index, :index
      live "/:org_slug/settings/members", OrganizationLive.Settings.Members, :members
    end
  end

  scope "/", SocialWeb do
    pipe_through [:browser]

    live_session :current_user,
      on_mount: [
        {SocialWeb.UserAuth, :mount_current_scope},
        {SocialWeb.Hooks.Locale, :set_locale}
      ] do
      # Landing page
      live "/", PageLive, :index

      # Authentication
      live "/users/register", UserLive.Registration, :new
      live "/users/log-in", UserLive.Login, :new
      live "/users/log-in/:token", UserLive.Confirmation, :new
    end

    post "/users/log-in", UserSessionController, :create
    delete "/users/log-out", UserSessionController, :delete
  end
end
