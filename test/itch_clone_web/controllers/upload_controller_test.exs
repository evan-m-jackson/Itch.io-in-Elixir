defmodule ItchCloneWeb.UploadControllerTest do
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
      assert html_response(conn, 200) =~ "Upload files"
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

      conn = post(conn, ~p"/games", upload: @valid_file)
      assert html_response(conn, 200) =~ "Play the Game!"
      assert_called(Unzip.S3File, :run)
    end

    test "respond with 422 on unzipped files being uploaded" do
      ItchClone.Repo.insert(@user)
      conn =
        Phoenix.ConnTest.build_conn()
        |> Phoenix.ConnTest.init_test_session(user_id: @user.id)

      conn = post(conn, ~p"/games", upload: @unzipped_file)
      assert(html_response(conn, 422))
    end
  end
end
