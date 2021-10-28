defmodule TwitchApi.OIDC.AccessToken do
  @moduledoc """
  This module provides the required logic for dealing with twitch user access token information
  """

  require Logger

  alias TwitchApi.OIDC
  alias TwitchApi.SimpleServer.Callback

  @twitch_jwk_uri "https://id.twitch.tv/oauth2/keys"
  @twitch_token_uri "https://id.twitch.tv/oauth2/token"

  @spec request(binary, TwitchApi.OIDC.state()) :: TwitchApi.OIDC.state()
  def request(code, %TwitchApi.OIDC{users_id: users_by_id, users_name: users_by_name} = state) do
    url = generate_authorize_url(code)
    {:ok, resp} = TwitchApi.MyFinch.request(:post, url, [], nil)

    %{
      "access_token" => access_token,
      "id_token" => id_token,
      "refresh_token" => refresh_token,
      "scope" => scope,
      "token_type" => token_type
    } = Jason.decode!(resp.body)

    Logger.debug("Fetched user jwt successfully")

    {:ok, jwk_response} = TwitchApi.MyFinch.request(:get, @twitch_jwk_uri)
    %{"keys" => [jwk]} = Jason.decode!(jwk_response.body)
    {true, _, _} = JOSE.JWT.verify_strict(jwk, [jwk["alg"]], id_token)

    Logger.debug("Validated JWT with Twitch JWK")

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
    refresh_time = DateTime.diff(expiration, issued) - 60

    OIDC.schedule_refresh(user_id, preferred_username, refresh_token, refresh_time)

    user_data = %{
      access_token: access_token,
      refresh_token: refresh_token,
      scope: scope,
      token_type: token_type,
      time_issued: time_issued,
      refresh_time: refresh_time
    }

    Logger.debug("Updating user data with user access token")

    new_users_by_id = Map.put(users_by_id, user_id, user_data)
    new_users_by_name = Map.put(users_by_name, preferred_username, user_data)
    %{state | users_id: new_users_by_id, users_name: new_users_by_name}
  end

  defp generate_authorize_url(code) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    wrapped_client_secret = fn -> System.fetch_env!("client_secret") end
    callback_uri = Callback.callback_uri()

    @twitch_token_uri
    |> Kernel.<>("?grant_type=authorization_code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&client_secret=#{wrapped_client_secret.()}")
    |> Kernel.<>("&redirect_uri=#{callback_uri}")
    |> Kernel.<>("&code=#{code}")
  end

  @spec browse(list, TwitchApi.OIDC.state()) :: TwitchApi.OIDC.state()
  def browse(scope, state) do
    oidc_state = generate_state()
    path = generate_oidc_url(oidc_state, scope)
    Logger.debug("Ask for authorization of the user in URI: #{path}")
    browser_open(path)
    %OIDC{state | state: oidc_state}
  end

  defp browser_open(path) do
    start_browser_command =
      case :os.type() do
        {:win32, _} ->
          "start"

        {:unix, :darwin} ->
          "open"

        {:unix, _} ->
          "xdg-open"
      end

    if System.find_executable(start_browser_command) do
      System.cmd(start_browser_command, [path])
    else
      Mix.raise("Command not found: #{start_browser_command}")
    end
  end

  @spec generate_oidc_url(binary, [scopes :: binary]) :: oauth_url :: binary
  def generate_oidc_url(state, []) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    callback_uri = Callback.callback_uri()

    "https://id.twitch.tv/oauth2/authorize"
    |> Kernel.<>("?response_type=code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&redirect_uri=#{callback_uri}")
    |> Kernel.<>("&scope=openid")
    |> Kernel.<>("&state=#{state}")
  end

  def generate_oidc_url(state, scope) do
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

  @spec refresh(binary, binary, binary, non_neg_integer, TwitchApi.OIDC.state()) ::
          TwitchApi.OIDC.state()
  def refresh(
        user_id,
        user_name,
        refresh_token,
        interval,
        %TwitchApi.OIDC{users_id: users_by_id, users_name: users_by_name} = state
      ) do
    headers = create_refresh_headers()
    url = generate_refresh_token_url(refresh_token)
    {:ok, resp} = TwitchApi.MyFinch.request(:post, url, headers, nil)

    Logger.debug("Refreshed user access token successfully")

    %{"access_token" => new_access_token} = Jason.decode!(resp.body)

    OIDC.schedule_refresh(user_id, user_name, refresh_token, interval)

    new_users_by_id = put_in(users_by_id, [user_id, :access_token], new_access_token)
    new_users_by_name = put_in(users_by_name, [user_name, :access_token], new_access_token)
    %{state | users_id: new_users_by_id, users_name: new_users_by_name}
  end

  defp create_refresh_headers do
    [{"Content-Type", "application/x-www-form-urlencoded"}]
  end

  defp generate_refresh_token_url(refresh_token) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    wrapped_client_secret = fn -> System.fetch_env!("client_secret") end

    @twitch_token_uri
    |> Kernel.<>("?grant_type=refresh_token")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&client_secret=#{wrapped_client_secret.()}")
    |> Kernel.<>("&refresh_token=#{refresh_token}")
  end
end
