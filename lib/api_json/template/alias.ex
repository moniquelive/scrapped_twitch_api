defmodule TwitchApi.ApiJson.Template.Alias do
  @moduledoc """
  Provides the aliases template for a twitch api item module
  """

  @doc """
  Creates a twitch api Elixir alias template
  """
  @spec get_alias() :: binary
  def get_alias() do
    """
    alias TwitchApi.MyFinch
    """
  end
end
