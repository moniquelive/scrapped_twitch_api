defmodule TwitchApi.ApiJson.Template.Method.Headers do
  @moduledoc """
  Provides the methods headers template for a twitch api item module
  """

  alias TwitchApi.OIDC
  alias TwitchApi.AppAccessToken
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.Args

  @doc """
  Provides the twitch api Elixir headers method for a twitch api item
  """
  @spec get_headers(Item.t()) :: String.t() | :not_supported | :oauth
  def get_headers(item) do
    item
    |> valid_item?
    |> parse_headers()
  end

  defp valid_item?(item) do
    authentication = Args.authentication(item)
    authorization = Args.authorization(item)
    valid_header?(authentication, authorization)
  end

  defp valid_header?(_, :not_supported), do: :not_supported
  defp valid_header?(true, _), do: true
  defp valid_header?(_, true), do: true
  defp valid_header?(:oauth, _), do: :oauth
  defp valid_header?(_, :oauth), do: :oauth
  defp valid_header?(_, _), do: false

  defp parse_headers(:not_supported), do: :not_supported
  defp parse_headers(true), do: ",\n    Headers.config_headers()"
  defp parse_headers(:oauth), do: ",\n    Headers.config_oauth_headers(user_info)"
  defp parse_headers(false), do: ",\n    []"

  @doc """
  Parses the twitch api Elixir get_headers method for a twitch api item. If its an OAuth header it config the needed method param.
  """
  @spec parse_get_headers(String.t()) :: parsed_get_headers :: String.t()
  def parse_get_headers(headers) do
    case String.contains?(headers, ["user_info"]) do
      false -> ""
      true -> ", user_info"
    end
  end

  @doc """
  Parses the twitch api Elixir get_headers method for a twitch api item. If its an OAuth header it config the needed method type spec.
  """
  @spec get_oauth_type_spec(String.t()) :: {[type_spec :: String.t()], method_param :: String.t()}
  def get_oauth_type_spec(headers) do
    case String.contains?(headers, ["user_info"]) do
      false ->
        {[], ""}

      true ->
        {[
           """
           @typedoc \"\"\"
             Map containing the user needed information for the fetch of the required user OAuth access token.
             You will be able to choose from one way or the other for fetching previously OAuth access tokens.
             :user_id field contains the user ID from twitch, e.g. 61425548 or \"61425548\"
             :user_name field constains the user name from twitch, e.g. \"hiimkamiyuzu\"
             \"\"\"
             @type user_info :: %{user_id: integer | binary} | %{user_name: binary}
           """
         ], ", user_info"}
    end
  end

  @doc """
  Parses the twitch api Elixir body_params method for a twitch api item
  """
  @spec parse_method_params(String.t(), String.t()) :: parsed_method_params :: String.t()
  def parse_method_params(method_params, "") do
    case method_params do
      "" -> ""
      method_params -> "(" <> method_params <> ")"
    end
  end

  def parse_method_params("", ", " <> headers),
    do: "(" <> headers <> ")"

  def parse_method_params(method_params, headers),
    do: "(" <> method_params <> headers <> ")"

  @doc """
  Parses body specs from a twitch api item
  """
  @spec parse_method_specs(String.t(), String.t()) :: parsed_method_params :: String.t()
  def parse_method_specs("", ", " <> headers), do: headers
  def parse_method_specs(specs, headers), do: specs <> headers

  @doc """
  Configures the headers for the Finch request
  """
  @spec config_headers :: headers :: [{binary, binary}]
  def config_headers do
    wrapped_app_access_token = AppAccessToken.get_app_access_token()
    wrapped_client_id = fn -> System.fetch_env!("client_id") end

    [
      {"Authorization", "Bearer " <> wrapped_app_access_token},
      {"Client-Id", wrapped_client_id.()}
    ]
  end

  @doc """
  Configures the OAuth headers for the Finch request
  """
  @spec config_oauth_headers(map) :: headers :: [{binary, binary}]
  def config_oauth_headers(%{user_id: user_id}) do
    wrapped_oauth_access_token = OIDC.get_access_token_id(user_id)
    wrapped_client_id = fn -> System.fetch_env!("client_id") end

    [
      {"Authorization", "Bearer " <> wrapped_oauth_access_token},
      {"Client-Id", wrapped_client_id.()}
    ]
  end

  def config_oauth_headers(%{user_name: user_name}) do
    wrapped_oauth_access_token = OIDC.get_access_token_name(user_name)
    wrapped_client_id = fn -> System.fetch_env!("client_id") end

    [
      {"Authorization", "Bearer " <> wrapped_oauth_access_token},
      {"Client-Id", wrapped_client_id.()}
    ]
  end
end
