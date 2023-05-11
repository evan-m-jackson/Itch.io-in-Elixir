defmodule ItchCloneWeb.PageControllerTest do
  use ItchCloneWeb.ConnCase

  @user %ItchClone.User{id: 1, email: "macewindu@example.com", token: "123456abcdef"}

  describe "the home page" do
    test "when a user hasn't signed in yet", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "Dashboard"
      assert html_response(conn, 200) =~ "Add New Project"
      assert html_response(conn, 200) =~ "GitHub"
      assert html_response(conn, 200) =~ "Welcome to the Itch.io Clone"
      assert html_response(conn, 200) =~ "To get started, login to your Google Account:"
      assert html_response(conn, 200) =~ "Sign in with Google"
    end

    test "when a user is signed" do
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "Add New Project"
      assert html_response(conn, 200) =~ "GitHub"
      assert html_response(conn, 200) =~ "Welcome to the Itch.io Clone"
      assert html_response(conn, 200) =~ "You are logged in!"
      assert html_response(conn, 200) =~ "Sign Out"
    end
  end

  test "GET /new", %{conn: conn} do
    conn = get(conn, ~p"/new")
    assert html_response(conn, 200) =~ "Create a new project"
    assert html_response(conn, 200) =~ "Title"
    assert html_response(conn, 200) =~ "Project URL"
    assert html_response(conn, 200) =~ "Short description or tagline"
    assert html_response(conn, 200) =~ "Uploads"
    assert html_response(conn, 200) =~ "Upload files"
    assert html_response(conn, 200) =~ "Details"
    assert html_response(conn, 200) =~ "Game Description"
    assert html_response(conn, 200) =~ "Save & view page"
  end
end
