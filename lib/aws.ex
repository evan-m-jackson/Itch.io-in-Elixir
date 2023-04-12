defmodule Aws do
  @callback add(String.t(), String.t(), String.t()) :: :ok

  def add(bucket, filename, filebinary) do
    ExAws.S3.put_object(bucket, filename, filebinary)
    |> ExAws.request()
    :ok
  end
end
