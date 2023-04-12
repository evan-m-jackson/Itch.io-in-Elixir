defmodule ItchCloneWeb.PageController do
  use ItchCloneWeb, :controller
  alias ItchClone.NewGame

  def home(conn, _params) do
    render conn
  end

  def new(conn, _params) do
    changeset = NewGame.new_game_changeset()

    render conn, user_changeset: changeset
  end
end
