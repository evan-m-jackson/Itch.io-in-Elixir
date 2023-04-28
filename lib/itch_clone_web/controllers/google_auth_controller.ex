defmodule ItchCloneWeb.GoogleAuthController do
  use ItchCloneWeb, :controller
  import Mockery.Macro
  import Plug.Conn

  def index(conn, %{"code" => code}) do
    {:ok, token} = mockable(ElixirAuthGoogle).get_token(code, conn)
    {:ok, profile} = mockable(ElixirAuthGoogle).get_user_profile(token.access_token)

    user_params = %{email: profile.email, token: token.access_token}
    changeset = ItchClone.User.changeset(%ItchClone.User{},user_params)
    {:ok, user} = insert_or_update_user(changeset)

    conn
    |> put_session(:user_id, user.id)
    |> render(:welcome, profile: profile)
  end

  def welcome(conn, %{"profile" => _profile}) do
    render conn
  end

  def insert_or_update_user(changeset) do
    case ItchClone.Repo.get_by(ItchClone.User, email: changeset.changes.email) do
      nil ->
        ItchClone.Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
