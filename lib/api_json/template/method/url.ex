defmodule TwitchApi.ApiJson.Template.Method.Url do
  @moduledoc """
  Provides the method url template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item

  @doc """
  Gets the twitch api Elixir url for a twitch api item
  """
  @spec get_url(Item.t()) :: {binary, binary}
  def get_url(item) do
    case item.request.url do
      [url_item, _, _] ->
        [url, _] = String.split(url_item.url, "?")
        {url_item.method, validate_url(url)}

      [url_item] ->
        {url_item.method, validate_url(url_item.url)}
    end
  end

  defp validate_url(url) do
    case String.contains?(url, "https://api.twitch.tv/") do
      false -> "https://api.twitch.tv/" <> url
      true -> url
    end
  end
end
