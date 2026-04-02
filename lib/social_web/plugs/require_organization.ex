defmodule SocialWeb.Plugs.RequireOrganization do
  use SocialWeb, :verified_routes

  @moduledoc """
  Plug that redirects users based on their organization state.

  - If user has NO organizations AND is NOT on an onboarding path → redirect to /onboarding
  - If user HAS organizations AND IS on an onboarding path → redirect to /organizations
  """
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  @onboarding_paths ~w[/onboarding /onboarding/create-organization /onboarding/join-organization]
  @skip_paths ~w[/users/log-in /users/register /users/confirm /users/settings]

  def init(opts), do: opts

  def call(conn, _opts) when conn.method != "GET", do: conn

  def call(conn, _opts) do
    with %{user: user} <- conn.assigns[:current_scope],
         true <- skip_path?(conn.request_path) == false,
         true <- should_redirect?(user, conn.request_path) do
      do_redirect(user, conn)
    else
      _ -> conn
    end
  end

  defp skip_path?(path), do: path in @skip_paths

  defp should_redirect?(nil, _path), do: false
  defp should_redirect?(_user, path) when path in @skip_paths, do: false

  defp should_redirect?(user, path) do
    redirect_path = Social.Accounts.organization_redirect_path(user)
    on_onboarding_path? = path in @onboarding_paths

    (redirect_path == "/onboarding" and not on_onboarding_path?) ||
      (redirect_path == "/organizations" and on_onboarding_path?)
  end

  defp do_redirect(user, conn) do
    path =
      if Social.Accounts.organization_redirect_path(user) == "/onboarding",
        do: ~p"/onboarding",
        else: ~p"/organizations"

    conn |> redirect(to: path) |> halt()
  end
end
