defmodule ItchCloneWeb.UploadControllerTest do
  use ItchCloneWeb.ConnCase
  alias Aws
  alias GameFile

  import Mockery

  @valid_file %Plug.Upload{filename: "Game.zip", content_type: "application/zip", path: "/absolute_path_to/Game.zip" }

  test "GET /games/new", %{conn: conn} do
    conn = get(conn, ~p"/games/new")
    assert html_response(conn, 200) =~ "Upload files"
  end

  describe "create upload" do
    test "game is successfully uploaded", %{conn: conn} do
      mock GameFile, :read, "somebs"
      mock Aws, :add, :ok
      conn = post(conn, ~p"/games", upload: @valid_file)

      assert json_response(conn, 200) =~ "Uploaded to a temporary directory"
    end
  end
end
