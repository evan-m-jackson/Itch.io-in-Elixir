defmodule ItchCloneWeb.UploadController do
  use ItchCloneWeb, :controller
  alias Aws
  alias Unzip
  alias Temp
  import Mockery.Macro
  @dialyzer {:nowarn_function, create: 2}

  @s3_bucket System.get_env("AWS_S3_BUCKET") || "itch-clone1402"

  def new(conn, _params) do
    render(conn)
  end

  def create(conn, %{"upload" => %Plug.Upload{} = upload}) do
    case Unzip.S3File.is_zipped(upload.filename) do
      {:ok, true} ->
        mockable(Unzip.S3File).run(@s3_bucket, upload.path)

        src_url =
          System.get_env("AWS_S3_URL") ||
            "http://#{@s3_bucket}.s3-website-us-east-1.amazonaws.com"

        render(conn, :launch, src_url: src_url)

      {:error, error_msg} ->
        conn
        |> put_status(422)
        |> assign(:error_msg, error_msg)
        |> render(:new)
    end
  end

  def launch(conn, %{"src_url" => _src_url}) do
    render(conn)
  end
end
