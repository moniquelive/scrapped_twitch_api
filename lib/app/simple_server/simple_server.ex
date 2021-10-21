defmodule TwitchApi.SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  alias TwitchApi.OIDC

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  # Health endpoint for simple web server
  get("/health", do: send_resp(conn, 200, "ok"))

  # Get callback for fetching an authorization code
  get "/callback" do
    conn = fetch_query_params(conn)
    %{"state" => state} = conn.query_params
    ^state = OIDC.get_state()
    OIDC.request_access_token(conn.query_params)
    send_resp(conn, 200, "ok")
  end

  # Post callback to authorize the previously requested code
  post "/callback" do
    {:ok, body, conn} = read_body(conn)
    body = Jason.decode!(body)
    send_resp(conn, 201, "created: #{inspect(body)}")
  end

  # "Default" route that will get called when no other route is matched
  match(_, do: send_resp(conn, 404, "not found"))
end
