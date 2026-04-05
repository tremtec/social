defmodule Social.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :name, :string
      add :cnpj, :string
      add :description, :string
      add :mission, :string
      add :founding_date, :date

      timestamps(type: :utc_datetime)
    end

    create unique_index(:organizations, [:cnpj])
    create unique_index(:organizations, [:slug])
  end
end
