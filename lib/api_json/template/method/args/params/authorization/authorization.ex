defmodule TwitchApi.ApiJson.Template.Method.Args.Authorization do
  @moduledoc """
  Provides the authorization arguments methods validation for a twitch api item module
  """

  @doc """
  Provides the twitch api Elixir authorization for a twitch api request authorization item
  """
  @spec parse_authorization([String.t()]) :: boolean()
  def parse_authorization(authorization) when length(authorization) > 0, do: true
  def parse_authorization(_), do: false
end
