defmodule GymsysWeb.DashboardLive do
  use GymsysWeb, :live_view
  @impl true
  def mount(_params, session, socket) do
    
    {:ok,assign(socket, :id, session["id"])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    hello to dashboard {@id}
    """
  end
end
