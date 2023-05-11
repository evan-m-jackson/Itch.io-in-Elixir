defmodule ItchCloneWeb.GameController do
  use ItchCloneWeb, :controller
  alias Aws
  alias Unzip
  alias Temp
  import Mockery.Macro
  @dialyzer {:nowarn_function, create: 2}

  @s3_bucket System.get_env("AWS_S3_BUCKET") || "itch-clone1402"

  def new(conn, _params) do
    render conn
  end

  def create(conn, %{"upload" => %Plug.Upload{} = upload, "title" => title}) do
    real_title = String.trim(title)
    if String.length(real_title) == 0 do
      conn
      |> put_status(422)
      |> assign(:error_msg, "Title can't be blank")
      |> render(:new)
    else
      case Unzip.S3File.is_zipped(upload.filename) do
        {:ok, true} ->
          mockable(Unzip.S3File).run(@s3_bucket, upload.path)

          src_url =
            System.get_env("AWS_S3_URL") ||
              "http://#{@s3_bucket}.s3-website-us-east-1.amazonaws.com"

          new_game = %ItchClone.Game{title: title, url: src_url, user_id: Plug.Conn.get_session(conn, :user_id)}
          ItchClone.Repo.insert(new_game)
          render(conn, :launch, src_url: src_url)

        {:error, error_msg} ->
          conn
          |> put_status(422)
          |> assign(:error_msg, error_msg)
          |> render(:new)
      end
    end
  end

  def index(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :user_id)
    game_list = ItchClone.Repo.all(ItchClone.Game, user_id: user_id)
    render(conn, game_list: game_list, user_id: user_id)
  end

  def launch(conn, %{"src_url" => _src_url}) do
    render(conn)
  end
end
