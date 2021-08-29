defmodule TwitchApi.ApiJson.Template.Method.Headers do
  @moduledoc """
  Provides the methods headers template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.Args

  @doc """
  Provides the twitch api Elixir headers method for a twitch api item
  """
  @spec get_headers(Item.t()) :: String.t()
  def get_headers(item) do
    authorization = Args.authorization(item)
    authentication = Args.authentication(item)
    parse_headers(authorization or authentication)
  end

  @spec parse_headers(boolean) :: String.t()
  def parse_headers(true), do: ",\n    TwitchApi.ApiJson.Template.Method.Headers.config_headers()"

  def parse_headers(false), do: ",\n    []"

  @spec config_headers() :: [{binary, binary}]
  def config_headers() do
    wrapped_authorization = fn -> System.fetch_env!("authorization") end
    wrapped_client_id = fn -> System.fetch_env!("client_id") end

    [
      {"Authorization", "Bearer " <> wrapped_authorization.()},
      {"Client-Id", wrapped_client_id.()}
    ]
  end
end
