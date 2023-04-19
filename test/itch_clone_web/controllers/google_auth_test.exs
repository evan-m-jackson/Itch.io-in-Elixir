defmodule ItchCloneWeb.GoogleAuthControllerTest do
  use ItchCloneWeb.ConnCase
  import Mockery

  @code "fake-code"
  @token %{access_token: "mock-token"}
  @profile %{given_name: "Mace", email: "mace.windu@gmail.com"}

  describe "Testing Google OAuth Login" do
    test "Get /auth/google/callback", %{conn: conn} do
      mock ElixirAuthGoogle, :get_token, {:ok, @token}
      mock ElixirAuthGoogle, :get_user_profile, {:ok, @profile}

      conn = get(conn, ~p"/auth/google/callback", code: @code)
      assert html_response(conn, 200) =~ "Welcome to the Itch.io Clone, Mace"
      assert html_response(conn, 200) =~ "mace.windu@gmail.com"
    end
  end

end
