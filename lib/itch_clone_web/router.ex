defmodule ItchCloneWeb.Router do
  alias ItchCloneWeb.PageController
  alias ItchCloneWeb.UploadController
  alias ItchCloneWeb.GoogleAuthController
  use ItchCloneWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ItchCloneWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ItchCloneWeb.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ItchCloneWeb.AuthoriseUser
  end

  scope "/" do
    pipe_through :browser

    get "/", PageController, :home

    get "/new", PageController, :new

    get "/signout", PageController, :signout

    get "/launch", UploadController, :launch

    get "/auth/google/callback", GoogleAuthController, :index
  end

  scope "/" do
    pipe_through [:browser, :auth]

    resources "/games", UploadController, only: [:index, :new, :create, :show]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:itch_clone, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ItchCloneWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
