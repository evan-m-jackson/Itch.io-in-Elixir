defmodule ItchClone.File.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploads" do
    field :content_type, :string
    field :filename, :string
    field :size, :integer

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:filename, :size, :content_type])
    |> validate_required([:filename, :size, :content_type])

    |> validate_number(:size, greater_than: 0)
  end
end
