defmodule ItchCloneWeb.SignOutControllerTest do
  use ItchCloneWeb.ConnCase
  import Phoenix.ConnTest

  @user %ItchClone.User{id: 1, email: "macewindu@example.com", token: "123456abcdef"}

  describe "user signs out" do
    test "session is cleared of user_id" do
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/signout")
      assert Plug.Conn.get_session(conn, :user_id) == nil
    end

    test "gets redirected to home page" do
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/signout")
      assert html_response(conn, 302)
    end
  end
end
