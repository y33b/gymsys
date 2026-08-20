defmodule GymsysWeb.CreateLive do
  use GymsysWeb, :live_view
  alias GymsysWeb.Authorization
  @impl true
  def mount(_params,_session, socket) do
    IO.inspect(connected?(socket), label: "CONNECTED")
    {:ok, socket}
  end
  @impl true
  def render(assigns) do
    ~H"""
      hello
    <div :if={can?(assigns.current_user, "user.create")}>
      can create user
    </div>
    """
  end
  def can?(user, permission) do
    Authorization.has_permission?(user.id, permission)
  end
end
