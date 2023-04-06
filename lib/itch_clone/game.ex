defmodule ItchClone.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :description, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:title, :url, :description])
    |> validate_required([:title, :url, :description])
  end
end
