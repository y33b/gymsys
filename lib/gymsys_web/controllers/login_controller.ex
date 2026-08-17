defmodule GymsysWeb.LoginController do
  use GymsysWeb, :controller
  alias Plug.Conn
  alias Gymsys.Accounts
  def check(conn,%{"_csrf_token" =>_csrf_token , "username" => username, "password" => password}) do
    IO.inspect(username)
    case Accounts.get_user_by_username!(username) do
      nil ->
        conn
        |> put_flash(:error, "invalide username or password")
        |> redirect(to: ~p"/")
        |> halt()

      user ->
        if Bcrypt.verify_pass(password,user.password_hash) do
          conn
          |> Conn.put_session(:id, user.id)
          |> Conn.put_session(:username, user.username)
          |> redirect(to: ~p"/dashboard")
          |> halt()
        else
          conn
          |> put_flash(:error, "invalide username or password")
          |> redirect(to: ~p"/")
          |> halt()
        end
    end
  end
end
