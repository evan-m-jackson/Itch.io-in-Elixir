defmodule ItchClone.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ItchCloneWeb.Telemetry,
      # Start the Ecto repository
      ItchClone.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ItchClone.PubSub},
      # Start Finch
      {Finch, name: ItchClone.Finch},
      # Start the Endpoint (http/https)
      ItchCloneWeb.Endpoint
      # Start a worker by calling: ItchClone.Worker.start_link(arg)
      # {ItchClone.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ItchClone.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ItchCloneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
