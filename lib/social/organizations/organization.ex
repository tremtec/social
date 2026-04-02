defmodule Social.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "organizations" do
    field :slug, :string
    field :name, :string
    field :cnpj, :string
    field :description, :string
    field :mission, :string
    field :founding_date, :date

    many_to_many :users, Social.Accounts.User, join_through: Social.Organizations.OrganizationUser

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:slug, :name, :cnpj, :description, :mission, :founding_date])
    |> validate_required([:slug, :name, :cnpj, :description, :mission, :founding_date])
    |> unique_constraint(:cnpj)
    |> unique_constraint(:slug)
  end
end
