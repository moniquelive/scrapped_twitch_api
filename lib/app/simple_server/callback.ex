defmodule TwitchApi.SimpleServer.Callback do
  @moduledoc """
  This module provides the required logic for the callback endpoint
  """

  import Plug.Conn

  alias TwitchApi.OIDC

  @spec call(Plug.Conn.t()) :: Plug.Conn.t()
  def call(conn) do
    conn = fetch_query_params(conn)
    OIDC.request_access_token(conn.query_params)
    send_resp(conn, 200, "ok")
  end

  @spec callback_uri :: callback_uri :: binary
  def callback_uri do
    port = Application.get_env(:scrapped_twitch_api, :callback_port)
    uri = Application.get_env(:scrapped_twitch_api, :callback_uri)
    protocol = Application.get_env(:scrapped_twitch_api, :callback_protocol)

    "#{protocol}://#{uri}:#{port}/callback"
  end
end
