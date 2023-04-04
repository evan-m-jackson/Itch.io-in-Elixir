defmodule ItchClone.Repo do
  use Ecto.Repo,
    otp_app: :itch_clone,
    adapter: Ecto.Adapters.Postgres
end
