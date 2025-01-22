defmodule LiveSvelteSsrBench.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {NodeJS.Supervisor, [path: LiveSvelte.SSR.NodeJS.server_path(), pool_size: 4]},
      LiveSvelteSsrBenchWeb.Telemetry,
      {DNSCluster,
       query: Application.get_env(:live_svelte_ssr_bench, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveSvelteSsrBench.PubSub},
      # Start a worker by calling: LiveSvelteSsrBench.Worker.start_link(arg)
      # {LiveSvelteSsrBench.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveSvelteSsrBenchWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveSvelteSsrBench.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveSvelteSsrBenchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
