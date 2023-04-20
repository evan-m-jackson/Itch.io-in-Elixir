defmodule Unzip.S3File do
  alias Aws
  alias Temp

  def run(bucket, zip_path, zip_folder_name) do
    zip_file_binary = File.read!(zip_path)
    {:ok, dir_path} = Temp.mkdir "temp-dir"
    {:ok, filelist} = unzip(zip_file_binary, dir_path)
    num = length(filelist) - 1

    Aws.add_multiple(bucket, zip_folder_name, filelist, num)

    File.rm_rf dir_path
  end

  def unzip(file_binary, directory) do
    :zip.unzip(file_binary, cwd: "#{directory}")
  end
end
