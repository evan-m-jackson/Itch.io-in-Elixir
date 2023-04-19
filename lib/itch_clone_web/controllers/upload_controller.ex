defmodule ItchCloneWeb.UploadController do
  use ItchCloneWeb, :controller
  alias Aws
  alias Unzip
  alias Temp
  alias Unzip.S3File
  import Mockery.Macro

  @s3_bucket "itch-clone1401"

  def new(conn, _params) do
    render conn
  end

  def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
    s3_folder_name = Path.basename(upload.filename, ".zip")
    mockable(Unzip.S3File).run(@s3_bucket, upload.path, s3_folder_name)
    src_url = "http://#{@s3_bucket}.s3-website-us-east-1.amazonaws.com"

    render(conn, :launch, src_url: src_url)
  end

  def launch(conn, %{"src_url" => src_url}) do
   render conn
  end

end
