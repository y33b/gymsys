defmodule Gymsys.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :password_hash, :string
      add :name, :string
      add :is_active, :boolean, default: false, null: false
      add :last_login, :utc_datetime
      add :group_id, references(:groups, on_delete: :restrict, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:username])
    create index(:users, [:group_id])
  end
end
