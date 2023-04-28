defmodule ItchCloneWeb.SignOutController do
  use ItchCloneWeb, :controller
  import Plug.Conn

  def create(conn, _params) do
    conn
    |> Plug.Conn.clear_session()
    |> redirect(to: "/")
  end
end
