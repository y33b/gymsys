defmodule Gymsys.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permissions" do
    field :code, :string
    field :name, :string
    field :module, :string
    many_to_many :groups, Gymsys.Group,
      join_through: "group_permissions"
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:code, :name, :module])
    |> validate_required([:code, :name, :module])
    |> unique_constraint(:code)
  end
end
