defmodule TwitchApi.OIDC.AccessToken do
  @moduledoc """
  This module provides the required logic for dealing with twitch user access token information
  """

  @callback_uri "http://localhost:8090/callback"
  @twitch_jwk_uri "https://id.twitch.tv/oauth2/keys"

  @spec state(binary, TwitchApi.OIDC.state()) :: TwitchApi.OIDC.state()
  def state(code, %TwitchApi.OIDC{users_id: users_id, users_name: users_name} = state) do
    url = generate_authorize_url(code)
    {:ok, resp} = TwitchApi.MyFinch.request(:post, url, [], nil)

    %{
      "access_token" => access_token,
      "id_token" => id_token,
      "refresh_token" => refresh_token,
      "scope" => scope,
      "token_type" => token_type
    } = Jason.decode!(resp.body)

    {:ok, jwk_response} = TwitchApi.MyFinch.request(:get, @twitch_jwk_uri)
    %{"keys" => [jwk]} = Jason.decode!(jwk_response.body)
    {true, _, _} = JOSE.JWT.verify_strict(jwk, [jwk["alg"]], id_token)

    %JOSE.JWT{
      fields: %{
        "exp" => expiration_time,
        "iat" => time_issued,
        "preferred_username" => preferred_username,
        "sub" => user_id
      }
    } = JOSE.JWT.peek_payload(id_token)

    {:ok, issued} = DateTime.from_unix(time_issued)
    {:ok, expiration} = DateTime.from_unix(expiration_time)
    refresh_time = DateTime.diff(expiration, issued)

    user_data = %{
      access_token: access_token,
      refresh_token: refresh_token,
      scope: scope,
      token_type: token_type,
      expiration_time: expiration_time,
      time_issued: time_issued,
      refresh_time: refresh_time
    }

    new_users_id = Map.put(users_id, user_id, user_data)
    new_users_name = Map.put(users_name, preferred_username, user_data)
    %{state | users_id: new_users_id, users_name: new_users_name}
  end

  defp generate_authorize_url(code) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    wrapped_client_secret = fn -> System.fetch_env!("client_secret") end

    "https://id.twitch.tv/oauth2/token"
    |> Kernel.<>("?grant_type=authorization_code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&client_secret=#{wrapped_client_secret.()}")
    |> Kernel.<>("&redirect_uri=#{@callback_uri}")
    |> Kernel.<>("&code=#{code}")
  end
end
