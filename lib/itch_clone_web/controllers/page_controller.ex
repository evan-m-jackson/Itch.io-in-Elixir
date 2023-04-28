defmodule ItchCloneWeb.PageController do
  use ItchCloneWeb, :controller
  alias ItchClone.NewGame
  import Plug.Conn

  def home(conn, _params) do
    oauth_google_url = ElixirAuthGoogle.generate_oauth_url(conn)
    render(conn, :home, oauth_google_url: oauth_google_url)
  end

  def new(conn, _params) do
    changeset = NewGame.new_game_changeset()

    render conn, user_changeset: changeset
  end

end
