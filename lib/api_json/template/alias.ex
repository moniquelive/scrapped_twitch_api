defmodule TwitchApi.ApiJson.Template.Alias do
  @moduledoc """
  Provides the aliases template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  Creates a twitch api Elixir alias template
  """
  @spec get_alias(Item.t()) :: binary
  def get_alias(item) do
    headers = Headers.get_headers(item)
    aliased_headers = alias_headers(headers)

    """
    alias TwitchApi.MyFinch
      #{aliased_headers}
    """
  end

  defp alias_headers(",\n    []"), do: ""
  defp alias_headers(_), do: "alias TwitchApi.ApiJson.Template.Method.Headers"
end
