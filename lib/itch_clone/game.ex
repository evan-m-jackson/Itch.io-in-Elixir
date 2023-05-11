defmodule ItchClone.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :user_id, :integer
    field :title, :string
    field :url, :string
    field :file, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:title, :url, :file, :user_id])
    |> validate_required([:title, :url, :file, :user_id])
  end
end
