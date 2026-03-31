defmodule Social.Organizations do
  @moduledoc """
  The Organizations context.
  """

  import Ecto.Query, warn: false
  alias Social.Repo
  alias Social.Organizations.Organization
  alias Social.Organizations.OrganizationUser

  def create_organization(%Social.Accounts.Scope{} = scope, attrs) do
    # 1. Create organiozation
    # 2. Insert OrganizationUser with role: :admin
    # 3. Return Organization with users preloaded
  end

  def get_user_organizations(%Social.Accounts.User{} = user) do
    # Query organizations where user is member
  end

  def get_organization_users(%Social.Accounts.User{} = user) do
    # Query organizations where user is member
  end

  def is_admin?(%Social.Accounts.User{} = user) do
    # check if user is admin
  end

  def is_member?(%Social.Accounts.User{} = user) do
    # check if user is admin
  end

  def change_organization(%Organization{} = organization, attrs \\ %{}) do
    Organization.changeset(organization, attrs)
  end
end
