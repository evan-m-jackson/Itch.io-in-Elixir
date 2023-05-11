defmodule ItchCloneWeb.GameControllerTest do
  use ItchCloneWeb.ConnCase
  alias Aws
  alias GameFile
  import Mockery
  import Phoenix.ConnTest
  import Mockery.Assertions

  @valid_file %Plug.Upload{
    filename: "Game.zip",
    content_type: "application/zip",
    path: "/absolute_path_to/Game.zip"
  }
  @unzipped_file %Plug.Upload{
    filename: "Game_Not_Zipped",
    content_type: "application/zip",
    path: "/absolute_path_to/Game_Not_Zipped"
  }
  @user %ItchClone.User{id: 1, email: "macewindu@example.com", token: "123456abcdef"}

  describe "add a new game page" do
    test "user is logged in and can access page" do
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = get(conn, ~p"/games/new")
      assert html_response(conn, 200) =~ "Create a new project"
      assert html_response(conn, 200) =~ "Title"
      assert html_response(conn, 200) =~ "Uploads"
      assert html_response(conn, 200) =~ "Save &amp; launch"
    end

    test "user is not logged in and gets redirected to home page" do
      conn = Phoenix.ConnTest.build_conn()
      conn = get(conn, ~p"/games/new")
      assert html_response(conn, 302)
    end
  end


  describe "create upload" do
    test "game is successfully uploaded" do
      mock Unzip.S3File, :run, :ok
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/games", upload: @valid_file, title: "New Game")
      assert html_response(conn, 200) =~ "Play the Game!"
      assert_called(Unzip.S3File, :run)
    end

    test "respond with 422 on unzipped files being uploaded" do
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/games", upload: @unzipped_file, title: "New Game")
      assert(html_response(conn, 422))
    end

    test "game is added to Repo" do
      mock Unzip.S3File, :run, :ok
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/games", upload: @valid_file, title: "New Game")
      game = ItchClone.Repo.get_by(ItchClone.Game, title: "New Game")
      assert game != nil
    end

    test "game is not added to Repo when title inputted is blank" do
      mock Unzip.S3File, :run, :ok
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/games", upload: @valid_file, title: "")
      game = ItchClone.Repo.get_by(ItchClone.Game, title: "")
      assert game == nil
    end
  end

  describe "user dashboard" do
    test "gets redirected to home page when user is not signed in" do
      conn = Phoenix.ConnTest.build_conn()
      conn = get(conn, ~p"/games")
      assert html_response(conn, 302)
    end

    test "shows user's list of games uploaded" do
      game = %ItchClone.Game{title: "First Game", url: "https://example.com", user_id: 1}
      ItchClone.Repo.insert(@user)
      ItchClone.Repo.insert(game)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)


      conn = get(conn, ~p"/games")
      assert html_response(conn, 200) =~ "Creator Dashboard"
      assert html_response(conn, 200) =~ "First Game"
    end

    test "only shows games for applicable user id" do
      game = %ItchClone.Game{title: "First Game", url: "https://example.com", user_id: 2}
      ItchClone.Repo.insert(@user)
      ItchClone.Repo.insert(game)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)


      conn = get(conn, ~p"/games")
      assert html_response(conn, 200) =~ "Creator Dashboard"
      refute html_response(conn, 200) =~ "First Game"
    end
  end
end
