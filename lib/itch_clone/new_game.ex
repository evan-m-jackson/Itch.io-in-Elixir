defmodule ItchClone.NewGame do

  import Ecto.Changeset
  alias ItchClone.Game
  alias ItchClone.Repo

  def create_game(params) do
    new_game_changeset(params)
    |> Repo.insert
  end

  def new_game_changeset(params \\ %{}) do
    %Game{}
    |> cast(params, [:title, :url, :file, :description])
    |> validate_required([:title, :url, :file, :description])
  end

end
