defmodule ItchCloneWeb.PageController do
  use ItchCloneWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render conn
  end

  def new(conn, _params) do
    render conn
  end
end
