defmodule ItchCloneWeb.UploadController do
  use ItchCloneWeb, :controller

  def new(conn, _params) do
    render conn
  end

  def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
    s3_filename = "games/#{upload.filename}"

    s3_bucket = "itch-clone"

    file_binary = File.read!(upload.path)

    try do
      ExAws.S3.put_object(s3_bucket, s3_filename, file_binary)
      |> ExAws.request()

      json conn, "Uploaded #{upload.path} to a temporary directory"
    catch
      :error -> json conn, "Error"
    end
  end

end
