defmodule ItchCloneWeb.AuthoriseUser do
  use ItchCloneWeb, :controller
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    current_user = conn.assigns[:user]
    if current_user == nil do
      conn
      |> redirect(to: "/")
      |> halt()
    else
      assign(conn, :user, current_user)
    end
  end
end
