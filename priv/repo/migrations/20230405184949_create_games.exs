defmodule ItchClone.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :title, :string
      add :url, :string
      add :description, :string

      timestamps()
    end
  end
end
