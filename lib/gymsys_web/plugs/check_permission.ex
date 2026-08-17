defmodule GymsysWeb.Plugs.CheckPermission do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2,put_flash: 3]
  import GymsysWeb.Authorization
  def init(opts) do
    Map.new(opts)
  end
  def call(conn,opts) do
    user_id = get_session(conn,:id)
    case has_permission?(user_id, opts[:permission]) do
      false  ->
        conn |> put_flash(:permission_erorr,"You don't have permission") |> redirect(to: "/Dashboard") |> halt()
      _ ->
        conn
    end
  end
end
