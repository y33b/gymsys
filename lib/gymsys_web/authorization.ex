defmodule GymsysWeb.Authorization do
  alias Gymsys.Repo
  alias Gymsys.Accounts
  import Ecto.Query, only: [from: 2]
  def has_permission?(user_id, permission) do
    user = Accounts.get_user!(user_id)
    group_id = user.group_id
    query =
  from gp in "group_permissions",
    join: p in "permissions",
    on: p.id == gp.permission_id,
    where: gp.group_id == type(^group_id, :binary_id),
    where: p.code == ^permission,
    select: p.id
    Repo.exists?(query)
    IO.inspect(Repo.exists?(query))
  end
end
