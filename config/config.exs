import Config

config :itch_clone, Itch_IO.Repo,
  database: "itch_clone_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :itch_clone,
  ecto_repos: [ItchClone.Repo]

# Configures the endpoint
config :itch_clone, ItchCloneWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ItchCloneWeb.ErrorHTML, json: ItchCloneWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ItchClone.PubSub,
  live_view: [signing_salt: "ys0xteY5"]


config :itch_clone, ItchClone.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
