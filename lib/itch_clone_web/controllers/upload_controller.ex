defmodule ItchCloneWeb.UploadController do
  use ItchCloneWeb, :controller
  alias Aws
  alias GameFile
  import Mockery.Macro

  def new(conn, _params) do
    render conn
  end

  def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
    s3_filename = "games/#{upload.filename}"

    s3_bucket = "itch-clone"

    file_binary = mockable(GameFile).read(upload.path)

    try do
      mockable(Aws).add(s3_bucket, s3_filename, file_binary)
      json conn, "Uploaded to a temporary directory"
    rescue
      e in RuntimeError -> json conn, "Error"
    end


  end

end
