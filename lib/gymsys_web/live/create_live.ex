defmodule GymsysWeb.CreateLive do
  use GymsysWeb, :live_view
  on_mount {GymsysWeb.AuthLive, {:permission, "user.edite"}}
  @impl true
  def mount(_params,_session, socket) do
    {:ok, socket}
  end
  @impl true
  def render(assigns) do
    ~H"""
    hello
    """
  end
end
