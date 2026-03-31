defmodule Social.Repo.Migrations.CreateOrganizationUsers do
  use Ecto.Migration

  def change do
    create table(:organization_users, primary_key: false) do
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      add :organization_id, references(:organizations, type: :binary_id, on_delete: :delete_all),
        null: false

      add :role, :string, default: "member"
      add :joined_at, :utc_datetime, default: "CURRENT_TIMESTAMP"

      timestamps(type: :utc_datetime)
    end

    create index(:organization_users, [:user_id])
    create index(:organization_users, [:organization_id])
    create unique_index(:organization_users, [:organization_id, :user_id])
  end
end
