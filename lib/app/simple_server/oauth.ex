defmodule TwitchApi.SimpleServer.Oauth do
  @moduledoc """
  This module provides the required logic for the oauth endpoint
  """

  import Plug.Conn

  alias TwitchApi.OIDC
  alias TwitchApi.SimpleServer.Callback

  @spec call(Plug.Conn.t()) :: Plug.Conn.t()
  def call(conn) do
    conn = fetch_query_params(conn)
    query_params = conn.query_params
    %{"scopes" => scopes} = query_params
    state = generate_state()
    url = generate_oidc_url(state, scopes)
    OIDC.add_to_state(state)
    conn |> resp(:found, "ok") |> Plug.Conn.put_resp_header("location", url)
  end

  @spec generate_oidc_url(binary, [scopes :: binary]) :: oauth_url :: binary
  defp generate_oidc_url(state, [""]) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    callback_uri = Callback.callback_uri()

    "https://id.twitch.tv/oauth2/authorize"
    |> Kernel.<>("?response_type=code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&redirect_uri=#{callback_uri}")
    |> Kernel.<>("&scope=openid")
    |> Kernel.<>("&state=#{state}")
  end

  defp generate_oidc_url(state, scope) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    callback_uri = Callback.callback_uri()
    scopes = Enum.join(scope, "+")

    "https://id.twitch.tv/oauth2/authorize"
    |> Kernel.<>("?response_type=code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&redirect_uri=#{callback_uri}")
    |> Kernel.<>("&scope=#{scopes}+openid")
    |> Kernel.<>("&state=#{state}")
  end

  defp generate_state, do: UUID.uuid1()
end
