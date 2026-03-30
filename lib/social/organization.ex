defmodule Social.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :username, :string
    field :name, :string
    field :cnpj, :string
    field :description, :string
    field :mission, :string
    field :founding_date, :date
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization, attrs, user_scope) do
    organization
    |> cast(attrs, [:username, :name, :cnpj, :description, :mission, :founding_date])
    |> validate_required([:username, :name, :cnpj, :description, :mission, :founding_date])
    |> unique_constraint(:cnpj)
    |> unique_constraint(:username)
    |> put_change(:user_id, user_scope.user.id)
  end
end
