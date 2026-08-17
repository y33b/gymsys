defmodule Gymsys.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :password_hash, :string
    field :name, :string
    field :is_active, :boolean, default: false
    field :last_login, :utc_datetime
    belongs_to :group, Gymsys.Group

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :name, :is_active, :last_login,:group_id])
    |> validate_required([:username, :password_hash, :name, :is_active,:group_id])
    |> unique_constraint(:username)
  end
end
