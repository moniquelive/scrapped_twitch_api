defmodule TwitchApi.SimpleServer.Callback do
  @moduledoc """
  This module provides the required logic for the callback endpoint
  """

  import Plug.Conn

  alias TwitchApi.OIDC

  @spec call(Plug.Conn.t()) :: Plug.Conn.t()
  def call(conn) do
    conn = fetch_query_params(conn)
    query_params = conn.query_params
    %{"state" => state} = query_params
    ^state = OIDC.get_state()
    OIDC.request_access_token(query_params)
    send_resp(conn, 200, "ok")
  end
end
