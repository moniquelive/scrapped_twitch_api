defmodule TwitchApi.SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  alias TwitchApi.SimpleServer.Callback

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  # Health endpoint for simple web server
  get("/health", do: send_resp(conn, 200, "ok"))

  # Get callback for fetching an authorization code
  get("/callback", do: Callback.call(conn))

  # "Default" route that will get called when no other route is matched
  match(_, do: send_resp(conn, 404, "not found"))
end
