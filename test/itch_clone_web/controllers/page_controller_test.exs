defmodule ItchCloneWeb.PageControllerTest do
  use ItchCloneWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Hello world!"
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
