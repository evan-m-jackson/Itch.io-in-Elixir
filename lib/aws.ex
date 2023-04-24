defmodule Aws do

  def add(bucket, filename, filebinary) do
    content_type = MIME.from_path(filename)
    ExAws.S3.put_object(bucket, filename, filebinary, [content_type: content_type])
    |> ExAws.request()
    :ok
  end

  def get(bucket, filename) do
    ExAws.S3.get_object(bucket, filename)
    |> ExAws.request()
  end

  def add_multiple(bucket, filelist, n) when n == 0 do
    add_multiple_helper(bucket, filelist, n)
  end

  def add_multiple(bucket, filelist, n) do
    add_multiple_helper(bucket, filelist, n)
    add_multiple(bucket, filelist, n - 1)
  end

  def add_multiple_helper(bucket, filelist, n) do
    file_path = Enum.at(filelist, n)
    IO.puts(file_path)
    file_binary = File.read!(file_path)
    filename = "#{Path.basename(file_path)}"
    add(bucket, filename, file_binary)
  end

  def create_bucket(name, region) do
    code = to_string(:rand.uniform(10000))
    s3_bucket = "#{name}#{code}"
    ExAws.S3.put_bucket(s3_bucket, region)
    |> ExAws.request()
    s3_bucket
  end

end
