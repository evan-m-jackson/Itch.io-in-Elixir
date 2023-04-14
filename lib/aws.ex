defmodule Aws do

  def add(bucket, filename, filebinary) do
    ExAws.S3.put_object(bucket, filename, filebinary)
    |> ExAws.request()
    :ok
  end

  def get(bucket, filename) do
    ExAws.S3.get_object(bucket, filename)
    |> ExAws.request()
  end

  def add_multiple(bucket, folder, filelist, n) when n == 0 do
    add_multiple_helper(bucket, folder, filelist, n)
  end

  def add_multiple(bucket, folder, filelist, n) do
    add_multiple_helper(bucket, folder, filelist, n)
    add_multiple(bucket, folder, filelist, n - 1)
  end

  def add_multiple_helper(bucket, folder, filelist, n) do
    file_path = Enum.at(filelist, n)
    IO.puts(file_path)
    file_binary = File.read!(file_path)
    filename = "#{folder}/#{Path.basename(file_path)}"
    add(bucket, filename, file_binary)
  end

end
