defmodule TwitchApi.ApiJson.Template.Method.Args.Authorization do
  @moduledoc """
  Provides the authorization arguments methods validation for a twitch api item module
  """

  @oauth ["OAuth", "User", "user"]
  @jwt ["JWT"]
  @app ["App", "app", "application", "access"]

  @doc """
  Provides the twitch api Elixir authorization for a twitch api request authorization item
  """
  @spec parse_authorization([String.t()]) :: boolean() | :not_supported | :oauth
  def parse_authorization(authorization) when length(authorization) > 0 do
    app = has_app?(authorization)
    oauth = has_oauth?(authorization)
    jwt = has_jwt?(authorization)
    is_valid?(app, oauth, jwt)
  end

  def parse_authorization(_), do: false

  defp is_valid?(_, _, true), do: :not_supported
  defp is_valid?(true, _, _), do: true
  defp is_valid?(_, true, _), do: :oauth
  defp is_valid?(_, _, _), do: false

  defp has_app?(authorization) do
    authorization
    |> Enum.map(&authorization_app/1)
    |> Enum.any?(&(&1 == true))
  end

  defp authorization_app(token), do: String.contains?(token, @app)

  defp has_oauth?(authorization) do
    authorization
    |> Enum.map(&authorization_oauth/1)
    |> Enum.any?(&(&1 == true))
  end

  defp authorization_oauth(token), do: String.contains?(token, @oauth)

  defp has_jwt?(authorization) do
    authorization
    |> Enum.map(&authorization_jwt/1)
    |> Enum.any?(&(&1 == true))
  end

  defp authorization_jwt(token), do: String.contains?(token, @jwt)
end
