defmodule TwitchApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Plug.Adapters.Cowboy

  def start(_type, _args) do
    children = [
      {Finch, name: MyFinch},
      {TwitchApi.AppAccessToken, []},
      {TwitchApi.OIDC, []},
      Cowboy.child_spec(scheme: :http, plug: TwitchApi.SimpleServer.Router, options: [port: 8090])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwitchApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
