defmodule ItchCloneWeb.UploadControllerTest do
  use ItchCloneWeb.ConnCase

  test "GET /games/new", %{conn: conn} do
    conn = get(conn, ~p"/games/new")
    assert html_response(conn, 200) =~ "Upload files"
  end
end
