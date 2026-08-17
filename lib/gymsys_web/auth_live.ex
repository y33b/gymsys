defmodule GymsysWeb.AuthLive do
  import Phoenix.LiveView

  def on_mount({:permission,permission},_params,session,socket) do
    user_id = session["id"]
    if(GymsysWeb.Authorization.has_permission?(user_id, permission)) do
      {:cont, socket}
    else
      {:halt, redirect(socket,to: "/dashboard")}
    end
   
  end
end
