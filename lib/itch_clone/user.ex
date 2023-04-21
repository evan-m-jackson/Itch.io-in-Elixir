defmodule ItchClone.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :token, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :token])
    |> validate_required([:email, :token])
  end
end
