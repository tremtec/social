defmodule Social.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :username, :string
      add :name, :string
      add :cnpj, :string
      add :description, :string
      add :mission, :string
      add :founding_date, :date
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:organizations, [:user_id])

    create unique_index(:organizations, [:cnpj])
    create unique_index(:organizations, [:username])
  end
end
