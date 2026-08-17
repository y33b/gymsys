defmodule GymsysWeb.Plugs.VerifyAuth do
  use GymsysWeb, :controller
  import Plug.Conn
  def init(opts), do: opts
  def call(conn,_opts) do
    case get_session(conn, :id) do
      nil ->
        conn |> put_flash(:error,"error you are not login") |> redirect(to: "/") |> halt()
      _user_id ->
        conn
    end
  end
end
