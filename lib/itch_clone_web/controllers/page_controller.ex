defmodule ItchCloneWeb.PageController do
  use ItchCloneWeb, :controller
  import Plug.Conn

  def home(conn, _params) do
    oauth_google_url = ElixirAuthGoogle.generate_oauth_url(conn)
    render(conn, :home, oauth_google_url: oauth_google_url)
  end

  def new(conn, _params) do
    render conn
  end

end
