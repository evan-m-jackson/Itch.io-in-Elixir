defmodule ItchCloneWeb.UploadControllerTest do
  use ItchCloneWeb.ConnCase
  alias Aws
  alias GameFile
  import Mockery
  import Plug.Test
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

  test "GET /games/new", %{conn: conn} do
    conn = Phoenix.ConnTest.build_conn()
      |> assign(:user, @user)

    conn = get(conn, ~p"/games/new")
    assert html_response(conn, 200) =~ "Create a new project"
    assert html_response(conn, 200) =~ "Upload files"
  end

  describe "create upload" do
    test "game is successfully uploaded", %{conn: conn} do
      mock Unzip.S3File, :run, :ok
      conn = Phoenix.ConnTest.build_conn()
      |> assign(:user, @user)

      conn = post(conn, ~p"/games", upload: @valid_file)
      assert html_response(conn, 200) =~ "Play the Game!"
      assert_called(Unzip.S3File, :run)
    end

    test "respond with 422 on unzipped files being uploaded", %{conn: conn} do
      conn = post(conn, ~p"/games", upload: @unzipped_file)

      assert(html_response(conn, 422))
    end
  end
end
