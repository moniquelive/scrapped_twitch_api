defmodule TwitchApi.ApiJson.Template.Method.Args.Authentication do
  @moduledoc """
  Provides the authentication arguments methods validation for a twitch api item module
  """

  @oauth ["OAuth", "User", "user"]
  @app ["App", "app"]

  @doc """
  Provides the twitch api Elixir authorization for a twitch api request authentication item
  """
  @spec parse_authentication([String.t()]) :: boolean | :oauth
  def parse_authentication(authentication) when length(authentication) > 0 do
    app = has_app?(authentication)
    oauth = has_oauth?(authentication)
    is_valid?(app, oauth)
  end

  def parse_authentication(_), do: false

  defp is_valid?(true, _), do: true
  defp is_valid?(_, true), do: :oauth
  defp is_valid?(false, false), do: false

  defp has_app?(authentication) do
    authentication
    |> Enum.map(&authentication_app/1)
    |> Enum.any?(&(&1 == true))
  end

  defp authentication_app(token), do: String.contains?(token, @app)

  defp has_oauth?(authentication) do
    authentication
    |> Enum.map(&authentication_oauth/1)
    |> Enum.any?(&(&1 == true))
  end

  defp authentication_oauth(token), do: String.contains?(token, @oauth)
end
