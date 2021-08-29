defmodule TwitchApi.ApiJson.Template.Method.Args.Authentication do
  @moduledoc """
  Provides the authentication arguments methods validation for a twitch api item module
  """

  @doc """
  Provides the twitch api Elixir authorization for a twitch api request authentication item
  """
  @spec parse_authentication([String.t()]) :: boolean
  def parse_authentication(authentication) when length(authentication) > 0, do: true
  def parse_authentication(_), do: false
end
