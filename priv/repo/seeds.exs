# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gymsys.Repo.insert!(%Gymsys.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Gymsys.Repo
alias Gymsys.Accounts.User
alias Gymsys.Group
alias Gymsys.Permission

permission = %Permission{} |> Permission.changeset(%{code: "user.create", name: "Create user", module: "user"}) |> Repo.insert!()

group_admin = %Group{} |> Group.changeset(%{name: "Admin"}) |> Repo.insert!()
Repo.insert_all("group_permissions", [
  %{
    group_id: Ecto.UUID.dump!(group_admin.id),
    permission_id: Ecto.UUID.dump!(permission.id)
  }
])

admin_user = %User{} |> User.changeset(%{username: "admin",password_hash: Bcrypt.hash_pwd_salt("admin123"),name: "youssef", is_active: true, group_id: group_admin.id})
Repo.insert!(admin_user)
