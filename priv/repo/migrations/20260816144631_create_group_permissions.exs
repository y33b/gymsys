defmodule Gymsys.Repo.Migrations.CreateGroupPermissions do
  use Ecto.Migration

  def change do
     create table(:group_permissions, primary_key: false) do
      add :group_id, references(:groups, type: :binary_id, on_delete: :delete_all),
          primary_key: true

      add :permission_id,
          references(:permissions, type: :binary_id, on_delete: :delete_all),
          primary_key: true
    end
  end
end
