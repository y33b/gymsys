defmodule GymsysWeb.Plugs.RedirectIfAuth do
  import Phoenix.Controller, only: [redirect: 2]
  import Plug.Conn
  def init(opts) do
    opts
  end
  def call(conn,_opts) do
    case get_session(conn,:user_id) do
      nil ->
        conn
      _user_id ->
        conn |> redirect(to: "/dashboard") |> halt()
    end
  end
end
