defmodule GymsysWeb.HomeLive do
  use GymsysWeb, :live_view
  @impl true
  def render(assigns) do
    ~H"""
    <h1>Welcome to the dashboard login </h1>
    <.form action="/login" method="post" >
      <input type="text" name="username" />
      <input type="password" name="password" />
      <.button>submit</.button>
    </.form>
    <div id="info">{Phoenix.Flash.get(@flash, :error)}</div>
    """
  end
  @impl true
  def mount(_params, _session, socket) do
    {:ok,socket}
  end

end
