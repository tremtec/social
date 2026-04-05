defmodule Social.Organizations.OrganizationUser do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "organizations_users" do
    belongs_to :organization, Social.Organizations.Organization
    belongs_to :user, Social.Accounts.User

    field :role, Ecto.Enum, values: [:admin, :member], default: :member
    field :joined_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end
end
