defmodule TwitchApi.ApiJson.Template.Method.Headers do
  @moduledoc """
  Provides the methods headers template for a twitch api item module
  """
  alias TwitchApi.AppAccessToken
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.Args

  @doc """
  Provides the twitch api Elixir headers method for a twitch api item
  """
  @spec get_headers(Item.t()) :: String.t() | :not_supported
  def get_headers(item) do
    item
    |> valid_item?
    |> parse_headers()
  end

  defp valid_item?(item) do
    case Args.authentication(item) do
      false -> Args.authentication(item) or Args.authorization(item)
      :not_supported -> :not_supported
      true -> Args.authentication(item) or Args.authorization(item)
    end
  end

  defp parse_headers(:not_supported), do: :not_supported
  defp parse_headers(true), do: ",\n    Headers.config_headers()"
  defp parse_headers(false), do: ",\n    []"

  @doc """
  Parses the twitch api Elixir body_params method for a twitch api item
  """
  @spec parse_method_params(String.t()) :: parsed_method_params :: String.t()
  def parse_method_params(method_params) do
    case method_params do
      "" -> ""
      method_params -> "(" <> method_params <> ")"
    end
  end

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
end
