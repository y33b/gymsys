defmodule GymsysWeb.Router do
  use GymsysWeb, :router
  import GymsysWeb.AuthLive
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GymsysWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
 
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GymsysWeb do
    pipe_through [:browser,GymsysWeb.Plugs.RedirectIfAuth]
    live "/", HomeLive
    post "/login", LoginController, :check  
  end
  scope "/dashboard", GymsysWeb do
    pipe_through :browser
    live_session :authenticated,
                 on_mount: [{GymsysWeb.AuthLive, :ensure_auth}] do
      live "/", DashboardLive
      live "/users",CreateLive
  end
 end
    # scope "/dashboard", GymsysWeb do
  #   pipe_through :auth
  #   live "/", DashboardLive
  #   scope "/user" do
  #     live "/create", CreateLive 
  #   end
  #end
  # Other scopes may use custom stacks.
  # scope "/api", GymsysWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:gymsys, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GymsysWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
