defmodule ItchClone.Repo.Migrations.AlterGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      remove :description, :string
      add :user_id, :integer
    end
  end
end
