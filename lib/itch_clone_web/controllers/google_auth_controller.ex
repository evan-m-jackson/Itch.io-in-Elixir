defmodule ItchCloneWeb.GoogleAuthController do
  use ItchCloneWeb, :controller
  import Mockery.Macro

  def index(conn, %{"code" => code}) do
    {:ok, token} = mockable(ElixirAuthGoogle).get_token(code, conn)
    {:ok, profile} = mockable(ElixirAuthGoogle).get_user_profile(token.access_token)
    conn
    |> render(:welcome, profile: profile)
  end

  def index(conn) do
    render conn
  end

  def welcome(conn, %{"profile" => profile}) do
    render conn
  end
end
