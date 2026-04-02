defmodule Social.Organizations do
  @moduledoc """
  The Organizations context.
  """

  import Ecto.Query, warn: false
  alias Social.Repo
  alias Social.Organizations.Organization
  alias Social.Organizations.OrganizationUser

  def create_organization(%Social.Accounts.Scope{} = scope, attrs) do
    Repo.transact(fn ->
      with {:ok, organization} <-
             %Organization{}
             |> Organization.changeset(attrs)
             |> Repo.insert(),
           # Create org-user relation
           {:ok, _} <-
             Repo.insert(%OrganizationUser{
               organization_id: organization.id,
               user_id: scope.user.id,
               role: :admin,
               joined_at: DateTime.utc_now()
             }) do
        {:ok, Repo.preload(organization, :users)}
      end
    end)
  end

  def get_user_organizations(%Social.Accounts.User{} = user) do
    Organization
    |> join(:inner, [o], ou in assoc(o, :users))
    |> where([o, ou], ou.id == ^user.id)
    |> Repo.all()
    |> Repo.preload(:users)
  end

  def get_organization_users(%Social.Organizations.Organization{} = organization) do
    OrganizationUser
    |> where([ou], ou.organization_id == ^organization.id)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def is_admin?(%Social.Accounts.User{} = user, %Organization{} = organization) do
    OrganizationUser
    |> where(
      [ou],
      ou.user_id == ^user.id and
        ou.organization_id == ^organization.id and
        ou.role == :admin
    )
    |> Repo.exists?()
  end

  def is_member?(%Social.Accounts.User{} = user, %Organization{} = organization) do
    OrganizationUser
    |> where([ou], ou.user_id == ^user.id and ou.organization_id == ^organization.id)
    |> Repo.exists?()
  end

  def change_organization(%Organization{} = organization, attrs \\ %{}) do
    Organization.changeset(organization, attrs)
  end
end
