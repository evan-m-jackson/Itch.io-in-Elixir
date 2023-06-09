defmodule Unzip.S3File do
  alias Aws
  alias Temp
  @dialyzer [{:nowarn_function, unzip: 2}, {:nowarn_function, run: 2}]

  def run(bucket, zip_path) do
    zip_file_binary = File.read!(zip_path)
    {:ok, dir_path} = Temp.mkdir("temp-dir")
    {:ok, filelist} = unzip(zip_file_binary, dir_path)
    num = length(filelist) - 1

    Aws.add_multiple(bucket, filelist, num)

    File.rm_rf(dir_path)
  end

  def is_zipped(file_name) do
    if Path.extname(file_name) === ".zip" do
      {:ok, true}
    else
      {:error, "File must be a zipped file (.zip extension)"}
    end
  end

  def unzip(file_binary, directory) do
    :zip.unzip(file_binary, cwd: "#{directory}")
  end
end
